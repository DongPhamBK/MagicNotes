# Model of User
import uuid
from dataclasses import dataclass


@dataclass
class User:
    user_id: int
    user_email: str
    user_name: str
    user_description: str

    @property
    def json(self):
        return {
            "userId": self.user_id,
            "userName": self.user_name,
            "userEmail": self.user_email,
            "userDescription": self.user_description
        }

    def __str__(self) -> str:
        return f"User({self.user_id}, {self.user_email}, {self.user_name}, {self.user_description})"
