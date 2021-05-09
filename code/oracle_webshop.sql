DROP TABLE RENDEL;
DROP TABLE OSSZEKESZIT;
DROP TABLE MEGRENDELES;
DROP TABLE TORZSVASARLO;
DROP TABLE VELEMENY;
DROP TABLE TERMEK;
DROP TABLE FELHASZNALO;--
DROP TABLE LETREHOZ;
DROP TABLE RGAZDA;
DROP TABLE ELADO;
DROP TABLE KATEGORIA;--

create table KATEGORIA(
  Kategoria VARCHAR(23) PRIMARY KEY NOT NULL
);

create table ELADO(
 FelhaszNev VARCHAR(20) PRIMARY KEY NOT NULL,
 Jelszo VARCHAR(200) NOT NULL
);

create table RGAZDA(
 FelhaNev VARCHAR(29) PRIMARY KEY NOT NULL,
 Jelszo VARCHAR(21) NOT NULL
);

create table LETREHOZ(
 FelhaNev VARCHAR(29) NOT NULL,
 FOREIGN KEY(FelhaNev) REFERENCES RGAZDA(FELHANEV),
 FelhaszNev VARCHAR(20) NOT NULL,
 FOREIGN KEY(FelhaszNev) REFERENCES ELADO(FELHASZNEV)
);

create table FELHASZNALO(
 FelhNev VARCHAR(29) PRIMARY KEY NOT NULL,
 Jelszo VARCHAR(21) NOT NULL,
 Nev CHAR(31) NOT NULL,
 Lakcim VARCHAR(50),
 SzulDatum DATE,
 Email VARCHAR(40)
);

create table TERMEK(
  TermekKod NUMBER(20) NOT NULL,
  Ar NUMBER(10) UNIQUE  NOT NULL,
  nev VARCHAR2(30)UNIQUE NOT NULL,
  Leiras VARCHAR(102),
  DarabSzam Number(5),
  Kategoria VARCHAR(23),
  FOREIGN KEY(Kategoria) REFERENCES KATEGORIA(KATEGORIA),
  PRIMARY KEY(TermekKod)
);

create table VELEMENY(
 Azon NUMBER(10) PRIMARY KEY,
 nev VARCHAR2(30) NOT NULL,
 Ertekeles VARCHAR(2000),
 FelhNev VARCHAR(29),
 FOREIGN KEY(FelhNev) REFERENCES FELHASZNALO(FELHNEV), 
 FOREIGN KEY(nev) REFERENCES TERMEK(nev)
);

create table TORZSVASARLO(
 FelhNev VARCHAR(29)  NOT NULL,
 TorzsvE NUMBER(1) NOT NULL,
 FOREIGN KEY(FelhNev) REFERENCES FELHASZNALO(FELHNEV)
);

create table MEGRENDELES(
 Azon NUMBER(20) PRIMARY KEY NOT NULL,
 FelhNev VARCHAR(29),
 Idopont DATE,
 Osszeg INT DEFAULT 0,
 Ready NUMBER(1) DEFAULT 0,
 FOREIGN KEY(FelhNev) REFERENCES FELHASZNALO(FELHNEV)
 --FOREIGN KEY(TorzsvE) REFERENCES TORZSVASARLO(TORZSVE)
);

create table OSSZEKESZIT(
 FelhaszNev VARCHAR(20) NOT NULL,
 Azon NUMBER(9) NOT NULL,
 FOREIGN KEY(FelhaszNev) REFERENCES ELADO(FELHASZNEV),
 FOREIGN KEY(Azon) REFERENCES MEGRENDELES(AZON)
);

create table RENDEL(
 Id NUMBER(6) PRIMARY KEY NOT NULL ,
 nev VARCHAR2(30) NOT NULL,
 FOREIGN KEY(Nev) REFERENCES TERMEK(NEV),
 FelhNev VARCHAR(29) NOT NULL,
 FOREIGN KEY(FelhNev) REFERENCES FELHASZNALO(FELHNEV),
 Darab NUMBER(5),
 Ar NUMBER(10),
 FOREIGN KEY(Ar) REFERENCES TERMEK(AR),
 megrendelt NUMBER(1) DEFAULT 0
);

-- Triggerek (ha külön fájlban vannak elvesznek futtatásnál)
CREATE OR REPLACE TRIGGER kosar_reset
AFTER INSERT
ON megrendeles
FOR EACH ROW
BEGIN
    UPDATE Rendel SET megrendelt=1;
END;
/

CREATE OR REPLACE TRIGGER update_termek
  BEFORE DELETE OR INSERT OR UPDATE ON rendel
  FOR EACH ROW
DECLARE
    termek_amount number;
    termek_name varchar2(200);
    my_fancy_exception EXCEPTION;
    PRAGMA EXCEPTION_INIT( my_fancy_exception, -20001 );
BEGIN
  if inserting then
     select darabszam, nev into termek_amount, termek_name from termek where nev=:new.nev for update;
     if (termek_amount<:new.darab) then
       raise_application_error (-20001, 'kifogyott az '||termek_name);
     end if;
     update termek s set s.darabszam=s.darabszam-:new.darab
       where s.nev=:new.nev;
  end if;
  if updating then
     update termek s set s.darabszam=s.darabszam-:new.darab+:old.darab
       where s.nev=:new.nev;
  end if;
  if deleting then
     update termek s set s.darabszam=s.darabszam+:old.darab where s.nev=:old.nev;
  end if;
