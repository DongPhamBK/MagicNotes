from flask import Flask, render_template

from magicnotes.resource.controllers.home import home_bp
from magicnotes.resource.controllers.note_controller import note_controller_bp
from magicnotes.resource.controllers.user_change_password import user_change_password_bp
from magicnotes.resource.controllers.user_controller import user_controller_bp
from magicnotes.resource.controllers.user_login import user_login_bp
from magicnotes.resource.controllers.user_signup import user_signup_bp
from magicnotes.route import config_route

app = Flask(__name__, template_folder='magicnotes/templates')

def create_app():
    # app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///book.db'
    # app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
    # app.config["PROPAGATE_EXCEPTIONS"] = True
    app.config['SECRET_KEY'] = 'qwerty'

    app.register_blueprint(home_bp)
    app.register_blueprint(user_signup_bp)
    app.register_blueprint(user_login_bp)
    app.register_blueprint(user_change_password_bp)
    app.register_blueprint(user_controller_bp)
    app.register_blueprint(note_controller_bp)

    api = config_route()
    api.init_app(app)
    return app


app = create_app()
app.run(port=5000, host='0.0.0.0', debug=True)
# if __name__ == '__main__':
#     app = create_app()
#     app.run(port=5000, debug=True)
