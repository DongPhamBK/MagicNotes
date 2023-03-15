# Login HTTP method
import json

from flask import request, Blueprint
from flask_restful import Resource

from magicnotes.database.db import create_auth, create_db, create_admin_auth
from magicnotes.resource.models.response import Response

user_change_password_bp = Blueprint('UserChangePassword', __name__)


class UserChangePassword(Resource):
    auth = create_auth()
    admin_auth = create_admin_auth()
    db = create_db()
    user_ref = db.collection('user')

    # Quên mật khẩu
    def post(self, auth=auth):
        try:
            # print(request.json)
            data = request.get_json()
            user_email = data['userEmail']

            # Reset password
            auth.send_password_reset_email(user_email)

            return Response(200, "success", "null", "Reset password successful!").json
        except Exception as e:
            return Response(400, "error", "null", str(e)).json

    # Đổi mật khẩu
    def put(self, auth=admin_auth):
        try:
            # print(request.json)
            data = request.get_json()
            user_email = data['userEmail']
            user_password = data['userPassword']
            user_confirm_password = data['userConfirmPassword']

            if user_password == user_confirm_password:
                # Truy xuất thông tin sâu của người dùng
                user = auth.get_user_by_email(user_email)
                # Lấy mã định danh
                uid = user.uid
                auth.update_user(
                    uid,
                    email_verified=True,
                    password=user_password
                )
                return Response(200, "success", "null", "Update password successful!!").json
            else:
                return Response(205, "fail", "null", "Password confirm not true!!").json

        except Exception as e:
            error_json = e.args[1]
            error = json.loads(error_json)['error']
            return Response(400, "error", "null", error).json
