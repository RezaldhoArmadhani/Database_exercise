create database akademininja;
\l;
\c akademininja;

-- struktur tabel

create type gender as enum ('laki-laki', 'perempuan');

-- 1 to 1

create table mentor (
    id_mentor int primary key,
    nama_mentor varchar(255),
    umur_mentor int,
    alamat_mentor  varchar(255),
    kelamin gender
);
create table kelas (
    kode_kelas varchar(255) primary key,
    nama_kelas  varchar (255),
    sesi_kelas  varchar (255),
    lokasi_kelas  varchar (255),
    id_mentor int,
    CONSTRAINT fk_mentor FOREIGN KEY (id_mentor) REFERENCES mentor(id_mentor)
);

-- 1 to many

create table mentorKhusus (
    id_mentor int primary key,
    nama_mentor varchar(255),
    umur_mentor int,
    alamat_mentor varchar(255),
    kelamin gender
);
create table murid (
    nim varchar(255) primary key,
    nama_murid varchar(255),
    umur_murid int,
    kelamin gender,
    id_mentor int,
    CONSTRAINT fk_mentorKhusus FOREIGN KEY (id_mentor) REFERENCES mentorKhusus(id_mentor)
);

-- many to many

create table mataPelajaran (
    id_mata_pelajaran varchar(255) primary key,
    nama_mata_pelajaran varchar (255),
    level_mata_pelajaran varchar (255)
);
create table nilai (
    id_nilai int primary key,
    jumlah_nilai int,
    keterangan varchar(255),
    nim varchar (255),
    CONSTRAINT fk_murid FOREIGN KEY (nim) REFERENCES murid(nim),
    id_mata_pelajaran varchar (255),
    CONSTRAINT fk_mataPelajaran FOREIGN KEY (id_mata_pelajaran) REFERENCES mataPelajaran(id_mata_pelajaran)
);

-- CRUD Tabel Mentor
-- -- create
-- insert into mentor (id_mentor, nama_mentor, umur_mentor, alamat_mentor, kelamin) values
-- (111, 'madara', 40, 'konoha', 'laki-laki'),
-- (222, 'kakashi', 35, 'konoha', 'laki-laki'),
-- (333, 'sakura', 30, 'konoha', 'perempuan'),
-- (444, 'samui', 30, 'kumo', 'perempuan');
-- -- read
-- select * from mentor;
-- select nama_mentor, kelamin from mentor;
-- -- update
-- update mentor set umur_mentor = 29 where id_mentor = 444;
-- update mentor set umur_mentor = 29, nama_mentor = 'sakura haruno' where id_mentor = 333;
-- -- delete
-- delete from mentor where id_mentor = 333;

-- CRUD Tabel Kelas 
-- -- create
-- insert into kelas (kode_kelas, nama_kelas, sesi_kelas, lokasi_kelas, id_mentor) values
-- (1111, 'genjutsu', 'pagi', 'desa api', (select id_mentor from mentor where nama_mentor ='madara')),
-- (2222, 'ninjutsu', 'siang', 'desa api', (select id_mentor from mentor where nama_mentor ='kakashi')),
-- (3333, 'taijutsu', 'pagi', 'desa api', (select id_mentor from mentor where nama_mentor ='sakura')),
-- (4444, 'taijutsu', 'pagi', 'desa petir', (select id_mentor from mentor where nama_mentor ='samui'));
-- -- read
-- select * from kelas;
-- select nama_kelas, id_mentor from kelas;
-- -- update
-- update kelas set nama_kelas = 'genjutsu plus' where id_mentor = 111;
-- update kelas set nama_kelas = 'taijutsu plus', lokasi_kelas = 'desa konoha' where id_mentor = 333;
-- -- delete
-- delete from kelas where id_mentor = 333;

