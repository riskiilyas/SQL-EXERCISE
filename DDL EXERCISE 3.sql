1.
SELECT p_nama, p_alamat FROM PELANGGAN WHERE p_alamat LIKE '%MULYOSARI%';

2.
SELECT p_no, p_nama as NAMA, p_tgldaftar AS TGL_DAFTAR from pelanggan order by p_tgldaftar fetch next 5 row only;

3.
select distinct k_no as "NO KARYAWAN", k_nama as NAMA from karyawan full join karyawan_detail on(karyawan.k_no=karyawan_detail.karyawan_k_no)
full join nota on (karyawan_detail.nota_n_no=nota.n_no)
where 1 not in (select nota_n_no from karyawan_detail where  karyawan_k_no = karyawan.k_no) order by K_NO;

4.
select distinct K_NAMA, K_BAGIAN from karyawan full join karyawan_detail on(karyawan.k_no=karyawan_detail.karyawan_k_no)
where (select count(karyawan_k_no) from karyawan_detail where karyawan_k_no = karyawan.k_no) = 0;

5.
select distinct P_NO, P_NAMA as NAMA, (Select count(*) from nota where pelanggan_p_no = pelanggan.p_no) as JUMLAH_NOTA from PELANGGAN FULL JOIN NOTA
on (pelanggan.p_no=nota.pelanggan_p_no) order by JUMLAH_NOTA desc fetch next 5 row only;

6.
select distinct n_no as NO_NOTA, n_tglmasuk as TGL_MASUK, (select sum(nota_detail.nd_banyak*jl.jl_harga) from nota_detail join jenis_layanan jl on (nota_detail.jenis_layanan_jl_id
=jl.jl_id) where n_no = nota_n_no) as HARGA from nota
join nota_detail on(nota.n_no=nota_detail.nota_n_no) join jenis_layanan on(nota_detail.jenis_layanan_jl_id=jenis_layanan.jl_id) order by NO_NOTA asc fetch next 5 row only;

7.
SELECT DISTINCT P_NO AS "NO PELANGGAN", P_NAMA AS NAMA FROM PELANGGAN PL JOIN NOTA NT ON(NT.PELANGGAN_P_NO=PL.P_NO) JOIN NOTA_DETAIL ND ON(ND.NOTA_N_NO=NT.N_NO) JOIN JENIS_LAYANAN JL
ON (JL.JL_ID=ND.JENIS_LAYANAN_JL_ID) WHERE (SELECT COUNT(*) FROM JENIS_LAYANAN JL2 JOIN NOTA_DETAIL ND2 ON (JL2.JL_ID=ND2.JENIS_LAYANAN_JL_ID) JOIN NOTA NT2 ON(NT2.N_NO=ND2.NOTA_N_NO)
JOIN PELANGGAN PL2 ON(NT2.PELANGGAN_P_NO=PL2.P_NO) WHERE PL2.P_NO = PL.P_NO AND JL2.JL_NAMA = 'SETRIKA') = 0 ORDER BY PL.P_NO ASC;

8.
SELECT DISTINCT
EXTRACT(MONTH FROM N_TGLMASUK) AS BULAN,
EXTRACT(YEAR FROM N_TGLMASUK) AS TAHUN,
(SELECT SUM(ND2.ND_BANYAK*JL2.JL_HARGA) FROM NOTA NT2 JOIN NOTA_DETAIL ND2 ON(ND2.NOTA_N_NO=NT2.N_NO) JOIN JENIS_LAYANAN JL2 ON(JL2.JL_ID=ND2.JENIS_LAYANAN_JL_ID)
WHERE to_char(NT2.N_TGLMASUK,'mm') = to_char(NT.N_TGLMASUK,'mm') AND to_char(NT2.N_TGLMASUK,'yyyy') = to_char(NT.N_TGLMASUK,'yyyy')) AS PEMASUKAN
FROM NOTA NT JOIN NOTA_DETAIL ND ON(NT.N_NO=ND.NOTA_N_NO) JOIN JENIS_LAYANAN JL ON (JL.JL_ID=ND.JENIS_LAYANAN_JL_ID) ORDER BY TAHUN DESC, BULAN ASC;

9.
SELECT P_NO, P_NAMA, (SELECT SUM(ND2.ND_BANYAK*JL2.JL_HARGA) AS TOTAL FROM NOTA NT2 JOIN NOTA_DETAIL ND2 ON(NT2.N_NO=ND2.NOTA_N_NO) JOIN JENIS_LAYANAN JL2 ON (JL2.JL_ID=ND2.JENIS_LAYANAN_JL_ID)
WHERE NT2.PELANGGAN_P_NO=P_NO AND TO_DATE('2010-07-01', 'YYYY-MM-DD') <= NT2.N_TGLMASUK AND TO_DATE('2010-08-01', 'YYYY-MM-DD') > NT2.N_TGLMASUK) 
AS TOTAL_BAYAR FROM PELANGGAN JOIN NOTA NT ON (NT.PELANGGAN_P_NO=PELANGGAN.P_NO) WHERE TO_DATE('2010-07-01', 'YYYY-MM-DD') <= NT.N_TGLMASUK 
AND TO_DATE('2010-08-01', 'YYYY-MM-DD') > NT.N_TGLMASUK ORDER BY TOTAL_BAYAR DESC FETCH NEXT 1 ROW ONLY;

10.
SELECT distinct ROUND(
(SELECT COUNT(*) FROM NOTA WHERE N_STATUS = 'DIAMBIL')/(SELECT COUNT(*) FROM NOTA)
, 5)*100 AS "PROSENTASE_SUDAH_DIAMBIL(%)" FROM NOTA;