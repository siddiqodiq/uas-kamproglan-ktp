from pydantic import BaseModel
from typing import Optional


class PenggunaCreate(BaseModel):
    username: str
    password: str
    nama_lengkap: str
    role: Optional[str] = "user"
