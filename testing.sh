#!/bin/bash

# ==================== REGISTRASI ====================
echo "1. Registrasi User Baru (Valid)"
curl -X POST http://localhost:8000/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "user",
    "password": "user",
    "nama_lengkap": "odiq",
    "jabatan": "warga"
  }'

echo -e "\n\n2. Registrasi dengan Username yang Sudah Ada (Invalid)"
curl -X POST http://localhost:8000/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "user",
    "password": "user",
    "nama_lengkap": "odiq",
    "jabatan": "warga"
  }'

# ==================== LOGIN ====================
echo -e "\n\n3. Login Valid"
curl -X POST http://localhost:8000/login \
  -H "Content-Type: application/json" \
  -d '{"username": "user", "password": "user"}'

echo -e "\n\n4. Login dengan Password Salah (Invalid)"
curl -X POST http://localhost:8000/login \
  -H "Content-Type: application/json" \
  -d '{"username": "user", "password": "wrongpassword"}'

# ==================== MEMBUAT FORMULIR KTP ====================
echo -e "\n\n5. User Membuat Formulir (Valid)"
curl -X POST http://localhost:8000/api/ktp/form_ktp \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0MTgyOTU3MSwianRpIjoiNTcwODRkZjYtNjA1Yy00YzZkLTk2YjUtMzk3NGVmMmE0OGJkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6InVzZXIiLCJuYmYiOjE3NDE4Mjk1NzEsImNzcmYiOiI4YzRhOGE2Ny1hMTZmLTQ3YTItYjE4YS1iYjNmMzY4N2RjNmIiLCJleHAiOjE3NDE4MzMxNzEsInJvbGUiOiJ1c2VyIn0.5InT2fRZjxzG5Bjxd6d7LDUEuJoHK0nkX2MqqtY103g" \
  -d '{
    "NIK": "1234567890123456",
    "nama_lengkap": "odiq",
    "opsi": "baru"
  }'

echo -e "\n\n6. User Mencoba Menginput Nomor Surat (Invalid)"
curl -X POST http://localhost:8000/api/ktp/form_ktp \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0MTgyOTU3MSwianRpIjoiNTcwODRkZjYtNjA1Yy00YzZkLTk2YjUtMzk3NGVmMmE0OGJkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6InVzZXIiLCJuYmYiOjE3NDE4Mjk1NzEsImNzcmYiOiI4YzRhOGE2Ny1hMTZmLTQ3YTItYjE4YS1iYjNmMzY4N2RjNmIiLCJleHAiOjE3NDE4MzMxNzEsInJvbGUiOiJ1c2VyIn0.5InT2fRZjxzG5Bjxd6d7LDUEuJoHK0nkX2MqqtY103g" \
  -d '{
    "NIK": "1234567890123456",
    "nama_lengkap": "odiq",
    "opsi": "baru",
    "nomor_surat": "USER-001"
  }'

echo -e "\n\n7. Admin Membuat Formulir dengan Nomor Surat (Valid)"
curl -X POST http://localhost:8000/api/ktp/form_ktp \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <token-admin>" \
  -d '{
    "NIK": "1234567890123456",
    "nama_lengkap": "Admin User",
    "opsi": "baru",
    "nomor_surat": "ADMIN-001"
  }'

# ==================== MENGUPDATE FORMULIR KTP ====================
echo -e "\n\n8. User Mengupdate Formulir Miliknya (Valid)"
curl -X PATCH http://localhost:8000/api/ktp/form_ktp/<form-id> \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0MTgyOTU3MSwianRpIjoiNTcwODRkZjYtNjA1Yy00YzZkLTk2YjUtMzk3NGVmMmE0OGJkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6InVzZXIiLCJuYmYiOjE3NDE4Mjk1NzEsImNzcmYiOiI4YzRhOGE2Ny1hMTZmLTQ3YTItYjE4YS1iYjNmMzY4N2RjNmIiLCJleHAiOjE3NDE4MzMxNzEsInJvbGUiOiJ1c2VyIn0.5InT2fRZjxzG5Bjxd6d7LDUEuJoHK0nkX2MqqtY103g" \
  -d '{
    "nama_lengkap": "odiq Updated"
  }'

