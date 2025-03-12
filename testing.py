import pytest
import logging
from app import app, db
from models import Pengguna, FormKTP
from schemas import PenggunaCreate, FormKTPCreate
from flask_jwt_extended import create_access_token

logging.basicConfig(level=logging.INFO)

@pytest.fixture
def client():
    app.config['TESTING'] = True
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
    app.config['JWT_SECRET_KEY'] = 'testing-secret-key'

    with app.test_client() as client:
        with app.app_context():
            db.create_all()
        yield client
        with app.app_context():
            db.drop_all()

@pytest.fixture
def auth_tokens(client):
    logging.info("Running auth_tokens fixture")
    # Registrasi user
    user_data = {
        "username": "testuser",
        "password": "testpass",
        "nama_lengkap": "Test User",
        "role": "user"
    }
    client.post('/register', json=user_data)

    # Login user
    login_response = client.post('/login', json={
        "username": "testuser",
        "password": "testpass"
    })
    return login_response.json['access_token']

def test_register(client):
    logging.info("Running test_register")
    # Test registrasi user baru
    response = client.post('/register', json={
        "username": "newuser",
        "password": "newpass",
        "nama_lengkap": "New User",
        "role": "user"
    })
    assert response.status_code == 201
    assert response.json['msg'] == "Registrasi berhasil"

    # Test registrasi dengan username yang sudah ada
    response = client.post('/register', json={
        "username": "newuser",
        "password": "newpass",
        "nama_lengkap": "New User",
        "role": "user"
    })
    assert response.status_code == 400
    assert response.json['msg'] == "Username sudah terdaftar"

def test_login(client):
    logging.info("Running test_login")
    # Registrasi user terlebih dahulu
    client.post('/register', json={
        "username": "testuser",
        "password": "testpass",
        "nama_lengkap": "Test User",
        "role": "user"
    })

    # Test login berhasil
    response = client.post('/login', json={
        "username": "testuser",
        "password": "testpass"
    })
    assert response.status_code == 200
    assert 'access_token' in response.json

    # Test login gagal
    response = client.post('/login', json={
        "username": "testuser",
        "password": "wrongpass"
    })
    assert response.status_code == 401
    assert response.json['msg'] == "Username atau password salah"

def test_create_form(client, auth_tokens):
    logging.info("Running test_create_form")
    headers = {'Authorization': f'Bearer {auth_tokens}'}

    # Test membuat formulir form_ktp
    response = client.post('/api/ktp/form_ktp', headers=headers, json={
        "NIK": "1234567890123456",
        "nama_lengkap": "John Doe",
        "opsi": "baru"
    })
    assert response.status_code == 201
    assert response.json['msg'] == "Formulir form_ktp berhasil dibuat"

    # Test membuat formulir sks_ktp
    response = client.post('/api/ktp/sks_ktp', headers=headers, json={
        "NIK": "1234567890123456",
        "nama_lengkap": "John Doe",
        "opsi": "sks"
    })
    assert response.status_code == 201
    assert response.json['msg'] == "Formulir sks_ktp berhasil dibuat"

    # Test membuat formulir dengan jenis tidak valid
    response = client.post('/api/ktp/invalid_type', headers=headers, json={
        "NIK": "1234567890123456",
        "nama_lengkap": "John Doe",
        "opsi": "baru"
    })
    assert response.status_code == 400
    assert "Jenis formulir tidak valid" in response.json['msg']

def test_update_form(client, auth_tokens):
    logging.info("Running test_update_form")
    headers = {'Authorization': f'Bearer {auth_tokens}'}

    # Buat formulir terlebih dahulu
    client.post('/api/ktp/form_ktp', headers=headers, json={
        "NIK": "1234567890123456",
        "nama_lengkap": "John Doe",
        "opsi": "baru"
    })

    # Test update formulir
    response = client.patch('/api/ktp/form_ktp/1', headers=headers, json={
        "nama_lengkap": "Jane Doe"
    })
    assert response.status_code == 200
    assert response.json['msg'] == "Formulir form_ktp berhasil diperbarui"

    # Test update formulir dengan jenis tidak valid
    response = client.patch('/api/ktp/invalid_type/1', headers=headers, json={
        "nama_lengkap": "Jane Doe"
    })
    assert response.status_code == 400
    assert "Jenis formulir tidak valid" in response.json['msg']

def test_delete_form(client, auth_tokens):
    logging.info("Running test_delete_form")
    headers = {'Authorization': f'Bearer {auth_tokens}'}

    # Buat formulir terlebih dahulu
    client.post('/api/ktp/form_ktp', headers=headers, json={
        "NIK": "1234567890123456",
        "nama_lengkap": "John Doe",
        "opsi": "baru"
    })

    # Test hapus formulir
    response = client.delete('/api/ktp/form_ktp/1', headers=headers)
    assert response.status_code == 200
    assert response.json['msg'] == "Formulir form_ktp berhasil dihapus"

    # Test hapus formulir dengan jenis tidak valid
    response = client.delete('/api/ktp/invalid_type/1', headers=headers)
    assert response.status_code == 400
    assert "Jenis formulir tidak valid" in response.json['msg']

def test_download_signed_form(client, auth_tokens):
    logging.info("Running test_download_signed_form")
    headers = {'Authorization': f'Bearer {auth_tokens}'}

    # Buat formulir terlebih dahulu
    client.post('/api/ktp/form_ktp', headers=headers, json={
        "NIK": "1234567890123456",
        "nama_lengkap": "John Doe",
        "opsi": "baru"
    })

    # Test unduh formulir
    response = client.get('/api/ktp/form_ktp_sign/1', headers=headers)
    assert response.status_code == 200
    assert response.json['nama_lengkap'] == "John Doe"

    # Test unduh formulir dengan jenis tidak valid
    response = client.get('/api/ktp/invalid_type_sign/1', headers=headers)
    assert response.status_code == 400
    assert "Jenis formulir tidak valid" in response.json['msg']