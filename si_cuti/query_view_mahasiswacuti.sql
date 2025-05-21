CREATE VIEW view_mahasiswa_cuti AS
SELECT 
    m.npm, 
    m.nama_mahasiswa, 
    m.program_studi, 
    k.nama_jurusan, 
    m.angkatan, 
    c.semester 
FROM mahasiswa m 
JOIN cuti c ON m.npm = c.npm 
JOIN kajur k ON m.id_kajur = k.id_kajur 
WHERE c.id_cuti IS NOT NULL;