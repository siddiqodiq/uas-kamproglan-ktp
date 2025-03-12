# Sistem Pengelolaan Form KTP

Sistem ini adalah aplikasi berbasis Flask untuk mengelola formulir pembuatan KTP. Aplikasi ini memiliki fitur autentikasi pengguna dengan peran **admin** dan **user**, serta mendukung penyimpanan data menggunakan MySQL.

## Fitur Utama

- **Registrasi & Login** menggunakan JWT Authentication
- **Manajemen Formulir KTP** untuk warga desa
- **Validasi Input** menggunakan Pydantic
- **Role-Based Access Control** untuk membatasi akses fitur
- **Database MySQL** untuk penyimpanan data

## Instalasi

### 1. Clone Repository

```sh
git clone https://github.com/username/repository.git
cd repository
```

### 2. Buat Virtual Environment (Opsional)

```sh
python -m venv venv
source venv/bin/activate  # Mac/Linux
venv\Scripts\activate     # Windows
```

### 3. Install Dependencies

```sh
pip install -r requirements.txt
```

### 4. Konfigurasi Database

Pastikan MySQL sudah berjalan dan buat database dengan menjalankan file **dbdesa.sql**.

```sh
mysql -u root -p < dbdesa.sql
```

Lalu sesuaikan konfigurasi database pada **config.py**:

```python
class Config:
    SQLALCHEMY_DATABASE_URI = 'mysql://username:password@localhost/nama_database'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    JWT_SECRET_KEY = 'supersecretkey'
```

Tambahkan UUID sebagai default untuk kolom `id` pada tabel `form_ktp`:

```sql
ALTER TABLE form_ktp MODIFY id CHAR(36) PRIMARY KEY DEFAULT (UUID());
```

### 5. Jalankan Aplikasi

```sh
flask run
```

Aplikasi akan berjalan di `http://127.0.0.1:5000/`.

---

## Cara Testing API

Gunakan **Postman** atau **cURL** untuk menguji endpoint.

### 1. Registrasi User

```sh
curl -X POST http://127.0.0.1:5000/register -H "Content-Type: application/json" -d '{
    "username": "testuser",
    "password": "password123",
    "nama_lengkap": "Test User",
    "jabatan": "Warga",
    "role": "user"
}'
```

### 2. Login dan Dapatkan Token

```sh
curl -X POST http://127.0.0.1:5000/login -H "Content-Type: application/json" -d '{
    "username": "testuser",
    "password": "password123"
}'
```

**Response:**

```json
{
    "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJI..."
}
```

**Simpan token ini untuk permintaan selanjutnya.**

### 3. Membuat Formulir KTP (User)

```sh
curl -X POST http://127.0.0.1:5000/api/ktp/form_ktp -H "Content-Type: application/json" \
     -H "Authorization: Bearer ACCESS_TOKEN" -d '{
    "NIK": "1234567890123456",
    "nama_lengkap": "Test User",
    "opsi": "baru",
    "dokumen_path": null
}'
```

### 4. Mendapatkan Semua Form KTP (Admin)

```sh
curl -X GET http://127.0.0.1:5000/api/ktp/form_ktp -H "Authorization: Bearer ACCESS_TOKEN"
```

### 5. Mendapatkan Riwayat Surat (Admin)

```sh
curl -X GET http://127.0.0.1:5000/api/ktp/riwayat_surat -H "Authorization: Bearer ACCESS_TOKEN"
```

## Struktur Direktori

```
repository/
│-- app.py              # Entry point aplikasi
│-- models.py           # Model database
│-- schemas.py          # Validasi data
│-- config.py           # Konfigurasi aplikasi
│-- requirements.txt    # Dependensi proyek
│-- dbdesa.sql          # Skrip database
```

---

