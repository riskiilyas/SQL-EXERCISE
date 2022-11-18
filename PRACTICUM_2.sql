-- 1 A
alter table BUKU
add durasi_pinjam varchar(10);

-- 1 B
Update BUKU SET durasi_pinjam = '2 days'
where bu_penerbit = 'Gramedia';

-- 2
Update TRANSAKSI_PEMINJAMAN
SET tp_denda = 15000 where (SELECT AN_ID FROM ANGGOTA WHERE AN_NAMA='Hasna Maryati') = TP_AN_ID;

-- 3
SELECT * FROM ANGGOTA WHERE AN_TGL_REGIS >= to_date('2022-02-01', 'YYYY-MM-DD') AND 
AN_TGL_REGIS < to_date('2022-03-01', 'YYYY-MM-DD');

-- 4
SELECT * FROM PETUGAS PG JOIN AKSES AK ON(PG.PE_AK_ID=AK.AK_ID) Where AK.AK_JENIS_AKSES='owner';

-- 5
SELECT * FROM BUKU WHERE BU_STOK < 4;

-- 6
SELECT COUNT(*) AS "TOTAL BOOKS" FROM PEMINJAMAN_BUKU PB JOIN TRANSAKSI_PEMINJAMAN TP ON(PB.PB_TP_ID=TP.TP_ID)
WHERE TP.TP_TGL_KEMBALI = TO_DATE('2022-11-27', 'YYYY-MM-DD');

-- 7
SELECT * FROM ANGGOTA AG JOIN TRANSAKSI_PEMINJAMAN TP ON(AG.AN_ID=TP.TP_AN_ID) ORDER BY 
TP.TP_TGL_PINJAM ASC FETCH NEXT 5 ROW ONLY;

-- 8
SELECT DISTINCT * FROM BUKU BK WHERE BU_KODE_BUKU = (SELECT PB_BU_KODE_BUKU FROM PEMINJAMAN_BUKU
GROUP BY PB_BU_KODE_BUKU
ORDER BY COUNT(PB_BU_KODE_BUKU) DESC FETCH NEXT 1 ROW ONLY);

-- 9
SELECT DISTINCT * FROM PETUGAS PG WHERE PE_ID IN (SELECT TP_PE_ID FROM TRANSAKSI_PEMINJAMAN
GROUP BY TP_PE_ID
ORDER BY COUNT(TP_ID) DESC FETCH NEXT 3 ROW ONLY);

-- 10
SELECT * FROM BUKU BK JOIN RAK_BUKU RB ON(BK.BU_RB_ID=RB.RB_ID) WHERE
BK.BU_PENERBIT = 'Quanta' AND RB.RB_NAMA ='Sosial' AND RB.RB_LOKASI='Rak nomor 1 timur'