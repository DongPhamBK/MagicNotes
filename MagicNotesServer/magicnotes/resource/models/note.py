# Model of User
import datetime
import uuid
from dataclasses import dataclass

import enum


class NoteState(enum.Enum):
    unstarted = "Unstarted"
    in_process = "In Process"
    done = "Done"

    @classmethod
    def get_state(cls, note):
        if note == 'Unstarted':
            return NoteState.unstarted
        elif note == 'In Process':
            return NoteState.in_process
        else:
            return NoteState.done


@dataclass
class Note:
    note_id : int
    note_title: str
    note_description: str
    note_created_time: datetime
    note_state: NoteState
    note_user: str

    @property
    def json(self):
        return {
            "noteTitle": self.note_title,
            "noteDescription": self.note_description,
            "noteState": self.note_state.value,
            "noteCreatedTime": str(self.note_created_time),
            "user": self.note_user
        }

    def __str__(self) -> str:
        return f"Note({self.note_id}, {self.note_title}, {self.note_description}, {self.note_created_time}, {self.note_state.value}, {self.note_user})"

# note = Note("a","s",datetime.datetime.now(),NoteState.unstarted)
# print(note)
