from pydantic import BaseModel, Field, model_validator, ValidationError
from typing import Optional, Literal
from datetime import datetime

# Daftar opsi yang valid
VALID_OPSI = ["sks", "pergantian", "baru", "perpanjangan"]

class PenggunaCreate(BaseModel):
    username: str
    password: str
    nama_lengkap: str
    jabatan: Optional[str] = "Warga"
    role: Optional[str] = "user"

class FormKTPCreate(BaseModel):
    NIK: str
    nama_lengkap: str
    opsi: Literal["sks", "pergantian", "baru", "perpanjangan"]
    dokumen_path: Optional[str] = None

    @model_validator(mode='before')
    def check_dokumen_path(cls, values):
        opsi = values.get('opsi').lower()
        dokumen_path = values.get('dokumen_path')

        if opsi not in VALID_OPSI:
            raise ValueError(f"Opsi tidak valid. Pilih salah satu dari: {VALID_OPSI}")

        if opsi == "pergantian" and not dokumen_path:
            raise ValueError("dokumen_path wajib diisi untuk opsi Pergantian")
        
        return values

class FormKTPUpdate(BaseModel):
    nama_lengkap: Optional[str] = None
    opsi: Optional[Literal["sks", "pergantian", "baru", "perpanjangan"]] = None
    dokumen_path: Optional[str] = None

    @model_validator(mode='before')
    def check_dokumen_path(cls, values):
        opsi = values.get('opsi')
        if opsi:
            opsi = opsi.lower()
            dokumen_path = values.get('dokumen_path')

            if opsi not in VALID_OPSI:
                raise ValueError(f"Opsi tidak valid. Pilih salah satu dari: {VALID_OPSI}")

            if opsi == "pergantian" and not dokumen_path:
                raise ValueError("dokumen_path wajib diisi untuk opsi Pergantian")
        
        return values

class FormKTPResponse(BaseModel):
    id: int
    NIK: str
    nama_lengkap: str
    opsi: str
    dokumen_path: Optional[str]
    tanggal_dikeluarkan: Optional[datetime]
    pengguna: Optional[str]
    nomor_surat: Optional[str]

    class Config:
        from_attributes = True