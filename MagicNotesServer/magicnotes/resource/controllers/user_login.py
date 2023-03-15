# Login HTTP method
import json
import time

from flask import request, Blueprint
from flask_restful import Resource

from magicnotes.database.db import create_auth
from magicnotes.database.db import create_db
from magicnotes.resource.models.response import Response

user_login_bp = Blueprint('UserLogin', __name__)


class UserLogin(Resource):
    auth = create_auth()
    db = create_db()
    user_ref = db.collection('user')

    def post(self, auth=auth, user_ref=user_ref):
        try:
            # print("data", request.json)
            data = request.get_json()
            user_email = data['userEmail']
            user_password = data['userPassword']

            # Đăng nhập
            user = auth.sign_in_with_email_and_password(user_email, user_password)
            user_info = auth.get_account_info(user['idToken'])
            # print(user_info)

            # Xác thực chống spam
            is_verified = user_info.get('users')[0].get('emailVerified')
            if is_verified:
                user_email = user_info.get('users')[0].get('email')
                # print(user_email)
                user_id_raw = user_ref.where('userEmail', '==', user_email).stream()
                user_id = [user_id for user_id in user_id_raw][0].id

                # Độ trễ
                # time.sleep(3)
                return Response(200, "success", user_id, "Login successful!").json, 200
            else:
                return Response(403, "fail", "null", "Email is not verified!").json, 403  # Bị cấm

        except Exception as e:
            # print(type(e))
            error_json = e.args[1]
            # print(error_json)
            error = json.loads(error_json)['error']
            # print(error)
            return Response(400, "error", "null", error).json, 400
