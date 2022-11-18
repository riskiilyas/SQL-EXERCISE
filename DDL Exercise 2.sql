-- Created by Riski Ilyas
-- NRP 5025211189
-- 01 - 11 - 2022

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

-- No. 2 C
Insert into kelompokfilm values('komedi', 5000); 

-- No. 3 C
Insert into film values('K01', 'komedi', 'Kapan Kawin', 10, 2);
Insert into film values('K02', 'komedi', 'Takut Kawin', 6, 3);
Insert into film values('D02', 'drama', 'Ayat Ayat Cinta', 8, 3);
Insert into film values('D03', 'drama', 'Tiga Doa Tiga Cinta', 5, 2);
Insert into film values('H02', 'horor', 'Resident Evil', 7, 4);

-- No. 4 C
update kelompokfilm set harga_sewa = harga_sewa * 10;  

-- No. 5 C
Select kode_film, judul from film where jenis in('horor', 'drama');

-- No. 6 C
select Count(*) from detailmenyewa where kode_sewa = 'S0003';
Revision
select Count(*) as NumberOfData from detailmenyewa where kode_sewa = 'S0003';

-- No. 7 C
select no_identitas, tgl_sewa, tot_film from menyewa where tot_film = (Select MIN(tot_film) from menyewa);

-- No. 8 C
select nama, alamat from customer join menyewa on (menyewa.no_identitas=customer.no_identitas)
where tgl_kembali < to_date('2007-01-05', 'yyyy-mm-dd');

-- No. 9 C
select no_identitas, film.judul from menyewa join detailmenyewa on (menyewa.kode_sewa=detailmenyewa.kode_sewa)
join film on (detailmenyewa.kode_film=film.kode_film) where film.judul like 'S%';
Revision
select distinct no_identitas, film.judul from menyewa join detailmenyewa on (menyewa.kode_sewa=detailmenyewa.kode_sewa)
join film on (detailmenyewa.kode_film=film.kode_film) where film.judul like 'S%';

-- No. 10 C
select customer.nama from customer join menyewa on (customer.no_identitas=menyewa.no_identitas)
join detailmenyewa on (menyewa.kode_sewa=detailmenyewa.kode_sewa) join film on (detailmenyewa.kode_film=film.kode_film)
where film.jenis = 'drama';