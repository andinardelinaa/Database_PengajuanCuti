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