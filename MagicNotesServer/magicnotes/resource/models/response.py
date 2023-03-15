from dataclasses import dataclass


# Response template

@dataclass
class Response:
    code: int
    status: str
    data: any
    message: str

    @property
    def json(self):
        return {
            "code": self.code,
            "status": self.status,
            "data": self.data,
            "message": self.message
        }

    def __str__(self) -> str:
        return f"Response({self.code}, {self.status}, {self.data}, {self.message})"
