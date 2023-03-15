# config route
from flask_restful import Api

from magicnotes.resource.controllers.home import Home
from magicnotes.resource.controllers.note_controller import NoteController
from magicnotes.resource.controllers.user_change_password import UserChangePassword
from magicnotes.resource.controllers.user_controller import UserController
from magicnotes.resource.controllers.user_login import UserLogin
from magicnotes.resource.controllers.user_signup import UserSignUp


def config_route():
    api = Api()
    api.add_resource(Home,'/v1/')
    api.add_resource(UserSignUp, '/v1/signup')
    api.add_resource(UserLogin, '/v1/login')
    api.add_resource(UserChangePassword, '/v1/changepassword')
    api.add_resource(UserController, '/v1/users')
    api.add_resource(NoteController, '/v1/notes')
    return api
