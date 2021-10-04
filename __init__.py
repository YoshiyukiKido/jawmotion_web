# init.py

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager

WEB_HOME = '/home/kido/jawmotion_app/'
UPLOAD_DIR = 'uploads'
FFMPEG_BIN = '/usr/bin/ffmpeg'
OPENFACE_BIN = '/home/kido/OpenFace/build/bin/FaceLandmarkVidMulti'

# init SQLAlchemy so we can use it later in our models
db = SQLAlchemy()

def create_app():
    app = Flask(__name__)

    app.config['SECRET_KEY'] = '9OLWxND4o83j4K4iuopO'
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.sqlite'
    app.debug=True
    app.threaded=True

    db.init_app(app)

    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.init_app(app)

    from .models import User

    @login_manager.user_loader
    def load_user(user_id):
        # since the user_id is just the primary key of our user table, use it in the query for the user
        return User.query.get(int(user_id))

    # blueprint for auth routes in our app
    from .auth import auth as auth_blueprint
    app.register_blueprint(auth_blueprint)

    # blueprint for non-auth parts of app
    from .main import main as main_blueprint
    app.register_blueprint(main_blueprint)

    app.config['UPLOAD_DIR'] = UPLOAD_DIR
    app.config['WEB_HOME'] = WEB_HOME
    app.config['FFMPEG_BIN'] = FFMPEG_BIN
    app.config['OPENFACE_BIN'] = OPENFACE_BIN

    return app