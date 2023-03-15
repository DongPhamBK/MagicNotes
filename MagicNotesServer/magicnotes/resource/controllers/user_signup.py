# Login HTTP method
import dataclasses
import json

import uuid
from flask import request, Blueprint
from flask_restful import Resource, abort

from magicnotes.database.db import create_auth, create_db
from magicnotes.resource.models.response import Response
from magicnotes.resource.models.user import User

user_signup_bp = Blueprint('UserSignUp', __name__)


class UserSignUp(Resource):
    # authen và database
    auth = create_auth()
    db = create_db()
    user_ref = db.collection('user')

    def post(self, auth=auth, user_ref=user_ref):
        try:
            data = request.get_json()
            user_name = data['userName']
            user_email = data['userEmail']
            user_password = data['userPassword']
            user_description = data['userDescription']
            # Khởi tạo
            user = auth.create_user_with_email_and_password(user_email, user_password)
            # Xác thực email
            auth.send_email_verification(user['idToken'])

            # Thêm vào cơ sở dữ liệu
            new_user = User(uuid.uuid4().hex, user_email, user_name, user_description)
            user_ref.document(new_user.user_id).set(new_user.json)
            return Response(201, "success", "null", "Create user successful!").json
        except Exception as e:
            error_json = e.args[1]
            error = json.loads(error_json)['error']
            return Response(400, "error", "null", error).json
