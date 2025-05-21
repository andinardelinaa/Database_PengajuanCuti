SELECT u.username, m.npm, m.nama_mahasiswa, m.program_studi, k.nama_jurusan, m.email, k.nama_kajur, c.status, c.tgl_pengajuan
FROM mahasiswa m
JOIN user u ON m.id_user = u.id_user
JOIN kajur k ON m.id_kajur = k.id_kajur
LEFT JOIN cuti c ON m.npm = c.npm;