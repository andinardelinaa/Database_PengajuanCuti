SELECT m.npm, m.nama_mahasiswa, m.tempat_tanggal_lahir, m.jenis_kelamin, m.agama, m.angkatan, m.program_studi, k.nama_jurusan, m.alamat, m.email, m.no_hp
from mahasiswa m jOIN kajur k ON m.id_kajur=k.id_kajur 
WHERE npm = 'npm_logged_in';