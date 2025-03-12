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
    NIK: str = Field(..., min_length=16, max_length=16, regex=r"^\d+$")  # Harus 16 digit angka
    nama_lengkap: str
    opsi: Literal["baru", "pergantian", "perpanjangan", "sks"]  # Hanya menerima nilai ini
    dokumen_path: Optional[str] = None  # Bisa None kecuali opsi = 'pergantian'
    nomor_surat: str  # Wajib ada di body request

    @model_validator(mode="after")
    def check_dokumen_path(cls, values):
        if values.opsi == "pergantian" and not values.dokumen_path:
            raise ValueError("dokumen_path harus diisi jika opsi adalah 'pergantian'")
        return values

    class Config:
        from_attributes = True

class FormKTPUpdate(BaseModel):
    NIK: Optional[str] = None
    nama_lengkap: Optional[str] = None
    opsi: Optional[Literal["sks", "pergantian", "baru", "perpanjangan"]] = None
    dokumen_path: Optional[str] = None
    nomor_surat: Optional[str] = None

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
    id: str  # Pastikan ini bertipe str
    NIK: str
    nama_lengkap: str
    opsi: str
    dokumen_path: Optional[str]
    tanggal_dikeluarkan: Optional[datetime]
    pembuat: Optional[str]
    nomor_surat: Optional[str]

    class Config:
        from_attributes = True
