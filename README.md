# 🌐 SISTEM PENGAJUAN CUTI MAHASISWA

**Andin Ardelina Saputri**  
Informatics Engineering — Politeknik Negeri Cilacap  
GitHub: [@andinardelina](https://github.com/andinardelinaa)  
LinkedIn: [linkedin.com/in/andinardelina](https://linkedin.com/in/andinardelina)

# Deskripsi Project
Sistem ini memungkinkan mahasiswa untuk mengajukan cuti kuliah secara online.
Dengan adanya sistem ini, mahasiswa dapat mengajukan cuti tanpa harus datang langsung ke bagian akademik, sehingga lebih praktis, terutama jika alasan pengajuan cuti adalah kondisi kesehatan yang tidak memungkinkan untuk datang ke kampus.

##  ERD sistem Pengajuan Cuti
![Pengajuanuti (7)](https://github.com/user-attachments/assets/9cbb55a8-331a-414d-b4de-46043ebe0511)

### Fitur Utama:

 ✅ Login Mahasiswa & Admin Akademik
 
 ✅ Form Pengajuan Cuti dengan Alasan dan Dokumen Pendukung
 
 ✅ Persetujuan/Ditolak oleh Admin Akademik
 
 ✅ Notifikasi Hasil Pengajuan
 
 ✅ Riwayat Cuti Mahasiswa

## 🔗 Relasi Antar Tabel dalam ERD**

### 1. **`user` ke `mahasiswa`, `kajur`, dan `admin`**

**Relasi:**

* **One to One (1:1)**
* Satu baris di `user` bisa menjadi **mahasiswa**, **kajur**, atau **admin** (sesuai `level`).
**Artinya:**
Setiap mahasiswa, kajur, atau admin memiliki **satu akun user**, dan setiap user hanya memiliki **satu peran** di salah satu tabel tersebut.

### 2. **`mahasiswa` ke `kajur`**

**Relasi:**

* **Many to One (N:1)**
* Banyak mahasiswa bisa punya satu ketua jurusan (kajur).
**Artinya:**
Satu kajur membawahi banyak mahasiswa, tapi satu mahasiswa hanya punya satu kajur.

### 3. **`mahasiswa` ke `cuti`**

**Relasi:**

* **One to one (1\:1)**
* Satu mahasiswa bisa mengajukan **banyak pengajuan cuti**.

**Artinya:**
Seorang mahasiswa hanya bisa mengajukan satu cuti, dan satu engajuan cuti hanya dimiliki satu mahasiswa

## Struktur Table
### 1. Query Create tabel user

```bash
CREATE TABLE user (
    id_user INT(5) AUTO_INCREMENT PRIMARY KEY, 
    username VARCHAR(50) NOT NULL,           
    password VARCHAR(255) NOT NULL,
    level VARCHAR(30) NOT NULL);
```
Tabel user menjadi tabel utama karena memiliki peran utama dalam managemen akses dan identitas pengguna, menyimpan data pengguna dan dapat dihubungkan ke tabel pengguna lain. Kolom id_user menjadi primary key yang bersifat unique dan auto_increment. Tabel lain membutuhkan data pengguna mengambil id_user sebagai foreign key.

### 2. Query Create table Kajur 

```bash
CREATE TABLE kajur (
id_kajur INT(3) AUTO_INCREMENT PRIMARY KEY,
nama_kajur VARCHAR(50) NOT NULL,
nidn VARCHAR(20) NOT NULL,
nama_jurusan VARCHAR(30) NOT NULL,
id_user INT(5),
FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE);
```
Tabel Kajur digunakan untuk menyimpan data kajur

### 3. Query Create table Cuti 

```bash
CREATE TABLE cuti (
id_cuti INT(3) AUTO_INCREMENT PRIMARY KEY,
npm INT(9),
status VARCHAR(50) NOT NULL,
tgl_pengajuan TIMESTAMP NOT NULL,
semester INT(2) NOT NULL,
dokumen_pendukung CHAR,
alasan VARCHAR(200) NOT NULL,
FOREIGN KEY(npm) REFERENCES mahasiswa(npm) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT unique_cuti UNIQUE (npm, semester)
);
```
Tabel cuti digunakan untuk menyimpan informasi mahasiswa yang mengajukan cuti, dengan id_cuti auto increment sebagai primary key, mengambil npm dari primary key tabel mahasiswa sebagai foreign key.

### 4. Query Create table mahasiswa
```bash
CREATE TABLE mahasiswa (
    npm INT(9) PRIMARY KEY NOT NULL,
    id_user INT(5),
    id_kajur INT(3),
    nama_mahasiswa VARCHAR(50) NOT NULL,
    tempat_tanggal_lahir VARCHAR(100) NOT NULL,
    jenis_kelamin ENUM('Laki-laki', 'Perempuan') NOT NULL,
    alamat VARCHAR(200) NOT NULL,
    agama VARCHAR(20) NOT NULL,
    angkatan VARCHAR(10) NOT NULL,
    program_studi VARCHAR(50) NOT NULL,
    no_hp VARCHAR(13) NOT NULL,
    email VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_kajur) REFERENCES kajur(id_kajur) ON DELETE CASCADE ON UPDATE CASCADE
);
```
tabel ini berisi data mahasiswa, dengan npm sebagai primary key, id_kajur sebagai foreign key yang diambil dari table kajur, dan id_user sebagai foreign key yang di ambil dari table user

### 4. Query Create table Admin

```bash
CREATE TABLE admin (
    id_admin INT(3) AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    id_user INT(5),
    FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);
```

### 5. Query Insert Mahasiswa
```bash
insert into mahasiswa (npm, id_user, id_kajur, nama_mahasiswa,tempat_tanggal_lahir, jenis_kelamin, alamat, agama, angkatan, program_studi, no_hp, email)
values ('230102052', 3, 1, 'nana','Cilacap, 2005-02-02', 'Perempuan','Cilacap', 'Islam', '2022', 'Teknik Informatika', '0812345678912', 'nama@gmail.com');
```
### 6. Query Join Riwayat Login

```bash
SELECT m.npm, m.nama_mahasiswa, m.program_studi, k.nama_jurusan, m.angkatan, 
       c.semester
FROM mahasiswa m
JOIN cuti c ON m.npm = c.npm
join kajur k on m.id_kajur = k.id_kajur
WHERE c.id_cuti IS NOT NULL
AND m.npm = 'npm_logged_in';
```
join digunakan untuk menggabungkan bebrapa table, ini adalah join untuk beranda pada mahasiswa yang sedang melakukan login.

### 7. Query View BerandaKajur
```bash
CREATE VIEW view_beranda_Kajur
 AS
SELECT 
    u.username, 
    m.npm, 
    m.nama_mahasiswa, 
    m.program_studi, 
    k.nama_jurusan, 
    m.email, 
    k.nama_kajur, 
    c.semester, 
    c.tgl_pengajuan
FROM mahasiswa m
JOIN user u ON m.id_user = u.id_user
JOIN kajur k ON m.id_kajur = k.id_kajur
LEFT JOIN cuti c ON m.npm = c.npm;
```
view dibuat untuk taampilan pada beranda kajur apabila ada mahasiswa yang melakukan pengajuan cuti

### 8. Query View RiwayatAdmin

```bash
CREATE VIEW view_riwayat_admin AS
SELECT 
    u.username, 
    m.npm, 
    m.nama_mahasiswa, 
    m.program_studi, 
    k.nama_jurusan,  
    k.nama_kajur, 
    c.semester, 
    c.tgl_pengajuan, 
    m.no_hp, 
    m.email
FROM mahasiswa m
JOIN user u ON m.id_user = u.id_user
JOIN kajur k ON m.id_kajur = k.id_kajur
LEFT JOIN cuti c ON m.npm = c.npm;
```
Menyediakan tampilan terstruktur bagi admin akademik dalam melihat riwayat pengajuan cuti mahasiswa serta menggabungkan data dari beberapa tabel (user, mahasiswa, kajur, dan cuti) agar admin dapat dengan mudah memantau status mahasiswa yang sudah mengajukan cuti.

### Dokumentasi terstruktur dan query yang digunakan dapat diakkses pada link berikut :
https://drive.google.com/drive/u/0/folders/1sR-Sz6WdNAF7rDQ5nyLQB1UYO0QLOVm-
