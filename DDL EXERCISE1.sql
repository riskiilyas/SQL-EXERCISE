-- Created by Riski Ilyas
-- NRP 5025211189
-- 27 - 10 - 2022

-- NO. 1
CREATE TABLE kelompokfilm (
  jenis VARCHAR(100) NOT NULL PRIMARY KEY,
  harga_sewa INT NOT NULL
);

CREATE TABLE customer (
    no_identitas CHAR(3) NOT NULL PRIMARY KEY,
    jenis_identitas CHAR(3) NOT NULL,
    nama VARCHAR(100) NOT NULL,
    alamat VARCHAR(100) NOT NULL
);

CREATE TABLE film (
    kode_film CHAR(3) NOT NULL PRIMARY KEY,
    jenis VARCHAR(200) NOT NULL,
    judul VARCHAR(100) NOT NULL,
    jml_keping INT NOT NULL,
    jml_film INT NOT NULL,
    CONSTRAINT fk_film_kelompokfilm FOREIGN KEY (jenis) REFERENCES kelompokfilm(jenis)
);

CREATE TABLE menyewa (
    kode_sewa CHAR(5) NOT NULL PRIMARY KEY,
    no_identitas CHAR(3) NOT NULL,
    tgl_sewa DATE NOT NULL,
    tot_film INT NOT NULL,
    tgl_kembali DATE,
    tot_hrg INT NOT NULL,
    denda INT NOT NULL,
    CONSTRAINT fk_menyewa_customer FOREIGN KEY (no_identitas) REFERENCES customer(no_identitas)
);

CREATE TABLE detailmenyewa (
  kode_sewa CHAR(5) NOT NULL,
  kode_film CHAR(3) NOT NULL,
  CONSTRAINT fk_detailmenyewa_menyewa FOREIGN KEY (kode_sewa) REFERENCES menyewa(kode_sewa),
  CONSTRAINT fk_detailmenyewa_film FOREIGN KEY (kode_film) REFERENCES film(kode_film)
);

INSERT INTO CUSTOMER VALUES('001', 'SIM', 'ANDI', 'PONTIANAK');
INSERT INTO CUSTOMER VALUES('002', 'SIM', 'BUDI', 'PONTIANAK');

INSERT INTO MENYEWA VALUES('S0001', '001', to_date('2007-01-01', 'yyyy-mm-dd'), 2,  to_date('2007-01-02', 'yyyy-mm-dd'), 6000, 0);
INSERT INTO MENYEWA VALUES('S0002', '002',  to_date('2007-01-03', 'yyyy-mm-dd'), 1,  to_date('2007-01-03', 'yyyy-mm-dd'), 3500, 0);
INSERT INTO MENYEWA VALUES('S0003', '001',  to_date('2007-01-06', 'yyyy-mm-dd'), 3,  to_date('2007-01-08', 'yyyy-mm-dd'), 9500, 0);

INSERT INTO KELOMPOKFILM VALUES('action', 3000);
INSERT INTO KELOMPOKFILM VALUES('drama', 3500);
INSERT INTO KELOMPOKFILM VALUES('horor', 3000);

INSERT INTO FILM VALUES('A01', 'action', 'SPIDERMAN', 2, 3);
INSERT INTO FILM VALUES('A02', 'action', 'SPIDERMAN 2', 2, 5);
INSERT INTO FILM VALUES('D01', 'drama', 'LOVE STORY', 2, 3);
INSERT INTO FILM VALUES('H01', 'horor', 'EVIL DEATH', 2, 2);

INSERT INTO DETAILMENYEWA VALUES('S0001', 'A01');
INSERT INTO DETAILMENYEWA VALUES('S0001', 'A02');
INSERT INTO DETAILMENYEWA VALUES('S0002', 'D01');
INSERT INTO DETAILMENYEWA VALUES('S0003', 'A02');
INSERT INTO DETAILMENYEWA VALUES('S0003', 'D01');
INSERT INTO DETAILMENYEWA VALUES('S0003', 'H01');

-- NO. 2
ALTER TABLE customer
add no_hp VARCHAR(13);

-- NO. 3
ALTER TABLE film
modify jenis varchar(20);

-- NO. 4
ALTER TABLE customer
RENAME COLUMN no_hp to no_wa;

-- NO. 5
ALTER TABLE customer
DROP COLUMN jenis_identitas;

-- NO. 6
CREATE VIEW filmview as SELECT * FROM film where jml_film > 2;