-- CRUD Tabel mentorKhusus
-- -- create
-- insert into mentorKhusus (id_mentor, nama_mentor, umur_mentor, alamat_mentor, kelamin) values
-- (111, 'madara', 40, 'konoha', 'laki-laki'),
-- (222, 'kakashi', 35, 'konoha', 'laki-laki'),
-- (333, 'sakura', 30, 'konoha', 'perempuan'),
-- (444, 'samui', 30, 'kumo', 'perempuan');
-- -- read
-- select * from mentorKhusus;
-- select nama_mentor, kelamin from mentorKhusus;
-- -- update
-- update mentorKhusus set umur_mentor = 29 where id_mentor = 444;
-- update mentorKhusus set umur_mentor = 29, nama_mentor = 'sakura haruno' where id_mentor = 333;
-- -- delete
-- delete from mentorKhusus where id_mentor = 333;

-- CRUD Tabel murid
-- -- create
-- insert into murid (nim, nama_murid, umur_murid, kelamin, id_mentor) values
-- (11, 'boruto', 16, 'laki-laki', (select id_mentor from mentorKhusus where nama_mentor ='madara')),
-- (22, 'mitsuki', 16, 'laki-laki', (select id_mentor from mentorKhusus where nama_mentor ='kakashi')),
-- (33, 'sarada', 15, 'perempuan', (select id_mentor from mentorKhusus where nama_mentor ='sakura')),
-- (44, 'inoue', 15,'perempuan', (select id_mentor from mentorKhusus where nama_mentor ='samui'));
-- -- read
-- select * from murid;
-- select nama_murid, kelamin from murid;
-- -- update
-- update murid set umur_murid = 16 where nim = 33;
-- update murid set umur_murid = 16, nama_mentor = 'samui wati' where nim = 44;
-- -- delete
-- delete from murid where nim = 33;

-- CRUD Tabel mataPelajaran
-- -- create
-- insert into mataPelajaran (id_mata_pelajaran, nama_mata_pelajaran, level-mata_pelajaran) values
-- ('A01', 'lempar shuriken', 'pemula'),
-- ('A02', 'chidori', 'menengah'),
-- ('A03', 'rasengan', 'menengah'),
-- ('AO4', 'manipulasi gerak', 'hebat');
-- -- read
-- select * from mataPelajaran;
-- select nama_mata_pelajaran, level_mata_pelajaran from mataPelajaran;
-- update
-- update mataPelajaran set nama_mata_pelajaran = 'lempar pisau' where id_mata_pelajaran = 'A01';
-- update mataPelajaran set nama_mata_pelajaran = 'raikiri', level_mata_pelajaran = 'hebat' where id_mata_pelajaran = 'A02';
-- -- delete
-- delete from mataPelajaran where id_mata_pelajaran = 'A04';

-- CRUD Tabel nilai
-- -- create
-- insert into nilai (id_nilai, jumlah_nilai, keterangan, nim, id_mata_pelajaran) values
-- (01, 80, 'baik', (select nim from murid where nama_murid ='boruto'), (select id_mata_pelajaran from mataPelajaran where nama_mata_pelajaran = 'rasengan')),
-- (02, 76, 'cukup', (select nim from murid where nama_murid ='sarada'), (select id_mata_pelajaran from mataPelajaran where nama_mata_pelajaran = 'lempar shuriken')),
-- (03, 82, 'baik', (select nim from murid where nama_murid ='mitsuki'), (select id_mata_pelajaran from mataPelajaran where nama_mata_pelajaran = 'chidori')),
-- (04, 78, 'cukup', (select nim from murid where nama_murid ='inoue'), (select id_mata_pelajaran from mataPelajaran where nama_mata_pelajaran = 'manipulasi gerak'));
-- -- read
-- select * from nilai;
-- select jumlah_nilai, nim from nilai;
-- -- update
-- update nilai set jumlah-nilai = 79 where id_nilai = 04;
-- update nilai set jumlah-nilai = 81, keterangan = 'baik' where id_nilai = 02;
-- -- delete
-- delete from nilai where id_nilai = 02;