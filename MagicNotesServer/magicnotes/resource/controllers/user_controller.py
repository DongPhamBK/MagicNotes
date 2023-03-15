from flask import request, Blueprint
from flask_restful import Resource

from magicnotes.database.db import create_db
from magicnotes.resource.models.response import Response

user_controller_bp = Blueprint('UserController', __name__)


class UserController(Resource):
    db = create_db()
    user_ref = db.collection('user')

    # Lấy thông tin user
    def get(self, user_ref=user_ref):
        try:
            user_id = request.args.get('userid')
            user = user_ref.document(user_id).get().to_dict()
            if user is not None:
                return Response(200, "success", user, f"User information of user_id: {user_id}").json
            return Response(400, "fail", user, f"Cannot find user information of user_id: {user_id}").json

        except Exception as e:
            return Response(400, "error", "null", str(e)).json

    # Thay đổi thông tin user
    def post(self, user_ref=user_ref):
        try:
            user_id = request.args.get('userid')
            data = request.get_json()
            user_name = data['userName']
            user_description = data['userDescription']
            user_ref.document(user_id).set({'userName': user_name, 'userDescription': user_description}, merge=True)
            return Response(200, "success", "null", "Change user information successful!").json

        except Exception as e:
            return Response(400, "error", "null", str(e)).json
