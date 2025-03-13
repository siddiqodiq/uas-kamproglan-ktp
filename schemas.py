from enum import Enum
from pydantic import BaseModel, Field, field_validator
from datetime import date, datetime
from typing import Optional

class PenggunaCreate(BaseModel):
    username: str
    password: str
    nama_lengkap: str
    jabatan: Optional[str] = "Warga"
    role: Optional[str] = "user"

class DaftarSuratKematianSchema(BaseModel):
    Tanggal_Terbit: date = None  # Tidak wajib, akan di-set otomatis di kode
    Nomor_Surat: str
    Penyimpanan: str
    NIK_Terlapor: str
    Nama_Terlapor: str = None
    Nama_Petugas: str
    Nama_Kades: str
    Tanggal_Kematian: date  # Wajib diinput oleh pengguna

    class Config:
        orm_mode = True

class GabunganKeluargaSchema(BaseModel):
    NIK: str
    Nama_Lengkap: str
    Jenis_Kelamin: Optional[str] = None
    Tanggal_Lahir: Optional[date] = None
    Kewarganegaraan: Optional[str] = None
    Agama: Optional[str] = None
    Alamat: Optional[str] = None
    Status_Hidup_Meninggal: Optional[str] = None
    Tgl_Kematian: Optional[date] = None

    class Config:
        orm_mode = True

class JenisEnum(str, Enum):
    surat = "Surat"
    non_surat = "Non-Surat"

class DetailKematianSchema(BaseModel):
    NIK: str
    Tgl_Kematian: str  
    Jam_Kematian: str
    Lokasi_Kematian: str
    Penyebab_Kematian: str
    Hubungan_dengan_Terlapor: str
    Jenis: JenisEnum

    @field_validator("Tgl_Kematian")
    def validate_tgl_kematian(cls, value):
        try:
            # Pertama, pastikan formatnya valid
            tgl_kematian = datetime.strptime(value, "%Y-%m-%d").date()
        except ValueError:
            raise ValueError("Format tanggal tidak valid. Gunakan format YYYY-MM-DD.")
        
        # Kedua, pastikan tanggal tidak melebihi hari ini
        if tgl_kematian > datetime.now().date():
            raise ValueError("Tanggal kematian tidak boleh melebihi tanggal hari ini.")
        
        return value

    @field_validator("Jam_Kematian")
    def validate_jam_kematian(cls, value):
        try:
            datetime.strptime(value, "%H:%M")  # Pastikan format HH:MM
            return value
        except ValueError:
            raise ValueError("Format jam tidak valid. Gunakan format HH:MM.")
        
    class Config:
        orm_mode = True