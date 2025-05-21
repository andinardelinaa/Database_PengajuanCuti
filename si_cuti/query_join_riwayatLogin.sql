SELECT m.npm, m.nama_mahasiswa, m.program_studi, k.nama_jurusan, m.angkatan, 
       c.semester
FROM mahasiswa m
JOIN cuti c ON m.npm = c.npm
join kajur k on m.id_kajur = k.id_kajur
WHERE c.id_cuti IS NOT NULL
AND m.npm = 'npm_logged_in';