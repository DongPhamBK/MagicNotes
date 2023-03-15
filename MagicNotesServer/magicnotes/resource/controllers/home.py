from flask import Blueprint, make_response, render_template
from flask_restful import Resource

home_bp = Blueprint('Home', __name__)


class Home(Resource):

    def get(self):
        return make_response(render_template('index.html'))
