# CRUD note
import json
from datetime import datetime
import time

import uuid

from flask import request, Blueprint
from flask_restful import Resource
from google.cloud import firestore

from magicnotes.database.db import create_db
from magicnotes.resource.models.note import Note, NoteState
from magicnotes.resource.models.response import Response

note_controller_bp = Blueprint('NoteController', __name__)


class NoteController(Resource):
    db = create_db()
    user_ref = db.collection('user')
    note_ref = db.collection('note')

    @staticmethod
    def convert_note(note_id, note):
        return {
            'noteId': note_id,
            'noteTitle': note['noteTitle'],
            'noteDescription': note['noteDescription'],
            'noteCreatedTime': str(note['noteCreatedTime']),
            'noteState': note['noteState']
        }

    # Lấy danh sách ghi chú
    def get(self, user_ref=user_ref, note_ref=note_ref):
        try:
            # Kết quả trả về
            notes_json = []
            # Lấy id người dùng từ link truy cập
            user_id = request.args.get('userid')
            # Tùy chọn sắp xếp
            sort = request.args.get('sort')
            # print(user_id)
            # Lấy user trước
            user = user_ref.document(user_id)
            # print(user)
            # truy vấn với reference
            if sort == "asc":
                notes_raw = note_ref.where('user', '==', user).order_by('noteCreatedTime', direction="ASCENDING").stream()
            else:
                notes_raw = note_ref.where('user', '==', user).order_by('noteCreatedTime', direction="DESCENDING").stream()
            # Chuyển đổi dữ liệu
            for note in notes_raw:
                note_id = note.id
                note = note.to_dict()
                notes_json.append(NoteController.convert_note(note_id, note))
            # Độ trễ
            # time.sleep(3)
            return Response(200, "success", notes_json, f"List of magicnotes for user id: {user_id}!").json, 200
        except Exception as e:
            print(e)
            return Response(400, "error", [], str(e)).json, 400

    # Tạo mới 1 ghi chú
    def post(self, user_ref=user_ref, note_ref=note_ref):
        try:
            # Lấy id người dùng từ link truy cập
            user_id = request.args.get('userid')
            data = request.get_json()
            note_title = data['noteTitle']
            note_description = data['noteDescription']
            note_state = data['noteState']
            note_created_time = datetime.now()
            # Lấy user trước
            user = user_ref.document(user_id)
            # print(user)
            # truy vấn với reference
            new_note = Note(uuid.uuid4().hex, note_title, note_description, note_created_time,
                            NoteState.get_state(note_state), user)
            # print(note.__str__())
            # print(new_note.note_id);
            note_ref.document(new_note.note_id).set(new_note.json)

            return Response(200, "success", "null", f"Add new note successful!!").json, 200
        except Exception as e:
            return Response(400, "error", "null", str(e)).json, 400

    # Cập nhật một ghi chú
    def put(self, user_ref=user_ref, note_ref=note_ref):
        try:
            # Lấy id người dùng từ link truy cập
            user_id = request.args.get('userid')
            # Kiểu gì cũng cần id, rất may là ta có nó!
            data = request.get_json()
            note_id = data['noteId']
            note_title = data['noteTitle']
            note_description = data['noteDescription']
            note_state = data['noteState']
            note_created_time = datetime.now()
            user = user_ref.document(user_id)

            # Quá trình cập nhật
            note_updated = Note(uuid.uuid4().hex, note_title, note_description, note_created_time,
                                NoteState.get_state(note_state), user)
            note_ref.document(note_id).update(note_updated.json)
            return Response(200, "success", "null", f"Update note successful!!").json, 200
        except Exception as e:
            return Response(400, "error", "null", str(e)).json, 400

    # Xóa ghi chú
    def delete(self, note_ref=note_ref):
        try:
            data = request.get_json()
            note_id = data['noteId']
            note_ref.document(note_id).delete()
            return Response(200, "success", "null", f"Delete note successful!!").json, 200
        except Exception as e:
            return Response(400, "error", "null", str(e)).json, 400
