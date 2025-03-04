from flask import Flask, jsonify, request
from flask_jwt_extended import (
    JWTManager, create_access_token, jwt_required, get_jwt_identity, get_jwt
)
from models import db, Pengguna, FormKTP
from schemas import PenggunaCreate, FormKTPCreate, FormKTPUpdate, FormKTPResponse
from pydantic import ValidationError
from datetime import datetime
from functools import wraps

app = Flask(__name__)
app.config.from_object('config.Config')
db.init_app(app)
jwt = JWTManager(app)

# Helper functions
def role_required(role):
    def wrapper(fn):
        @wraps(fn)
        @jwt_required()
        def decorator(*args, **kwargs):
            claims = get_jwt()
            if claims['role'] != role:
                return jsonify(msg=f"Akses ditolak. Hanya {role} yang dapat mengakses fitur ini."), 403
            return fn(*args, **kwargs)
        return decorator
    return wrapper

# Auth Routes
@app.route('/register', methods=['POST'])
def register():
    try:
        data = PenggunaCreate(**request.json)
    except ValidationError as e:
        return jsonify(e.errors()), 400
    
    if Pengguna.query.filter_by(username=data.username).first():
        return jsonify(msg="Username sudah terdaftar"), 400
    
    pengguna = Pengguna(
        username=data.username,
        nama_lengkap=data.nama_lengkap,
        jabatan=data.jabatan,
        role=data.role
    )
    pengguna.set_password(data.password)
    db.session.add(pengguna)
    db.session.commit()
    return jsonify(msg="Registrasi berhasil"), 201

@app.route('/login', methods=['POST'])
def login():
    username = request.json.get('username')
    password = request.json.get('password')
    pengguna = Pengguna.query.filter_by(username=username).first()
    
    if pengguna and pengguna.check_password(password):
        access_token = create_access_token(
            identity=username,
            additional_claims={'role': pengguna.role}
        )
        return jsonify(access_token=access_token)
    return jsonify(msg="Username atau password salah"), 401

# Form Routes (Warga Desa)
@app.route('/api/ktp/form_ktp', methods=['POST'])
@jwt_required()
@role_required('user')
def create_form_ktp():
    try:
        data = FormKTPCreate(**request.json)
    except ValidationError as e:
        return jsonify(e.errors()), 400
    
    current_user = get_jwt_identity()
    pengguna = Pengguna.query.filter_by(username=current_user).first()
    
    if not pengguna:
        return jsonify(msg="User tidak ditemukan"), 404
    
    new_form = FormKTP(
        NIK=data.NIK,
        nama_lengkap=data.nama_lengkap,
        opsi=data.opsi.lower(),
        dokumen_path=data.dokumen_path,
        petugas=pengguna.nama_lengkap
    )
    
    db.session.add(new_form)
    db.session.commit()
    return jsonify(msg="Formulir berhasil dibuat"), 201

@app.route('/api/ktp/sks_ktp', methods=['POST'])
@jwt_required()
@role_required('user')
def create_sks_ktp():
    try:
        data = FormKTPCreate(**request.json)
    except ValidationError as e:
        return jsonify(e.errors()), 400
    
    current_user = get_jwt_identity()
    pengguna = Pengguna.query.filter_by(username=current_user).first()
    
    if not pengguna:
        return jsonify(msg="User tidak ditemukan"), 404
    
    new_form = FormKTP(
        NIK=data.NIK,
        nama_lengkap=data.nama_lengkap,
        opsi=data.opsi.lower(),
        dokumen_path=data.dokumen_path,
        petugas=pengguna.nama_lengkap
    )
    
    db.session.add(new_form)
    db.session.commit()
    return jsonify(msg="Formulir SKS berhasil dibuat"), 201


# Form Routes (Admin Desa)
@app.route('/api/ktp/form_ktp', methods=['GET'])
@jwt_required()
@role_required('admin')
def get_all_form_ktp():
    forms = FormKTP.query.all()
    return jsonify([FormKTPResponse.from_orm(f).dict() for f in forms])

@app.route('/api/ktp/sks_ktp', methods=['GET'])
@jwt_required()
@role_required('admin')
def get_all_sks_ktp():
    forms = FormKTP.query.filter_by(opsi="sks").all()
    return jsonify([FormKTPResponse.from_orm(f).dict() for f in forms])

@app.route('/api/ktp/riwayat_surat', methods=['GET'])
@jwt_required()
@role_required('admin')
def get_riwayat_surat():
    forms = FormKTP.query.all()
    return jsonify([FormKTPResponse.from_orm(f).dict() for f in forms])



if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)