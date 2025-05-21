CREATE TABLE admin (
    id_admin INT(3) AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    id_user INT(5),
    FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);