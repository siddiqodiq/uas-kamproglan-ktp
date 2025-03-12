from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime
from sqlalchemy.dialects.mysql import CHAR
import uuid

db = SQLAlchemy()

class Pengguna(db.Model):
    __tablename__ = 'pengguna'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(255), nullable=False)#jadi 255
    nama_lengkap = db.Column(db.String(100), nullable=False)
    jabatan = db.Column(db.String(50))
    role = db.Column(db.String(50), nullable=False)  # 'admin' atau 'user'

    def set_password(self, password):
        self.password = generate_password_hash(password, method='scrypt')#nambah method

    def check_password(self, password):
        return check_password_hash(self.password, password)

class FormKTP(db.Model):
    __tablename__ = 'form_ktp'
    id = db.Column(db.String(36), primary_key=True, unique=True, nullable=False)
    NIK = db.Column(db.String(20), nullable=False)
    nama_lengkap = db.Column(db.String(100), nullable=False)
    opsi = db.Column(db.String(50), nullable=False)
    dokumen_path = db.Column(db.String(255))
    tanggal_dikeluarkan = db.Column(db.DateTime, default=datetime.now)
    pembuat = db.Column(db.String(100))
    nomor_surat = db.Column(db.String(255))