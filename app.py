from flask import Flask, jsonify, request
from flask_jwt_extended import (
    JWTManager, create_access_token, jwt_required, get_jwt_identity, get_jwt
)
from models import DetailKematian, db, Pengguna, DaftarSuratKematian, GabunganKeluarga
from schemas import PenggunaCreate, DaftarSuratKematianSchema, GabunganKeluargaSchema, DetailKematianSchema
from pydantic import ValidationError
from datetime import datetime
from functools import wraps
from models import DaftarSuratKematian, GabunganKeluarga
from schemas import DaftarSuratKematianSchema, GabunganKeluargaSchema, DetailKematianSchema
from sqlalchemy.orm import joinedload

# Inisialisasi aplikasi Flask
app = Flask(__name__)

# Inisialisasi konfigurasi aplikasi
app.config.from_object('config.Config')  # Menambahkan konfigurasi dari objek config.py
db.init_app(app)

# Inisialisasi JWT
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

@app.route('/api/akta_kematian/detail_kematian', methods=['POST'])
@jwt_required()
@role_required('user')
def detail_kematian():
    try:
        data = request.get_json()

        user_id = get_jwt_identity()

        pengguna = Pengguna.query.filter_by(username=user_id).first()
        if not pengguna:
            return jsonify({"error": "Pengguna tidak ditemukan"}), 404
            
        try:
            detail_data = DetailKematianSchema(**data)
        except ValidationError as e:
            return jsonify({"error": str(e)}), 400

        tgl_kematian = datetime.strptime(detail_data.Tgl_Kematian, "%Y-%m-%d").date()
        jam_kematian = datetime.strptime(detail_data.Jam_Kematian, "%H:%M").time()

        # Pastikan Jenis hanya "Surat" atau "Non-Surat"
        if detail_data.Jenis not in ["Surat", "Non-Surat"]:
            return jsonify({"error": "Jenis harus 'Surat' atau 'Non-Surat'"}), 400

        nama_pelapor = pengguna.nama_lengkap

        detail_kematian = DetailKematian(
            NIK=detail_data.NIK,
            Tgl_Kematian=tgl_kematian,
            Jam_Kematian=jam_kematian,
            Lokasi_Kematian=detail_data.Lokasi_Kematian,
            Penyebab_Kematian=detail_data.Penyebab_Kematian,
            Nama_Pelapor=nama_pelapor,
            Hubungan_dengan_Terlapor=detail_data.Hubungan_dengan_Terlapor,
            Jenis=detail_data.Jenis  # Menyimpan jenis kematian
        )

        db.session.add(detail_kematian)
        db.session.commit()

        return jsonify({
            "message": "Data kematian berhasil ditambahkan.",
            "data": detail_data.model_dump()
        }), 201

    except Exception as e:
        db.session.rollback()
        return jsonify({"error": f"Terjadi kesalahan: {str(e)}"}), 500


@app.route('/api/akta_kematian/detail_kematian', methods=['GET'])
@jwt_required()
@role_required('admin')  # Hanya admin yang bisa mengakses
def get_detail_kematian():
    try:
        # Ambil tanggal dari query parameter (opsional)
        tanggal_str = request.args.get('tanggal')

        # Jika admin memberikan tanggal, filter berdasarkan tanggal, jika tidak ambil semua data
        query = db.session.query(DetailKematian).outerjoin(GabunganKeluarga, DetailKematian.NIK == GabunganKeluarga.NIK)

        if tanggal_str:
            try:
                tanggal = datetime.strptime(tanggal_str, '%Y-%m-%d').date()
            except ValueError:
                return jsonify({"error": "Format tanggal tidak valid. Gunakan format YYYY-MM-DD"}), 400
            
            query = query.filter(DetailKematian.Tgl_Kematian == tanggal)

        # Eksekusi query
        detail_kematian_list = query.all()

        if not detail_kematian_list:
            return jsonify({"message": "Tidak ada data kematian yang tersedia untuk tanggal ini."}), 404

        # Menyusun data menjadi format JSON
        detail_kematian_data = []
        for detail in detail_kematian_list:
            # Hitung umur
            umur = None
            if detail.keluarga and detail.keluarga.Tanggal_Lahir:
                tgl_lahir = detail.keluarga.Tanggal_Lahir
                tgl_kematian = detail.Tgl_Kematian
                umur = (tgl_kematian - tgl_lahir).days // 365  # Konversi ke tahun

            detail_kematian_data.append({
                "NIK": detail.NIK,
                "Nama_Lengkap": detail.keluarga.Nama_Lengkap if detail.keluarga else None,
                "Jenis_Kelamin": detail.keluarga.Jenis_Kelamin if detail.keluarga else None,
                "Kewarganegaraan": detail.keluarga.Kewarganegaraan if detail.keluarga else None,
                "Agama": detail.keluarga.Agama if detail.keluarga else None,
                "alamat": detail.keluarga.alamat if detail.keluarga else None,
                "Tgl_Kematian": detail.Tgl_Kematian.strftime("%Y-%m-%d"),
                "Jam_Kematian": detail.Jam_Kematian.strftime("%H:%M"),
                "Lokasi_Kematian": detail.Lokasi_Kematian,
                "Penyebab_Kematian": detail.Penyebab_Kematian,
                "Nama_Pelapor": detail.Nama_Pelapor,
                "Hubungan_dengan_Terlapor": detail.Hubungan_dengan_Terlapor,
                "Jenis": detail.Jenis,
                "Umur": umur  # Tambahkan umur ke response
            })

        return jsonify(detail_kematian_data), 200

    except Exception as e:
        return jsonify({"error": f"Terjadi kesalahan pada database: {str(e)}"}), 500

