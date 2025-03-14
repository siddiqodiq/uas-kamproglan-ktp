# Sistem Pengelolaan Form KK

Sistem ini adalah aplikasi berbasis Flask untuk mengelola formulir pembuatan Kartu Keluarga. Aplikasi ini memiliki fitur autentikasi pengguna dengan peran **admin** dan **user**, serta mendukung penyimpanan data menggunakan MySQL.

## Fitur Utama

- **Registrasi & Login** menggunakan JWT Authentication
- **Manajemen Formulir KK** untuk warga desa
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

Pastikan MySQL sudah berjalan dan buat database dengan menjalankan file **kartukeluarga.sql**.

```sh
mysql -u root -p < kartukeluarga.sql
```

Lalu sesuaikan konfigurasi database pada **config.py**:

```python
class Config:
    SQLALCHEMY_DATABASE_URI = 'mysql://username:password@localhost/nama_database'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    JWT_SECRET_KEY = 'supersecretkey'
```

### 5. Jalankan Aplikasi

```sh
flask run
```

Aplikasi akan berjalan di `http://127.0.0.1:8000/`.

---

## Cara Testing API

Gunakan **Postman** atau **cURL** untuk menguji endpoint.

### 1. Registrasi User

```sh
curl -X POST http://127.0.0.1:8000/register -H "Content-Type: application/json" -d '{
    "username": "testuser",
    "password": "password123",
    "nama_lengkap": "Test User"
}'
```

### 2. Login dan Dapatkan Token

```sh
curl -X POST http://127.0.0.1:8000/login -H "Content-Type: application/json" -d '{
    "username": "testuser",
    "password": "password123"
}'
```

**Response:**

```json
{
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6..."
}
```

**Simpan token ini untuk permintaan selanjutnya.**

### 3. Membuat Formulir KK (User)

```sh
curl -X POST http://127.0.0.1:8000/api/kartu_keluarga -H "Content-Type: application/json" \
     -H "Authorization: Bearer ACCESS_TOKEN" -d '{
        "NIK": "9876543210987654",
        "Nomor_KK": "1234567890123456",
        "nama_lengkap": "Rizky Fadillah",
        "Gelar_Depan": "Prof.",
        "Gelar_Belakang": "Ph.D",
        "Passport_Number": "B98765432",
        "Tgl_Berakhir_Paspor": "2032-07-20",
        "Nama_Sponsor": "CV. Sukses Abadi",
        "Tipe_Sponsor": "Individu",
        "Alamat_Sponsor": "Jl. Diponegoro No. 99, Bandung",
        "Jenis_Kelamin": "Laki-Laki",
        "Tempat_Lahir": "Bandung",
        "Tanggal_Lahir": "1985-11-25",
        "Kewarganegaraan": "Indonesia",
        "No_SK_Penetapan_WNI": "SK87654321",
        "Akta_Lahir": 1,
        "Nomor_Akta_Kelahiran": "AKT654321",
        "Golongan_Darah": "A",
        "Agama": "Kristen",
        "Nama_Organisasi_Kepercayaan": "Gereja Bethel",
        "Status_Perkawinan": "Duda",
        "Akta_Perkawinan": 1,
        "Nomor_Akta_Perkawinan": "AKP987654",
        "Tanggal_Perkawinan": "2012-09-18",
        "Akta_Cerai": 1,
        "Nomor_Akta_Cerai": "AC123456",
        "Tanggal_Perceraian": "2019-03-21",
        "Status_Hubungan_Dalam_Keluarga": "Ayah",
        "Kelainan_Fisik_dan_Mental": null,
        "Penyandang_Cacat": 0,
        "Pendidikan_Terakhir": "S2",
        "Jenis_Pekerjaan": "Dosen",
        "Nomor_ITAS_ITAP": "ITAP987654",
        "Tanggal_Terbit_ITAS_ITAP": "2027-01-05",
        "Tanggal_Akhir_ITAS_ITAP": "2032-01-05",
        "Tempat_Datang_Pertama": "Jakarta",
        "Tanggal_Kedatangan_Pertama": "2008-05-10",
        "NIK_Ibu": "5678901234567890",
        "Nama_Ibu": "Maria Elisabeth",
        "NIK_Ayah": "6789012345678901",
        "Nama_Ayah": "Johannes Haryanto",
        "alamat": "Jl. Kenanga No. 88, Yogyakarta",
        "kode_pos": "55221",
        "rt": "005",
        "rw": "001",
        "jumlah_anggota_keluarga": 3,
        "telepon": "082134567890",
        "email": "rizky.fadillah@email.com",
        "kode_provinsi": "03",
        "nama_provinsi": "DI Yogyakarta",
        "kode_kabupaten": "04",
        "nama_kabupaten": "Sleman",
        "kode_kecamatan": "05",
        "nama_kecamatan": "Depok",
        "kode_desa": "06",
        "nama_desa": "Condongcatur",
        "nama_dusun": "Dusun Sejahtera",
        "alamat_luar_negeri": null,
        "kota_luar_negeri": null,
        "provinsi_negara_bagian_luar_negeri": null,
        "negara_luar_negeri": null,
        "kode_pos_luar_negeri": null,
        "jumlah_anggota_keluarga_luar_negeri": null,
        "telepon_luar_negeri": null,
        "email_luar_negeri": null,
        "kode_negara": "ID",
        "nama_negara": "Indonesia",
        "kode_perwakilan_ri": "07",
        "nama_perwakilan_ri": "KBRI Tokyo",
        "Status_Hidup_Meninggal": "HIDUP",
        "Tgl_Kematian": null,
        "no_hp": "082198765432",
        "tempat_tanggal_lahir_bapak": "Semarang, 1960-12-15",
        "pekerjaan_bapak": "Pengusaha",
        "agama_bapak": "Kristen",
        "alamat_bapak": "Jl. Cemara No. 7, Semarang",
        "tempat_tanggal_lahir_ibu": "Surabaya, 1965-09-30",
        "pekerjaan_ibu": "Guru",
        "agama_ibu": "Kristen",
        "alamat_ibu": "Jl. Cemara No. 7, Semarang",
        "nik_bapak": "7890123456789012",
        "nama_bapak": "Johannes Haryanto",
        "nama_kepala_keluarga": "Rizky Fadillah"
    }'
```

### 4. Mendapatkan Form KK (Admin dan User yang Membuat Formulir KK)

```sh
curl -X GET http://127.0.0.1:8000/api/kartu_keluarga/<nik> -H "Authorization: Bearer ACCESS_TOKEN"
```

### 5. Melakukan perubahan Form KK (Admin dan User yang Membuat Formulir KK)

```sh
curl -X PATCH http://127.0.0.1:8000/api/kartu_keluarga/<nik> -H "Content-Type: application/json" \
     -H "Authorization: Bearer ACCESS_TOKEN" -d '{
        "Pendidikan_Terakhir": "S3"
     }'
```

### 6. Menghapus Form KK (Admin dan User yang Membuat Formulir KK)

```sh
curl -X DELETE http://127.0.0.1:8000/api/kartu_keluarga/<nik> -H "Authorization: Bearer ACCESS_TOKEN"
```

## Struktur Direktori

```
repository/
│-- app.py              # Entry point aplikasi
│-- models.py           # Model database
│-- schemas.py          # Validasi data
│-- config.py           # Konfigurasi aplikasi
│-- requirements.txt    # Dependensi proyek
│-- request.txt         # Contoh request
│-- kartukeluarga.sql   # Skrip database
```

---