echo -e "\n\n9. User Mencoba Mengupdate Nomor Surat (Invalid)"
curl -X PATCH http://localhost:8000/api/ktp/form_ktp/<form-id> \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0MTgyOTU3MSwianRpIjoiNTcwODRkZjYtNjA1Yy00YzZkLTk2YjUtMzk3NGVmMmE0OGJkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6InVzZXIiLCJuYmYiOjE3NDE4Mjk1NzEsImNzcmYiOiI4YzRhOGE2Ny1hMTZmLTQ3YTItYjE4YS1iYjNmMzY4N2RjNmIiLCJleHAiOjE3NDE4MzMxNzEsInJvbGUiOiJ1c2VyIn0.5InT2fRZjxzG5Bjxd6d7LDUEuJoHK0nkX2MqqtY103g" \
  -d '{
    "nomor_surat": "USER-002"
  }'

echo -e "\n\n10. Admin Mengupdate Nomor Surat (Valid)"
curl -X PATCH http://localhost:8000/api/ktp/form_ktp/<form-id> \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <token-admin>" \
  -d '{
    "nomor_surat": "ADMIN-002"
  }'

# ==================== MENGHAPUS FORMULIR KTP ====================
echo -e "\n\n11. User Menghapus Formulir Miliknya (Valid)"
curl -X DELETE http://localhost:8000/api/ktp/form_ktp/<form-id> \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0MTgyOTU3MSwianRpIjoiNTcwODRkZjYtNjA1Yy00YzZkLTk2YjUtMzk3NGVmMmE0OGJkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6InVzZXIiLCJuYmYiOjE3NDE4Mjk1NzEsImNzcmYiOiI4YzRhOGE2Ny1hMTZmLTQ3YTItYjE4YS1iYjNmMzY4N2RjNmIiLCJleHAiOjE3NDE4MzMxNzEsInJvbGUiOiJ1c2VyIn0.5InT2fRZjxzG5Bjxd6d7LDUEuJoHK0nkX2MqqtY103g"

echo -e "\n\n12. User Mencoba Menghapus Formulir Orang Lain (Invalid)"
curl -X DELETE http://localhost:8000/api/ktp/form_ktp/<form-id> \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0MTgyOTU3MSwianRpIjoiNTcwODRkZjYtNjA1Yy00YzZkLTk2YjUtMzk3NGVmMmE0OGJkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6InVzZXIiLCJuYmYiOjE3NDE4Mjk1NzEsImNzcmYiOiI4YzRhOGE2Ny1hMTZmLTQ3YTItYjE4YS1iYjNmMzY4N2RjNmIiLCJleHAiOjE3NDE4MzMxNzEsInJvbGUiOiJ1c2VyIn0.5InT2fRZjxzG5Bjxd6d7LDUEuJoHK0nkX2MqqtY103g"

echo -e "\n\n13. Admin Menghapus Formulir (Valid)"
curl -X DELETE http://localhost:8000/api/ktp/form_ktp/<form-id> \
  -H "Authorization: Bearer <token-admin>"

# ==================== MELIHAT DETAIL FORMULIR KTP ====================
echo -e "\n\n14. User Melihat Formulir Miliknya (Valid)"
curl -X GET http://localhost:8000/api/ktp/form_ktp/<form-id> \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0MTgyOTU3MSwianRpIjoiNTcwODRkZjYtNjA1Yy00YzZkLTk2YjUtMzk3NGVmMmE0OGJkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6InVzZXIiLCJuYmYiOjE3NDE4Mjk1NzEsImNzcmYiOiI4YzRhOGE2Ny1hMTZmLTQ3YTItYjE4YS1iYjNmMzY4N2RjNmIiLCJleHAiOjE3NDE4MzMxNzEsInJvbGUiOiJ1c2VyIn0.5InT2fRZjxzG5Bjxd6d7LDUEuJoHK0nkX2MqqtY103g"

