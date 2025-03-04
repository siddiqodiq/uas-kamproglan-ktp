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

class FormKTP(db.Model):
    __tablename__ = 'form_ktp'
    id = db.Column(db.Integer, primary_key=True)
    NIK = db.Column(db.String(16), nullable=False)
    nama_lengkap = db.Column(db.String(100), nullable=False)
    opsi = db.Column(db.String(50), nullable=False)
    dokumen_path = db.Column(db.String(200))
    tanggal_dikeluarkan = db.Column(db.DateTime, default=datetime.now)
    petugas = db.Column(db.String(100))
    nomor_surat = db.Column(db.String(50))