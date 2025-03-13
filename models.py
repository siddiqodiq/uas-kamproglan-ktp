from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime

db = SQLAlchemy()

class Pengguna(db.Model):
    __tablename__ = 'pengguna'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(128), nullable=False)
    nama_lengkap = db.Column(db.String(100), nullable=False)
    jabatan = db.Column(db.String(50))
    role = db.Column(db.String(50), nullable=False)  # 'admin' atau 'user'

    def set_password(self, password):
        self.password = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password, password)

class DaftarSuratKematian(db.Model):
    tablename = 'daftar_surat_kematian'
    
    Id = db.Column(db.Integer, primary_key=True)
    Tanggal_Terbit = db.Column(db.Date)
    Nomor_Surat = db.Column(db.String(50))
    Penyimpanan = db.Column(db.String(255))
    NIK_Terlapor = db.Column(db.String(20))
    Nama_Terlapor = db.Column(db.String(255))
    Nama_Petugas = db.Column(db.String(100))
    Nama_Kades = db.Column(db.String(255))

class GabunganKeluarga(db.Model):
    __tablename__ = 'gabungan_keluarga'
    
    NIK = db.Column(db.String(16), primary_key=True)  # Gunakan NIK sebagai primary key
    Nama_Lengkap = db.Column(db.String(100), nullable=False)  # Nama Lengkap tidak nullable
    Jenis_Kelamin = db.Column(db.String(10))
    Tanggal_Lahir = db.Column(db.Date)
    Kewarganegaraan = db.Column(db.String(50))
    Agama = db.Column(db.String(50))
    alamat = db.Column(db.Text)
    Status_Hidup_Meninggal = db.Column(db.Enum('HIDUP', 'MENINGGAL'), nullable=False)  # Status hidup/meninggal
    Tgl_Kematian = db.Column(db.Date)

class DetailKematian(db.Model):
    __tablename__ = 'detail_kematian'

    Id = db.Column(db.Integer, primary_key=True)
    NIK = db.Column(db.String(16), nullable=False)
    Tgl_Kematian = db.Column(db.Date, nullable=False)
    Jam_Kematian = db.Column(db.Time, nullable=False)
    Lokasi_Kematian = db.Column(db.String(255), nullable=False)
    Penyebab_Kematian = db.Column(db.String(255), nullable=False)
    Nama_Pelapor = db.Column(db.String(255), nullable=False)
    Hubungan_dengan_Terlapor = db.Column(db.String(255), nullable=False)
    Jenis = db.Column(db.Enum('Surat', 'Non-Surat'), nullable=False)

    keluarga = db.relationship('GabunganKeluarga', foreign_keys=[NIK], primaryjoin="DetailKematian.NIK == GabunganKeluarga.NIK", backref="detail_kematian", lazy="joined")