echo -e "\n\n15. User Mencoba Melihat Formulir Orang Lain (Invalid)"
curl -X GET http://localhost:8000/api/ktp/form_ktp/<form-id> \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0MTgyOTU3MSwianRpIjoiNTcwODRkZjYtNjA1Yy00YzZkLTk2YjUtMzk3NGVmMmE0OGJkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6InVzZXIiLCJuYmYiOjE3NDE4Mjk1NzEsImNzcmYiOiI4YzRhOGE2Ny1hMTZmLTQ3YTItYjE4YS1iYjNmMzY4N2RjNmIiLCJleHAiOjE3NDE4MzMxNzEsInJvbGUiOiJ1c2VyIn0.5InT2fRZjxzG5Bjxd6d7LDUEuJoHK0nkX2MqqtY103g"

echo -e "\n\n16. Admin Melihat Formulir (Valid)"
curl -X GET http://localhost:8000/api/ktp/form_ktp/<form-id> \
  -H "Authorization: Bearer <token-admin>"

# ==================== ADMIN MENDAPATKAN SEMUA FORMULIR ====================
echo -e "\n\n17. Admin Melihat Semua Formulir (Valid)"
curl -X GET http://localhost:8000/api/ktp/form_ktp \
  -H "Authorization: Bearer <token-admin>"

echo -e "\n\n18. User Mencoba Melihat Semua Formulir (Invalid)"
curl -X GET http://localhost:8000/api/ktp/form_ktp \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0MTgyOTU3MSwianRpIjoiNTcwODRkZjYtNjA1Yy00YzZkLTk2YjUtMzk3NGVmMmE0OGJkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6InVzZXIiLCJuYmYiOjE3NDE4Mjk1NzEsImNzcmYiOiI4YzRhOGE2Ny1hMTZmLTQ3YTItYjE4YS1iYjNmMzY4N2RjNmIiLCJleHAiOjE3NDE4MzMxNzEsInJvbGUiOiJ1c2VyIn0.5InT2fRZjxzG5Bjxd6d7LDUEuJoHK0nkX2MqqtY103g"

# ==================== ADMIN MENDAPATKAN FORMULIR DENGAN OPSI 'sks' ====================
echo -e "\n\n19. Admin Melihat Formulir 'sks' (Valid)"
curl -X GET http://localhost:8000/api/ktp/sks_ktp \
  -H "Authorization: Bearer <token-admin>"

echo -e "\n\n20. User Mencoba Melihat Formulir 'sks' (Invalid)"
curl -X GET http://localhost:8000/api/ktp/sks_ktp \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0MTgyOTU3MSwianRpIjoiNTcwODRkZjYtNjA1Yy00YzZkLTk2YjUtMzk3NGVmMmE0OGJkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6InVzZXIiLCJuYmYiOjE3NDE4Mjk1NzEsImNzcmYiOiI4YzRhOGE2Ny1hMTZmLTQ3YTItYjE4YS1iYjNmMzY4N2RjNmIiLCJleHAiOjE3NDE4MzMxNzEsInJvbGUiOiJ1c2VyIn0.5InT2fRZjxzG5Bjxd6d7LDUEuJoHK0nkX2MqqtY103g"

# ==================== ADMIN MENDAPATKAN RIWAYAT SURAT ====================
echo -e "\n\n21. Admin Melihat Riwayat Surat (Valid)"
curl -X GET http://localhost:8000/api/ktp/riwayat_surat \
  -H "Authorization: Bearer <token-admin>"

echo -e "\n\n22. User Mencoba Melihat Riwayat Surat (Invalid)"
curl -X GET http://localhost:8000/api/ktp/riwayat_surat \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0MTgyOTU3MSwianRpIjoiNTcwODRkZjYtNjA1Yy00YzZkLTk2YjUtMzk3NGVmMmE0OGJkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6InVzZXIiLCJuYmYiOjE3NDE4Mjk1NzEsImNzcmYiOiI4YzRhOGE2Ny1hMTZmLTQ3YTItYjE4YS1iYjNmMzY4N2RjNmIiLCJleHAiOjE3NDE4MzMxNzEsInJvbGUiOiJ1c2VyIn0.5InT2fRZjxzG5Bjxd6d7LDUEuJoHK0nkX2MqqtY103g"