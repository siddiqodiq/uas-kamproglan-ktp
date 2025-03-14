# added necessary imports
from sqlalchemy import Column, String, ForeignKey
from sqlalchemy.orm import relationship
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash

db = SQLAlchemy()


class Pengguna(db.Model):
    __tablename__ = 'pengguna'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(255), nullable=False)  # jadi 255
    nama_lengkap = db.Column(db.String(100), nullable=False)
    role = db.Column(db.String(50), nullable=False)  # 'admin' atau 'user'

    records_created = relationship(
        "GabunganKeluarga", back_populates="creator")

    def set_password(self, password):
        self.password = generate_password_hash(
            password, method='scrypt')  # nambah method

    def check_password(self, password):
        return check_password_hash(self.password, password)


class GabunganKeluarga(db.Model):  # changed Base to db.Model
    __tablename__ = "gabungan_keluarga"
    NIK = Column(String(16), primary_key=True, index=True)
    created_by = Column(String(50), ForeignKey(
        'pengguna.username'), nullable=False)  # Track who created this record

    # Relationship: Link to Pengguna
    creator = relationship("Pengguna", back_populates="records_created")
    Nomor_KK = db.Column(db.String(16), nullable=True)
    nama_lengkap = db.Column(db.String(100), nullable=True)
    Gelar_Depan = db.Column(db.String(20), nullable=True)
    Gelar_Belakang = db.Column(db.String(20), nullable=True)
    Passport_Number = db.Column(db.String(20), nullable=True)
    Tgl_Berakhir_Paspor = db.Column(db.Date, nullable=True)
    Nama_Sponsor = db.Column(db.String(100), nullable=True)
    Tipe_Sponsor = db.Column(db.String(50), nullable=True)
    Alamat_Sponsor = db.Column(db.String(255), nullable=True)
    Jenis_Kelamin = db.Column(db.String(10), nullable=True)
    Tempat_Lahir = db.Column(db.String(50), nullable=True)
    Tanggal_Lahir = db.Column(db.Date, nullable=True)
    Kewarganegaraan = db.Column(db.String(50), nullable=True)
    No_SK_Penetapan_WNI = db.Column(db.String(50), nullable=True)
    Akta_Lahir = db.Column(db.Boolean, nullable=True)
    Nomor_Akta_Kelahiran = db.Column(db.String(50), nullable=True)
    Golongan_Darah = db.Column(db.String(3), nullable=True)
    Agama = db.Column(db.String(50), nullable=True)
    Nama_Organisasi_Kepercayaan = db.Column(db.String(100), nullable=True)
    Status_Perkawinan = db.Column(db.String(20), nullable=True)
    Akta_Perkawinan = db.Column(db.Boolean, nullable=True)
    Nomor_Akta_Perkawinan = db.Column(db.String(50), nullable=True)
    Tanggal_Perkawinan = db.Column(db.Date, nullable=True)
    Akta_Cerai = db.Column(db.Boolean, nullable=True)
    Nomor_Akta_Cerai = db.Column(db.String(50), nullable=True)
    Tanggal_Perceraian = db.Column(db.Date, nullable=True)
    Status_Hubungan_Dalam_Keluarga = db.Column(db.String(50), nullable=True)
    Kelainan_Fisik_dan_Mental = db.Column(db.String(100), nullable=True)
    Penyandang_Cacat = db.Column(db.Boolean, nullable=True)
    Pendidikan_Terakhir = db.Column(db.String(50), nullable=True)
    Jenis_Pekerjaan = db.Column(db.String(50), nullable=True)
    Nomor_ITAS_ITAP = db.Column(db.String(50), nullable=True)
    Tanggal_Terbit_ITAS_ITAP = db.Column(db.Date, nullable=True)
    Tanggal_Akhir_ITAS_ITAP = db.Column(db.Date, nullable=True)
    Tempat_Datang_Pertama = db.Column(db.String(100), nullable=True)
    Tanggal_Kedatangan_Pertama = db.Column(db.Date, nullable=True)
    NIK_Ibu = db.Column(db.String(16), nullable=True)
    Nama_Ibu = db.Column(db.String(100), nullable=True)
    NIK_Ayah = db.Column(db.String(16), nullable=True)
    Nama_Ayah = db.Column(db.String(100), nullable=True)
    alamat = db.Column(db.Text, nullable=True)
    kode_pos = db.Column(db.String(5), nullable=True)
    rt = db.Column(db.String(3), nullable=True)
    rw = db.Column(db.String(3), nullable=True)
    jumlah_anggota_keluarga = db.Column(db.Integer, nullable=True)
    telepon = db.Column(db.String(15), nullable=True)
    email = db.Column(db.String(255), nullable=True)
    kode_provinsi = db.Column(db.String(2), nullable=True)
    nama_provinsi = db.Column(db.String(255), nullable=True)
    kode_kabupaten = db.Column(db.String(2), nullable=True)
    nama_kabupaten = db.Column(db.String(255), nullable=True)
    kode_kecamatan = db.Column(db.String(2), nullable=True)
    nama_kecamatan = db.Column(db.String(255), nullable=True)
    kode_desa = db.Column(db.String(2), nullable=True)
    nama_desa = db.Column(db.String(255), nullable=True)
    nama_dusun = db.Column(db.String(255), nullable=True)
    alamat_luar_negeri = db.Column(db.Text, nullable=True)
    kota_luar_negeri = db.Column(db.String(255), nullable=True)
    provinsi_negara_bagian_luar_negeri = db.Column(
        db.String(255), nullable=True)
    negara_luar_negeri = db.Column(db.String(255), nullable=True)
    kode_pos_luar_negeri = db.Column(db.String(10), nullable=True)
    jumlah_anggota_keluarga_luar_negeri = db.Column(
        db.String(3), nullable=True)
    telepon_luar_negeri = db.Column(db.String(15), nullable=True)
    email_luar_negeri = db.Column(db.String(255), nullable=True)
    kode_negara = db.Column(db.String(2), nullable=True)
    nama_negara = db.Column(db.String(255), nullable=True)
    kode_perwakilan_ri = db.Column(db.String(2), nullable=True)
    nama_perwakilan_ri = db.Column(db.String(255), nullable=True)
    Status_Hidup_Meninggal = db.Column(
        db.Enum("HIDUP", "MENINGGAL"), nullable=False, default="HIDUP")
    Tgl_Kematian = db.Column(db.Date, nullable=True)
    no_hp = db.Column(db.String(20), nullable=False)
    tempat_tanggal_lahir_bapak = db.Column(db.String(255), nullable=False)
    pekerjaan_bapak = db.Column(db.String(255), nullable=False)
    agama_bapak = db.Column(db.String(255), nullable=False)
    alamat_bapak = db.Column(db.String(255), nullable=False)
    tempat_tanggal_lahir_ibu = db.Column(db.String(255), nullable=False)
    pekerjaan_ibu = db.Column(db.String(255), nullable=False)
    agama_ibu = db.Column(db.String(255), nullable=False)
    alamat_ibu = db.Column(db.String(255), nullable=False)
    nik_bapak = db.Column(db.String(255), nullable=False)
    nama_bapak = db.Column(db.String(255), nullable=False)
    nama_kepala_keluarga = db.Column(db.String(255), nullable=False)
