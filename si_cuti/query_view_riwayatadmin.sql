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