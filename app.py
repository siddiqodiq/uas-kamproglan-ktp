from flask_jwt_extended import jwt_required
from flask import Flask, jsonify, request
from flask_jwt_extended import (
    JWTManager, create_access_token, jwt_required, get_jwt, get_jwt_identity
)
from models import db, Pengguna, GabunganKeluarga
from schemas import PenggunaCreate
from pydantic import ValidationError
from functools import wraps
from sqlalchemy.exc import IntegrityError

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
            # Admin bisa mengakses endpoint role apa pun
            if claims.get('role') != role and claims.get('role') != 'admin':
                return jsonify(msg=f"Akses ditolak. Hanya {role} yang dapat mengakses fitur ini."), 403
            return fn(*args, **kwargs)
        return decorator
    return wrapper


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
        role='user'
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


@app.route("/api/kartu_keluarga", methods=["POST"])
@jwt_required()  # Ensures the user is authenticated
def create_kartu_keluarga():
    # Get user information from JWT
    jwt_data = get_jwt()
    current_user_role = jwt_data.get("role")  # Ensure JWT includes role
    current_username = get_jwt_identity()  # Get current username

    # Allow only 'admin' and 'user' roles to create records
    if current_user_role not in ["admin", "user"]:
        return jsonify({"error": "You are not authorized to create data"}), 403

    data = request.json

    # Required fields list
    required_fields = [
        "NIK", "Nomor_KK", "nama_lengkap", "Gelar_Depan", "Gelar_Belakang",
        "Jenis_Kelamin", "Tempat_Lahir", "Tanggal_Lahir", "Kewarganegaraan",
        "Golongan_Darah", "Agama", "Status_Perkawinan", "Status_Hubungan_Dalam_Keluarga",
        "Pendidikan_Terakhir", "Jenis_Pekerjaan", "NIK_Ibu", "Nama_Ibu",
        "NIK_Ayah", "Nama_Ayah", "alamat", "kode_pos", "rt", "rw", "jumlah_anggota_keluarga",
        "telepon", "email", "kode_provinsi", "nama_provinsi", "kode_kabupaten", "nama_kabupaten",
        "kode_kecamatan", "nama_kecamatan", "kode_desa", "nama_desa", "nama_dusun",
        "Status_Hidup_Meninggal", "no_hp", "tempat_tanggal_lahir_bapak", "pekerjaan_bapak", "agama_bapak", "alamat_bapak",
        "tempat_tanggal_lahir_ibu", "pekerjaan_ibu", "agama_ibu", "alamat_ibu", "nik_bapak",
        "nama_bapak", "nama_kepala_keluarga"
    ]

    # Check for missing fields
    missing_fields = [
        field for field in required_fields if not data.get(field)]
    if missing_fields:
        return jsonify({"error": f"Fields {', '.join(missing_fields)} cannot be null or empty"}), 400

    # Get all valid columns from the GabunganKeluarga model
    valid_columns = {
        column.name for column in GabunganKeluarga.__table__.columns}

    # Check if any key in the request is not in the valid columns
    invalid_keys = [key for key in data.keys() if key not in valid_columns]
    if invalid_keys:
        return jsonify({"error": f"Invalid keys found: {', '.join(invalid_keys)}"}), 400

    try:
        # Ensure NIK is unique
        existing_record = GabunganKeluarga.query.filter_by(
            NIK=data["NIK"]).first()
        if existing_record:
            return jsonify({"error": "Record with this NIK already exists"}), 400

        # Assign the current user as the creator
        data["created_by"] = current_username

        # Create and save the new record
        new_record = GabunganKeluarga(**data)
        db.session.add(new_record)
        db.session.commit()
        return jsonify({"message": "Record created successfully", "data": data}), 201

    except IntegrityError:
        db.session.rollback()
        return jsonify({"error": "Database integrity error"}), 400
    except Exception as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500


@app.route("/api/kartu_keluarga/<nik>", methods=["GET"])
@jwt_required()
def get_kartu_keluarga(nik):
    jwt_data = get_jwt()
    current_user_username = jwt_data.get("sub")  # Get the username from JWT
    current_user_role = jwt_data.get("role")  # Get the role from JWT

    record = GabunganKeluarga.query.filter_by(NIK=nik).first()
    if not record:
        return jsonify({"error": "Record not found"}), 404

    # Check if the current user is an admin or the creator of the record
    if current_user_role != "admin" and record.created_by != current_user_username:
        return jsonify({"error": "You are not authorized to access this record"}), 403

    record_dict = {column.name: getattr(
        record, column.name) for column in record.__table__.columns}
    return jsonify({"record": record_dict}), 200


@app.route("/api/kartu_keluarga/<nik>", methods=["PATCH"])
@jwt_required()
def update_kartu_keluarga(nik):
    jwt_data = get_jwt()
    current_user_username = jwt_data.get("sub")
    current_user_role = jwt_data.get("role")

    record = GabunganKeluarga.query.filter_by(NIK=nik).first()
    if not record:
        return jsonify({"error": "Record not found"}), 404

    if current_user_role != "admin" and record.created_by != current_user_username:
        return jsonify({"error": "You are not authorized to update this record"}), 403

    data = request.json

    # Get all valid columns from the GabunganKeluarga model
    valid_columns = {
        column.name for column in GabunganKeluarga.__table__.columns}

    # Check if any key in the request is not in the valid columns
    invalid_keys = [key for key in data.keys() if key not in valid_columns]
    if invalid_keys:
        return jsonify({"error": f"Invalid keys found: {', '.join(invalid_keys)}"}), 400

    try:
        for key, value in data.items():
            setattr(record, key, value)

        db.session.commit()
        return jsonify({"message": "Record updated successfully", "updated_data": data}), 200

    except Exception as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500


@app.route("/api/kartu_keluarga/<nik>", methods=["DELETE"])
@jwt_required()
def delete_kartu_keluarga(nik):
    jwt_data = get_jwt()
    current_user_username = jwt_data.get("sub")
    current_user_role = jwt_data.get("role")

    record = GabunganKeluarga.query.filter_by(NIK=nik).first()
    if not record:
        return jsonify({"error": "Record not found"}), 404

    # Authorization check
    if current_user_role != "admin" and record.created_by != current_user_username:
        return jsonify({"error": "You are not authorized to delete this record"}), 403

    db.session.delete(record)
    db.session.commit()

    return jsonify({"message": "Record deleted successfully"}), 200


if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(host='127.0.0.1', port=8000, debug=True)  # Keep debug=True