# API untuk submit PDF SK kematian (admin)
@app.route('/api/akta_kematian/submit_suket_kematian', methods=['POST'])
@jwt_required()
@role_required('admin')
def create_surat_kematian():
    data = request.get_json()

    try:
        surat_kematian_data = DaftarSuratKematianSchema(**data)
    except ValidationError as e:
        return jsonify({"error": e.errors()}), 400

    nik_terlapor = data.get("NIK_Terlapor")
    
    # Mencari data keluarga berdasarkan NIK_Terlapor
    keluarga = GabunganKeluarga.query.filter_by(NIK=nik_terlapor).first()

    if not keluarga:
        return jsonify({"error": "NIK Terlapor tidak ditemukan di database keluarga."}), 404

    # Nama_Terlapor diambil langsung dari Nama_Lengkap di tabel GabunganKeluarga
    nama_terlapor = keluarga.Nama_Lengkap

    try:
        tanggal_terbit = datetime.today().date()
        tanggal_kematian = datetime.strptime(data.get("Tanggal_Kematian"), "%Y-%m-%d").date()

        # Update status dan tanggal kematian di gabungan_keluarga
        keluarga.Status_Hidup_Meninggal = 'MENINGGAL'
        keluarga.Tgl_Kematian = tanggal_kematian
        db.session.commit()

        # Membuat objek surat kematian
        surat_kematian = DaftarSuratKematian(
            Tanggal_Terbit=tanggal_terbit,
            Nomor_Surat=surat_kematian_data.Nomor_Surat,
            Penyimpanan=surat_kematian_data.Penyimpanan,
            NIK_Terlapor=nik_terlapor,  # Menggunakan NIK_Terlapor yang ada di input
            Nama_Terlapor=nama_terlapor,  # Mengambil Nama_Terlapor dari Nama_Lengkap keluarga
            Nama_Petugas=surat_kematian_data.Nama_Petugas,
            Nama_Kades=surat_kematian_data.Nama_Kades
        )

        # Menambahkan data ke tabel daftar_surat_kematian
        db.session.add(surat_kematian)
        db.session.commit()

        return jsonify(surat_kematian_data.dict()), 201
    except Exception as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500

# API untuk melihat daftar SK kematian (admin)
@app.route('/api/akta_kematian/submit_suket_kematian', methods=['GET'])
@jwt_required()
@role_required('admin')
def get_daftar_surat_kematian():
    try:
        surat_kematian_list = DaftarSuratKematian.query.all()
        surat_kematian_data = [{"id": surat.Id, "Nomor_Surat": surat.Nomor_Surat, "Tanggal_Terbit": surat.Tanggal_Terbit, "Penyimpanan": surat.Penyimpanan} for surat in surat_kematian_list]
        return jsonify(surat_kematian_data), 200
    except Exception as e:
        return jsonify({"error": "Terjadi kesalahan saat mengambil data formulir."}), 500

