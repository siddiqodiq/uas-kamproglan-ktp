from flask import Flask, jsonify, request
from flask_jwt_extended import (
    JWTManager, create_access_token, jwt_required, get_jwt_identity, get_jwt
)
from models import db, Pengguna, FormKTP
from schemas import PenggunaCreate, FormKTPCreate, FormKTPUpdate, FormKTPResponse
from pydantic import ValidationError
from datetime import datetime
from functools import wraps
from sqlalchemy.exc import IntegrityError
import uuid

app = Flask(__name__)
app.config.from_object('config.Config')
db.init_app(app)
jwt = JWTManager(app)

def role_required(role):
    def wrapper(fn):
        @wraps(fn)
        @jwt_required()
        def decorator(*args, **kwargs):
            claims = get_jwt()
            if claims['role'] != role and claims['role'] != 'admin':  # Admin bisa mengakses endpoint role apa pun
                return jsonify(msg=f"Akses ditolak. Hanya {role} yang dapat mengakses fitur ini."), 403
            return fn(*args, **kwargs)
        return decorator
    return wrapper

# Auth Routes
@app.route('/', methods=['GET'])
def get_server():
    return jsonify({'message': 'Server is running!'}), 200

@app.route('/register', methods=['POST'])
def register():
    try:
        # Hapus field 'role' dari input pengguna
        data = PenggunaCreate(**request.json)
    except ValidationError as e:
        return jsonify(e.errors()), 400
    
    # Cek apakah username sudah terdaftar
    if Pengguna.query.filter_by(username=data.username).first():
        return jsonify(msg="Username sudah terdaftar"), 400
    
    # Buat pengguna baru dengan role otomatis 'user'
    pengguna = Pengguna(
        username=data.username,
        nama_lengkap=data.nama_lengkap,
        jabatan=data.jabatan,
        role='user'  # Set role otomatis sebagai 'user'
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

@app.route('/api/ktp/form_ktp', methods=['POST'])
@jwt_required()
@role_required('user')
def create_form():
    try:
        data = FormKTPCreate(**request.json)
    except ValidationError as e:
        formatted_errors = [
            {"field": " -> ".join(str(loc) for loc in error["loc"]),
             "message": error["msg"]}
            for error in e.errors()
        ]
        return jsonify(errors=formatted_errors), 400

    current_user = get_jwt_identity()
    pengguna = Pengguna.query.filter_by(username=current_user).first()
    
    if not pengguna:
        return jsonify(msg="User tidak ditemukan"), 404
    
    # Cek jika user mencoba menginput nomor_surat
    claims = get_jwt()
    nomor_surat = request.json.get('nomor_surat')
    
    # Jika user biasa mencoba menginput nomor_surat, tolak permintaan
    if claims['role'] != 'admin' and nomor_surat:
        return jsonify(msg="Hanya admin yang dapat menginput nomor surat"), 403
    
    new_form = FormKTP(
        id=str(uuid.uuid4()),  # Generate UUID untuk ID
        NIK=data.NIK,
        nama_lengkap=data.nama_lengkap,
        opsi=data.opsi.lower(),
        dokumen_path=data.dokumen_path,
        pembuat=pengguna.nama_lengkap,
        nomor_surat=nomor_surat if claims['role'] == 'admin' else None  # Nomor surat hanya diisi oleh admin
    )
    
    try:
        db.session.add(new_form)
        db.session.commit()
        return jsonify(msg="Formulir berhasil dibuat", id=new_form.id), 201
    except IntegrityError:  # Jika terjadi tabrakan UUID (kemungkinan sangat kecil)
        db.session.rollback()
        return jsonify(msg="Gagal membuat formulir"), 500



# Endpoint PATCH (Update Form)
@app.route('/api/ktp/form_ktp/<string:id>', methods=['PATCH'])
@jwt_required()
@role_required('user')
def update_form(id):
    try:
        uuid_obj = uuid.UUID(id)  # Validasi UUID
    except ValueError:
        return jsonify(msg="Format UUID tidak valid."), 400

    try:
        data = FormKTPUpdate(**request.json)
    except ValidationError as e:
        return jsonify({"errors": e.errors()}), 400
    
    form = FormKTP.query.filter_by(id=str(uuid_obj)).first_or_404()
    current_user = get_jwt_identity()
    pengguna = Pengguna.query.filter_by(username=current_user).first()
    claims = get_jwt()

    if claims['role'] != 'admin' and form.pembuat != pengguna.nama_lengkap:
        return jsonify(msg="Akses ditolak. Anda tidak memiliki izin untuk mengedit formulir ini."), 403
    
    if data.NIK:
        form.NIK = data.NIK
    if data.nama_lengkap:
        form.nama_lengkap = data.nama_lengkap
    if data.opsi:
        form.opsi = data.opsi.lower()
    if data.dokumen_path:
        form.dokumen_path = data.dokumen_path
    
    # Hanya admin yang bisa update nomor_surat
    if data.nomor_surat:
        if claims['role'] != 'admin':
            return jsonify(msg="Hanya admin yang dapat mengupdate nomor surat"), 403
        form.nomor_surat = data.nomor_surat
    
    db.session.commit()
    return jsonify(msg="Formulir berhasil diperbarui")

# Endpoint DELETE (Hapus Form)
@app.route('/api/ktp/form_ktp/<string:id>', methods=['DELETE'])
@jwt_required()
@role_required('user')
def delete_form(id):
    try:
        uuid_obj = uuid.UUID(id)
    except ValueError:
        return jsonify(msg="Format UUID tidak valid."), 400

    form = FormKTP.query.filter_by(id=str(uuid_obj)).first_or_404()
    current_user = get_jwt_identity()
    pengguna = Pengguna.query.filter_by(username=current_user).first()
    claims = get_jwt()

    if claims['role'] != 'admin' and form.pembuat != pengguna.nama_lengkap:
        return jsonify(msg="Akses ditolak. Anda tidak memiliki izin untuk menghapus formulir ini."), 403
    
    db.session.delete(form)
    db.session.commit()
    return jsonify(msg="Formulir berhasil dihapus")

# Endpoint GET (Ambil Data Form)
@app.route('/api/ktp/form_ktp/<string:id>', methods=['GET'])
@jwt_required()
@role_required('user')
def get_form(id):
    try:
        uuid_obj = uuid.UUID(id)
    except ValueError:
        return jsonify(msg="Format UUID tidak valid."), 400

    form = FormKTP.query.filter_by(id=str(uuid_obj)).first_or_404()
    current_user = get_jwt_identity()
    pengguna = Pengguna.query.filter_by(username=current_user).first()
    claims = get_jwt()
    
    if claims['role'] != 'admin' and form.pembuat != pengguna.nama_lengkap:
        return jsonify(msg="Akses ditolak. Anda tidak memiliki izin untuk mengakses formulir ini."), 403
    
    return jsonify(FormKTPResponse.from_orm(form).dict())

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
    app.run(host='127.0.0.1', debug=False, port=8000)# add port
