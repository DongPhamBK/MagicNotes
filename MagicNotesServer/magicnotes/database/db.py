# create database
import pyrebase
from firebase_admin import credentials, initialize_app, firestore, auth

from magicnotes.common.constants import CONFIG

cred = credentials.Certificate('magicnotes/common/key.json')
default_app = initialize_app(cred)


def create_auth():
    pyr = pyrebase.initialize_app(CONFIG)
    return pyr.auth()


def create_admin_auth():
    # auth với quyền quản trị viên
    return auth


def create_db():
    # Initialize Firestore DB
    db = firestore.client()
    return db