@app.route('/api/akta_kematian/daftar_suket_kematian', methods=['GET'])
@jwt_required()
@role_required('user')  # Hanya user yang bisa mengakses data SK kematian yang mereka laporkan
def get_surat_kematian_user():
    try:
        # Ambil user_id dari JWT
        user_id = get_jwt_identity()
        
        # Cari nama_lengkap pengguna berdasarkan user_id
        pengguna = Pengguna.query.filter_by(username=user_id).first()
        if not pengguna:
            return jsonify({"error": "Pengguna tidak ditemukan"}), 404

        nama_pelapor = pengguna.nama_lengkap  # Nama lengkap dari user yang login
        
        # Cari semua NIK yang dilaporkan oleh user ini di tabel DetailKematian
        nik_list = db.session.query(DetailKematian.NIK).filter_by(Nama_Pelapor=nama_pelapor).all()
        nik_list = [nik[0] for nik in nik_list]  # Ubah hasil query menjadi list NIK
        
        if not nik_list:
            return jsonify({"message": "Anda belum melaporkan kematian apa pun."}), 404
        
        # Ambil semua surat kematian yang memiliki NIK_Terlapor yang ada dalam nik_list
        surat_kematian_list = DaftarSuratKematian.query.filter(DaftarSuratKematian.NIK_Terlapor.in_(nik_list)).all()

        if not surat_kematian_list:
            return jsonify({"message": "Tidak ada SK kematian terkait dengan laporan Anda."}), 404

        # Format data ke JSON
        surat_kematian_data = []
        for surat in surat_kematian_list:
            surat_kematian_data.append({
                "id": surat.Id,
                "Nomor_Surat": surat.Nomor_Surat,
                "Tanggal_Terbit": surat.Tanggal_Terbit.strftime("%Y-%m-%d"),
                "Penyimpanan": surat.Penyimpanan,
                "NIK_Terlapor": surat.NIK_Terlapor,
                "Nama_Terlapor": surat.Nama_Terlapor,
                "Nama_Petugas": surat.Nama_Petugas,
                "Nama_Kades": surat.Nama_Kades
            })

        return jsonify(surat_kematian_data), 200

    except Exception as e:
        return jsonify({"error": f"Terjadi kesalahan: {str(e)}"}), 500


# API untuk melihat daftar kematian warga (admin)
@app.route('/api/akta_kematian/daftar_kematian', methods=['GET'])
@jwt_required()
@role_required('admin')
def get_orang_meninggal():
    try:
        meninggal_list = GabunganKeluarga.query.filter_by(Status_Hidup_Meninggal='MENINGGAL').all()
        meninggal_data = [{"NIK": orang.NIK, "Nama_Lengkap": orang.Nama_Lengkap, "Tgl_Kematian": orang.Tgl_Kematian} for orang in meninggal_list]
        return jsonify(meninggal_data), 200
    except Exception as e:
        return jsonify({"error": "Terjadi kesalahan saat mengambil data orang yang meninggal."}), 500


# API untuk mengubah status hidup meninggal (admin)
@app.route('/api/akta_kematian/ubah_status_kematian', methods=['PATCH'])
@jwt_required()
@role_required('admin')
def ubah_status_hidup_meninggal():
    data = request.get_json()

    nik = data.get("NIK")
    status = data.get("Status_Hidup_Meninggal")

    if not nik or not status:
        return jsonify({"error": "NIK dan Status_Hidup_Meninggal harus ada dalam request body"}), 400

    if status not in ['HIDUP', 'MENINGGAL']:
        return jsonify({"error": "Status harus 'HIDUP' atau 'MENINGGAL'"}), 400

    keluarga = GabunganKeluarga.query.filter_by(NIK=nik).first()

    if not keluarga:
        return jsonify({"error": "NIK tidak ditemukan di database"}), 404

    keluarga.Status_Hidup_Meninggal = status

    if status == 'MENINGGAL':
        tanggal_kematian = data.get("Tgl_Kematian")
        if not tanggal_kematian:
            return jsonify({"error": "Tanggal kematian harus ada jika status adalah MENINGGAL"}), 400
        keluarga.Tgl_Kematian = tanggal_kematian

    db.session.commit()

    return jsonify({
        "NIK": keluarga.NIK,
        "Nama_Lengkap": keluarga.Nama_Lengkap,
        "Status_Hidup_Meninggal": keluarga.Status_Hidup_Meninggal,
        "Tgl_Kematian": keluarga.Tgl_Kematian
    }), 200

# Menjalankan aplikasi Flask
if __name__ == '__main__':
    app.run(debug=True)