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