END;
/

CREATE OR REPLACE TRIGGER def_törzsv
AFTER INSERT
ON FELHASZNALO
FOR EACH ROW
BEGIN
    INSERT INTO torzsvasarlo(FelhNev, TorzsvE) VALUES(:new.FelhNev, 0);
END;
/

-- adatbázist feltöltő adatok --
INSERT INTO MEGRENDELES VALUES(dbms_random.value(100,999),'','','');

INSERT INTO KATEGORIA VALUES('Pekaru');
INSERT INTO KATEGORIA VALUES('Noi ruahzat');
INSERT INTO KATEGORIA VALUES('Ferfi ruhazat');
INSERT INTO KATEGORIA VALUES('Gyermek ruhazat');
INSERT INTO KATEGORIA VALUES('Tejtermek');
INSERT INTO KATEGORIA VALUES('Kert');
INSERT INTO KATEGORIA VALUES('Alkoholos italok');
INSERT INTO KATEGORIA VALUES('Uditok');
INSERT INTO KATEGORIA VALUES('Husok');
INSERT INTO KATEGORIA VALUES('Édesség');
INSERT INTO ELADO VALUES('ááááááá','ááááááá');
INSERT INTO ELADO VALUES('Cicus','cica');
INSERT INTO ELADO VALUES('BALAZS','ASDFG');
INSERT INTO ELADO VALUES('ELADO','ASD');
INSERT INTO ELADO VALUES('Vali','nem');
INSERT INTO ELADO VALUES('Warwick','lol');
INSERT INTO ELADO VALUES('Fanni','dfd');
INSERT INTO RGAZDA VALUES('GAZDA1','NEMJELSZO345');
INSERT INTO letrehoz VALUES('GAZDA1','Fanni');
INSERT INTO letrehoz VALUES('GAZDA1','Warwick');
INSERT INTO letrehoz VALUES('GAZDA1','BALAZS');
INSERT INTO letrehoz VALUES('GAZDA1','Vali');
INSERT INTO letrehoz VALUES('GAZDA1','Cicus');
INSERT INTO FELHASZNALO VALUES('BALAZS','ASDFG','Ficzere Balazs','2134 CSICSERI UTCA 45.',TO_DATE('2000 04 25', 'yyyy mm dd'), 'balazsvagyokhelloszia@gmail.com');
INSERT INTO FELHASZNALO VALUES('ANYU','ARDFG','Bohus Reka', '3400 NEMECSEK UTCA 3.', TO_DATE('1950 03 02', 'yyyy mm dd'), 'anyunakhivj@gmail.com');
INSERT INTO FELHASZNALO VALUES('KopiTomi','kopitomi','Kopanecz Tamás','2092 Tiefenweg UTCA 21.',TO_DATE('1999 08 27', 'yyyy mm dd'), 'tamas@kopanecz.hu');
INSERT INTO FELHASZNALO VALUES('Keve','keve12','Kalotay Keve','6725 Alkony utca 31.',TO_DATE('1999 06 14', 'yyyy mm dd'), 'kkeve@gmail.com');
INSERT INTO FELHASZNALO VALUES('Bence','x3eznt','Sárossy Bence','6485 Sarló utca 44.',TO_DATE('2000 10 10', 'yyyy mm dd'), 'bence@gmail.com');
INSERT INTO FELHASZNALO VALUES('Gezuka','mrnobody','Gyüre Géza','2099 Kerekes utca 39.',TO_DATE('1996 09 25', 'yyyy mm dd'), 'ggeza@gmail.com');
INSERT INTO FELHASZNALO VALUES('Sajtostaller','kecsap','Kiss Pista','6726 Csemege utca 49.',TO_DATE('1876 05 20', 'yyyy mm dd'), 'sajtos.taller@gmail.com');
INSERT INTO termek VALUES('987654321','500','csoki','mogyoróvajas szelet','100','Édesség');
INSERT INTO termek VALUES('462598154','18','zsemle','vizes zsömle','40','Pekaru');
INSERT INTO termek VALUES('428765428','10000','Tokaji aszú','6 puttonyos Tokaji borkülönlegesség','10','Alkoholos italok');
INSERT INTO termek VALUES('345219875','2000','Lapát','Fa nyelü ásó-lapát','16','Kert');
INSERT INTO termek VALUES('564821564','600','marha comb','Marha alsó comb filé','124','Husok');
INSERT INTO termek VALUES('874695123','1700','Férfi fürdőnaddrág','Férfi fürdőnadrág S/M/L/XL/XXL','6','Ferfi ruhazat');
INSERT INTO velemeny VALUES('943582','csoki','Praktikus a csomagolása, ellenben a porciózása az én mértékeimhez kicsit kicsi.','KopiTomi');
INSERT INTO velemeny VALUES('546251','Tokaji aszú','csodáltaos íz mélysége van, kellően savas míg megörzi a gyümölcsösséget','BALAZS');
INSERT INTO megrendeles VALUES('654','KopiTomi',SYSDATE,DEFAULT,DEFAULT);
INSERT INTO megrendeles VALUES('352','Gezuka',SYSDATE,DEFAULT,DEFAULT);
INSERT INTO megrendeles VALUES('513','Bence',SYSDATE,DEFAULT,DEFAULT);
INSERT INTO megrendeles VALUES('846','Keve',SYSDATE,DEFAULT,DEFAULT);
--INSERT INTO OSSZEKESZIT VALUES('BALAZS','654');
commit;
