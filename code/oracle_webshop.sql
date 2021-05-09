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
INSERT INTO termek VALUES('987654323','399','Tej','2.8% zsítartalmú tej','100','Tejtermék');
INSERT INTO termek VALUES('462598155','22','Baugette','Baugette zsömle','40','Pekaru');
INSERT INTO termek VALUES('428762428','15000','Johhny Walker','Whiskey','10','Alkoholos italok');
INSERT INTO termek VALUES('345319875','6000','Kapa','Fém nyelű kapa','100','Kert');
INSERT INTO termek VALUES('534821564','1500','Angus darált hús','Angus darált hús hamburger alaphoz','12','Husok');
INSERT INTO termek VALUES('877695123','2500','Ing','Slim ing több színben S/M/L/XL/XXL','60','Ferfi ruhazat');
INSERT INTO termek VALUES('987664321','5000','Nuttela','mogyoróvaj ','1000','Édesség');
INSERT INTO termek VALUES('462598154','15','Kifli','Fél hold kifli','400','Pekaru');
INSERT INTO termek VALUES('478765428','12000','Tölrey Pezsgő','Édes Törley pezsgő','5','Alkoholos italok');
INSERT INTO termek VALUES('345210875','35000','Fűnyiró','Elektromos fű','10','Kert');
INSERT INTO termek VALUES('564021564','2100','Kacsa comb','Kacsa alsó comb ','200','Husok');
INSERT INTO termek VALUES('874695120','200','Zokni','Boka Zokni Több méretben','60','Ferfi ruhazat');
INSERT INTO termek VALUES('987654301','700','Laktózmentes csoki','Laktózmentes mogyoróvajas szelet','50','Édesség');
INSERT INTO termek VALUES('462598152','250','Kakós csiga','Finom kakaós csiga','35','Pekaru');
INSERT INTO termek VALUES('420765428','14000','Villa Rustica','Sümegi sázar fehér bor','8','Alkoholos italok');
INSERT INTO termek VALUES('340019875','20000','Csákány','Fém nyelü csákány','16','Kert');
INSERT INTO termek VALUES('564821564','6000','Pick szalámi','Szegedi pick szalámi','12','Husok');
INSERT INTO termek VALUES('874605023','1200','Alsó nemű','Férfi alsó nemű S/M/L/XL/XXL','6','Ferfi ruhazat');
INSERT INTO termek VALUES('100000000','100','Nyalóka','Több ízesítésú nyalóka','100','Édesség');
INSERT INTO termek VALUES('100000001','4500','Édesség kosár','kis éddeség kosár több fajta csokival','10','Édesség');
INSERT INTO termek VALUES('100000002','450','Kóla','Pepsi cola','1000','Udito');
INSERT INTO termek VALUES('100000003','500','Fánk','Csokis fánk','20','Pekaru');
INSERT INTO termek VALUES('100000004','234','Virsli','Füstli','100','Husok');
INSERT INTO termek VALUES('100000005','1000','Tarja','1kg','30','Husok');
INSERT INTO termek VALUES('100000006','2500','Farmer','Farmer kék','2','Noi ruhazat');
INSERT INTO termek VALUES('100000007','2314','Blúz','','20','Noi ruhazat');
INSERT INTO termek VALUES('100000008','3200','Szoknya','Rövid hosszú szoknya','231','Noi ruhazat');
INSERT INTO termek VALUES('100000009','8000','Pulóver','','240','Noi ruhazat');
INSERT INTO termek VALUES('100000010','500','Fanta','Bubis naracslé','23','Udito');
INSERT INTO termek VALUES('100000011','2352','Rosé bor','','123','Alkolholos italok');
INSERT INTO termek VALUES('100000012','23152','macallan 25','Whiskey','24','Alkoholos italok');
INSERT INTO termek VALUES('100000013','12251','Single barrel','Whisykey','2','Alkoholos italaok');
INSERT INTO termek VALUES('100000014','6452','Farmer férfi','kék férfi farmer','30','Ferfi ruhazat');
INSERT INTO termek VALUES('100000015','2356','Kolbász','','2000','Husok');
INSERT INTO termek VALUES('100000016','23634','Locsoló rendszer','Nap elemes locsólo rendszer','10','Kert');
INSERT INTO termek VALUES('100000017','65443','Macallan 35','Mondhatni a legjobb whiskey','2','Alkolholos italok');
INSERT INTO termek VALUES('100000018','65443','Kerti bútor szet','Kerti bútor szet időt álló','5','Kert');
INSERT INTO termek VALUES('100000019','46526','Macalan 30','','25','Alkoholos italok');
INSERT INTO termek VALUES('100000020','43256','Drága kerti törpe','név adja magát','1','Kert');
INSERT INTO termek VALUES('100000021','9876','Hoddie','Kapucnis pullóver ','2','Ferfi ruhazat');
INSERT INTO termek VALUES('100000022','5432','Cipő','Női cipő','20','Noi ruhazat');
INSERT INTO termek VALUES('100000023','4500','Kacsa pecsenye','Omlos kacsa pecsenye','3','Husok');
INSERT INTO termek VALUES('100000024','210','Milka','Fehér csokis','30','Édesség');
INSERT INTO termek VALUES('100000025','430','Laktózmentes sajt','kiló ár','300','Tejtermekek');
INSERT INTO FELHASZNALO VALUES('Coneflower','m55w6RyIykhcP6AO2Osy','Brown Sharon','Becklow  Tunnel, 9921','','Sharon_Brown2873@tonsy.org');
INSERT INTO FELHASZNALO VALUES('African Violet','4mVWAgmrYKchD0ISBFmZ','Knight Candice','Bel   Tunnel, 1106','','Candice_Knight608@liret.org');
INSERT INTO FELHASZNALO VALUES('Alstroemeria','SJonq5NBznCgfEv8OMDG','Bell William','Fairholt   Drive, 1965','','William_Bell2802@irrepsy.com');
INSERT INTO FELHASZNALO VALUES('Ambrosia','50lhHs04FgwVgWZ1KCGf','Gilmour Julius','Clarks  Street, 3376','','Julius_Gilmour1509@bretoux.com');
INSERT INTO FELHASZNALO VALUES('Apple','12HtYWcmdP3AQzHB2Ajz','Little Catherine','Howard Pass, 2650','','Catherine_Little1536@fuliss.net');
INSERT INTO FELHASZNALO VALUES('Apricot','qabPUoKACJxGZNmGcfYh','Glass Emerald','Battis   Lane, 2349','','Emerald_Glass7555@bungar.biz');
INSERT INTO FELHASZNALO VALUES('Arrowwood','ddlcaMKgxwjVTBHisAhU','Tate Lexi','Camdale  Drive, 6842','','Lexi_Tate939@cispeto.com');
INSERT INTO FELHASZNALO VALUES('Aspen','M7ZxVUsmedZKjaW9bvyP','Lewin Chuck','Gathorne   Way, 1593','','Chuck_Lewin7388@kideod.biz');
INSERT INTO FELHASZNALO VALUES('Banyan','98e7sGTx92lfp0dbKvPK','Pearce Alex','Sheringham   Hill, 5586','','Alex_Pearce3269@sveldo.biz');
INSERT INTO FELHASZNALO VALUES('Baobab','vypkynIBYvgYjKV0rSwZ','Hilton Rick','Carlisle  Vale, 6926','','Rick_Hilton9772@gmail.com');
INSERT INTO FELHASZNALO VALUES('Bearberry','DVUeE0EPTWIErGihBHTw','Knight Erin','Garfield Rue, 9115','','Erin_Knight3742@tonsy.org');
INSERT INTO FELHASZNALO VALUES('Bee Balm Flower','ZvBqDcWClHd5f6SUrYNR','Johnson Hayden','Chandos  Route, 5151','','Hayden_Johnson5722@iatim.tech');
INSERT INTO FELHASZNALO VALUES('Bellflower','AC2GnOQJ2YiufqhlGyOJ','Davies Rocco','Catherine  Alley, 6923','','Rocco_Davies8535@tonsy.org');
INSERT INTO FELHASZNALO VALUES('Bilberry','An9wkC9P31YyLxxqZOHS','Saunders Drew','Walnut Alley, 4193','','Drew_Saunders5114@joiniaa.com');
INSERT INTO FELHASZNALO VALUES('Bindweed','4bJNelS23HYCIgwuznZO','Uttley Alexander','Church Tunnel, 6221','','Alexander_Uttley6598@liret.org');
INSERT INTO FELHASZNALO VALUES('Birch','394BWvRMXzwllsROk6ax','Holmes Chris','Walnut Vale, 6431','','Chris_Holmes9845@deavo.com');
INSERT INTO FELHASZNALO VALUES('Bleeding Heart','on8DdDlii2UGWXn1kiZS','Carter Bernadette','Victoria Rise Pass, 1962','','Bernadette_Carter6023@ovock.tech');
INSERT INTO FELHASZNALO VALUES('Bluebonnet','kzXJPIwq9PncUrx9ZaAF','Campbell Johnny','Charnwood   Avenue, 5907','','Johnny_Campbell4220@bungar.biz');
INSERT INTO FELHASZNALO VALUES('Bramble','3zQ1jKquI3pqlSal1fl9','Gordon Nicholas','Dunstans  Pass, 6917','','Nicholas_Gordon268@jiman.org');
INSERT INTO FELHASZNALO VALUES('Bramble','GM5nyVEKxf9bHpdTSCdF','Windsor Macy','Under  Way, 1603','','Macy_Windsor7798@elnee.tech');
INSERT INTO FELHASZNALO VALUES('Butterfly weed','6eJBX3TdJoyPMff2G3CE','Purvis Chester','Arundel   Alley, 5522','','Chester_Purvis9063@twipet.com');
INSERT INTO FELHASZNALO VALUES('Cabbage','WEmzkFMTIf9zItiNSJyL','Dubois Luke','East Road, 1986','','Luke_Dubois843@gembat.biz');
INSERT INTO FELHASZNALO VALUES('Cactus','6wwvPMwkNhkdO48uQGE7','Thomson Zara','King Edward  Grove, 3109','','Zara_Thomson6772@grannar.com');
INSERT INTO FELHASZNALO VALUES('California sycamore','jyN4E03zlzKx7v8U9oBV','Bright Aiden','Fair Walk, 2290','','Aiden_Bright5285@nickia.com');
INSERT INTO FELHASZNALO VALUES('Calla Lily','4BpVNFV5PIPdvJE6Lp2i','Watson Gabriel','Bel   Lane, 3346','','Gabriel_Watson8541@muall.tech');
INSERT INTO FELHASZNALO VALUES('Candytuft','4cMhteaGvR00aLb6pgmF','Mcnally Sonya','Canon Avenue, 1886','','Sonya_Mcnally5351@jiman.org');
INSERT INTO FELHASZNALO VALUES('Carrot','9Dj2Vc8xUFTOeOoTcvhe','Dubois Lorraine','Rivervalley Hill, 8058','','Lorraine_Dubois2951@kideod.biz');
INSERT INTO FELHASZNALO VALUES('Catmint','zpIugy8DYW0wpzCndqNn','Camden Livia','Clerkenwell Tunnel, 578','','Livia_Camden5608@womeona.net');
INSERT INTO FELHASZNALO VALUES('Chamomile','dB4S0aeW8idROb1ejyTQ','Watson Brad','Dunstable   Grove, 6449','','Brad_Watson5870@acrit.org');
INSERT INTO FELHASZNALO VALUES('Cherry','aDA2aWej9WgZn7dELtQ3','Andrews Aiden','Chatfield  Street, 1001','','Aiden_Andrews1349@qater.org');
INSERT INTO FELHASZNALO VALUES('Chestnut','3bV9ufC4qxzd5Om73zn0','Kennedy Rufus','Longleigh   Hill, 6910','','Rufus_Kennedy9948@mafthy.com');
INSERT INTO FELHASZNALO VALUES('Chinese Evergreen','hYMpB4HOWPzVWtDRaWGS','Robinson Brad','Lincoln Hill, 1309','','Brad_Robinson3465@tonsy.org');
INSERT INTO FELHASZNALO VALUES('Clarkia','9v8iRgSHoc1aVD9IWbTK','Michael Nate','Fair Rue, 1896','','Nate_Michael1828@mafthy.com');
INSERT INTO FELHASZNALO VALUES('Collard','XXDGjyHHTHT5BhlFgZ0F','Sherry Nick','Blackall   Alley, 2896','','Nick_Sherry1663@eirey.tech');
INSERT INTO FELHASZNALO VALUES('Columbine','ms92F05EG2fUUqr1f9xa','Preston Lara','Boldero   Rue, 3341','','Lara_Preston9644@grannar.com');
INSERT INTO FELHASZNALO VALUES('Columbine','ZwC33kgbI1vLsWR0pyl2','Simmons Harriet','Lonsdale  Way, 6025','','Harriet_Simmons7322@bungar.biz');
INSERT INTO FELHASZNALO VALUES('Cornflower','0kPnAFj32SrHzgucTf2d','Saunders Aisha','Camberwell  Avenue, 2144','','Aisha_Saunders5685@cispeto.com');
INSERT INTO FELHASZNALO VALUES('Cotton plant','xoFppy7ipp4A99XUAMZ8','Norton Rae','Ellerslie Alley, 8381','','Rae_Norton3152@gembat.biz');
INSERT INTO FELHASZNALO VALUES('Cucumber','M78FLaPgbfPoFBI1HC5G','Holt Valerie','Gatonby   Grove, 2502','','Valerie_Holt6204@deavo.com');
INSERT INTO FELHASZNALO VALUES('Cup Flower','GwX0OqC5cRTo9HcnCwDy','Addley Phillip','Angel  Drive, 7997','','Phillip_Addley5568@sveldo.biz');
INSERT INTO FELHASZNALO VALUES('Daisy','CkWzpi4AjtjgCN8ag4aZ','Griffiths Juliet','King Edward  Route, 1622','','Juliet_Griffiths331@gompie.com');
INSERT INTO FELHASZNALO VALUES('Dindle','2calIvD3Pp3dVPSmyKIb','Samuel Caleb','St. Johs  Hill, 5789','','Caleb_Samuel4532@yahoo.com');
INSERT INTO FELHASZNALO VALUES('Dogwood','1Fy7qEJSacieRpVJ91Ux','Hastings Erick','Bendall   Boulevard, 8536','','Erick_Hastings4831@atink.com');
INSERT INTO FELHASZNALO VALUES('Drumstick','3q1uhZF2sToc148FoKmO','Dubois Aiden','Bacon  Road, 6937','','Aiden_Dubois410@twace.org');
INSERT INTO FELHASZNALO VALUES('Dumb Cane','EDAlnLaYE77SVCzoYrSt','Olson Clarissa','Geary   Lane, 1525','','Clarissa_Olson1465@grannar.com');
INSERT INTO FELHASZNALO VALUES('Easter orchid','DOJBKx13eglLeAzepOTM','Jordan Aileen','Dunton  Tunnel, 789','','Aileen_Jordan2511@jiman.org');
INSERT INTO FELHASZNALO VALUES('Elephant Ear','0oo6BigXL8yx5RzGAsgY','Bailey Norah','Cliff  Road, 6216','','Norah_Bailey3363@kideod.biz');
INSERT INTO FELHASZNALO VALUES('Eucalyptus','7breco1kqAcz71OY9eI5','Sherry Alan','Ensign   Way, 2891','','Alan_Sherry4990@nickia.com');
INSERT INTO FELHASZNALO VALUES('Fennel','C8lWuF9L8tYElzgAdlDU','Hardwick Matt','Underwood  Alley, 4947','','Matt_Hardwick9810@deavo.com');
INSERT INTO FELHASZNALO VALUES('Fig','oPFNUyfLocErYWe1Z1UJ','Exton Kurt','Lexington Walk, 4047','','Kurt_Exton9356@supunk.biz');
INSERT INTO FELHASZNALO VALUES('Filipendula','epZtopJY5YwzKmuFGjMn','Mitchell Jayden','East Vale, 4542','','Jayden_Mitchell7838@gompie.com');
INSERT INTO FELHASZNALO VALUES('Gillyflower','kEmA8yP7Fu5s5l4hxiu6','Mann Chuck','Howard Crossroad, 3276','','Chuck_Mann5680@supunk.biz');
INSERT INTO FELHASZNALO VALUES('Ginseng','hHSrHyrEDMTMVKAlNR8X','Bloom Brad','Ben   Pass, 3587','','Brad_Bloom3765@typill.biz');
INSERT INTO FELHASZNALO VALUES('Goldenglow','8l33nvkFfb6ihQ1u8qdS','Tate Alma','Emden   Boulevard, 6704','','Alma_Tate6192@mafthy.com');
INSERT INTO FELHASZNALO VALUES('Grapefruit','abk5oKaTs5jmCN33m5X6','Powell Jane','Monroe Crossroad, 9222','','Jane_Powell6183@twipet.com');
INSERT INTO FELHASZNALO VALUES('Groundberry','DeRvcmpfiNNE7PE0Wyu1','Janes Tony','Carlisle  Crossroad, 8887','','Tony_Janes5@tonsy.org');
INSERT INTO FELHASZNALO VALUES('Guaco','3mq4Qrt7u9PbGor6cvNw','Archer Karla','Blenkarne  Vale, 9173','','Karla_Archer7084@guentu.biz');
INSERT INTO FELHASZNALO VALUES('Hedge plant','6dScZ6KjFwdWilMoTjTL','Lunt Jack','Virgil   Rue, 5508','','Jack_Lunt9697@naiker.biz');
INSERT INTO FELHASZNALO VALUES('Huckleberry','bemxOPkPkWq8w4OWf953','Thornton Alan','Fairfield  Road, 4398','','Alan_Thornton304@guentu.biz');
INSERT INTO FELHASZNALO VALUES('Indian paintbrush','3E1rJ3IziF3s08WFsy80','Neal Chuck','Wager   Drive, 8498','','Chuck_Neal5879@twace.org');
INSERT INTO FELHASZNALO VALUES('Ironwood','DRjeZ8Z5vqQdhmvVGfkM','Bailey Elijah','Wager   Alley, 7934','','Elijah_Bailey9635@bretoux.com');
INSERT INTO FELHASZNALO VALUES('Japanese Iris','iDGj0wBpByTbSv8phrvB','Simpson Sarah','Carpenter Grove, 6644','','Sarah_Simpson3782@mafthy.com');
INSERT INTO FELHASZNALO VALUES('Kauila','OQZBXenxgAXl1AULgREg','Grady Tyler','Heritage Route, 9421','','Tyler_Grady835@nimogy.biz');
INSERT INTO FELHASZNALO VALUES('Kentia Palm Plant','1vXlj2GN1PH6P3Gs8e2u','Ellis Priscilla','Howard Way, 74','','Priscilla_Ellis5965@infotech44.tech');
INSERT INTO FELHASZNALO VALUES('Lily','n1o3HrV6oGd7XdlupFdy','Stewart Mina','Howard Drive, 7801','','Mina_Stewart3481@womeona.net');
INSERT INTO FELHASZNALO VALUES('Lucky Bamboo','JCRmvXJFNUb1L5Be0fj2','Campbell Raquel','Blue Anchor  Way, 2958','','Raquel_Campbell2749@gembat.biz');
INSERT INTO FELHASZNALO VALUES('Manzanita','k84Vq7nbB8MWvNfnTqUV','Mooney George','Caslon   Pass, 9696','','George_Mooney5870@grannar.com');
INSERT INTO FELHASZNALO VALUES('Mesquite','bYcu1k6TAlw2ANqP27Sr','Moore Agnes','Vincent  Walk, 523','','Agnes_Moore5640@gmail.com');
INSERT INTO FELHASZNALO VALUES('Millet','frkguufJvLZg0sjpwsxH','Wilton Aiden','Chesterfield  Boulevard, 6122','','Aiden_Wilton1179@joiniaa.com');
INSERT INTO FELHASZNALO VALUES('Mistletoe','626URNQ1dXj8vtgPN5MF','Garner Samantha','Egerton  Walk, 7984','','Samantha_Garner63@dionrab.com');
INSERT INTO FELHASZNALO VALUES('Morning Glory','74gpVJwlcFA1TeD5DaQz','Sheldon Bree','Abourne   Road, 1102','','Bree_Sheldon2942@muall.tech');
INSERT INTO FELHASZNALO VALUES('Mugwort','GnLNVrkvjfUViHhTf6EY','Baker Carl','Blackall   Rue, 3265','','Carl_Baker7329@yahoo.com');
INSERT INTO FELHASZNALO VALUES('Narcissus','FXYrwq3CTYAe9UkUp1hV','Haines Catherine','Caldwell   Alley, 3276','','Catherine_Haines7727@dionrab.com');
INSERT INTO FELHASZNALO VALUES('Nemesia','EpjAKTkB8a69dG30XNun','Bradshaw Sloane','Berry  Crossroad, 8074','','Sloane_Bradshaw4296@irrepsy.com');
INSERT INTO FELHASZNALO VALUES('Pansy','hQJ9V4UEwqMTMr36TdIC','Drummond Melania','Gathorne   Lane, 1433','','Melania_Drummond7549@nickia.com');
INSERT INTO FELHASZNALO VALUES('Periwinkle','dOWMqxn9e36itM8ZmWjs','Gaynor Carla','Arbutus   Rue, 2129','','Carla_Gaynor1833@vetan.org');
INSERT INTO FELHASZNALO VALUES('Poppy','JYcqphFDCNoakHyyR0hc','Tait Erick','Comet House  Pass, 3890','','Erick_Tait9241@vetan.org');
INSERT INTO FELHASZNALO VALUES('Red Hot Poker Plant','rHTb49vHxtptlEa6yiMd','Giles Hank','Lake Alley, 7328','','Hank_Giles396@mafthy.com');
INSERT INTO FELHASZNALO VALUES('Rose','LBhabSMXm7w3z3Xfz5EC','Gallacher Harry','Timothy  Street, 8869','','Harry_Gallacher4557@deavo.com');
INSERT INTO FELHASZNALO VALUES('Shasta Daisy','bRyQZ66yH2fXdl13RtWm','Baker Marina','Pine Grove, 760','','Marina_Baker3900@joiniaa.com');
INSERT INTO FELHASZNALO VALUES('Silene','XNCnQjHWd7IPmJX2gkpf','Redfern Sasha','Spruce Drive, 5431','','Sasha_Redfern6812@joiniaa.com');
INSERT INTO FELHASZNALO VALUES('Snowflake','yYj1O8oTKh1oxVnA4Nl4','Stone Anais','Champion  Grove, 4482','','Anais_Stone2091@bulaffy.com');
INSERT INTO FELHASZNALO VALUES('Soapwort','Yw3DLvYSsZ2ivoH83qfH','Marshall Jackeline','Cadogan  Walk, 4334','','Jackeline_Marshall8094@extex.org');
INSERT INTO FELHASZNALO VALUES('Tulip','LTjJjabQsTyq1R6tjFXY','Egerton Peter','Beatty  Walk, 1201','','Peter_Egerton5863@typill.biz');
INSERT INTO FELHASZNALO VALUES('Urn Plant','8eMhFSgQzy8LmmKTCLik','Taylor Julian','Linden Pass, 5844','','Julian_Taylor3042@womeona.net');
INSERT INTO FELHASZNALO VALUES('Vervain','YLafutlZ4scYQeOPq4Ws','Bell Denis','Bellenden  Way, 8993','','Denis_Bell227@brety.org');


INSERT INTO velemeny VALUES('943582','csoki','Praktikus a csomagolása, ellenben a porciózása az én mértékeimhez kicsit kicsi.','KopiTomi');
INSERT INTO velemeny VALUES('546251','Tokaji aszú','csodáltaos íz mélysége van, kellően savas míg megörzi a gyümölcsösséget','BALAZS');
INSERT INTO megrendeles VALUES('654','KopiTomi',SYSDATE,DEFAULT,DEFAULT);
INSERT INTO megrendeles VALUES('352','Gezuka',SYSDATE,DEFAULT,DEFAULT);
INSERT INTO megrendeles VALUES('513','Bence',SYSDATE,DEFAULT,DEFAULT);
INSERT INTO megrendeles VALUES('846','Keve',SYSDATE,DEFAULT,DEFAULT);
--INSERT INTO OSSZEKESZIT VALUES('BALAZS','654');
commit;
