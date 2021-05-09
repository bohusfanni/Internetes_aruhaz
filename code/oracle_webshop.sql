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
 nev VARCHAR2(30) NOT NULL,
 FOREIGN KEY(Nev) REFERENCES TERMEK(NEV),
 FelhNev VARCHAR(29) NOT NULL,
 FOREIGN KEY(FelhNev) REFERENCES FELHASZNALO(FELHNEV),
 Darab NUMBER(5),
 Ar NUMBER(10),
 FOREIGN KEY(Ar) REFERENCES TERMEK(AR),
 megrendelt NUMBER(1) DEFAULT 0
);

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
INSERT INTO FELHASZNALO VALUES('Bilberry','An9wkC9P31YyLxxqZOHS','Saunders Drew','Walnut Alley, 4193','','Drew_Saunders5114@joiniaa.com');
INSERT INTO FELHASZNALO VALUES('Cotton plant','xoFppy7ipp4A99XUAMZ8','Norton Rae','Ellerslie Alley, 8381','','Rae_Norton3152@gembat.biz');
INSERT INTO FELHASZNALO VALUES('Cabbage','WEmzkFMTIf9zItiNSJyL','Dubois Luke','East Road, 1986','','Luke_Dubois843@gembat.biz');
INSERT INTO FELHASZNALO VALUES('Lily','zVl4pTkRKZ3KB1raJb0e','Tanner Adeline','Oxford Route, 8693','','Adeline_Tanner941@ovock.tech');
INSERT INTO FELHASZNALO VALUES('Bearberry','me2lRSKX5ca86Hu5Avhl','Olson Alison','Cobden  Route, 970','','Alison_Olson1671@twipet.com');
INSERT INTO FELHASZNALO VALUES('Daisy','CkWzpi4AjtjgCN8ag4aZ','Griffiths Juliet','King Edward  Route, 1622','','Juliet_Griffiths331@gompie.com');
INSERT INTO FELHASZNALO VALUES('Guaco','fHB8K32EJQjz4bB8Ehzo','Callan Carrie','Virginia Crossroad, 7781','','Carrie_Callan7344@nanoff.biz');
INSERT INTO FELHASZNALO VALUES('Bleeding Heart','on8DdDlii2UGWXn1kiZS','Carter Bernadette','Victoria Rise Pass, 1962','','Bernadette_Carter6023@ovock.tech');
INSERT INTO FELHASZNALO VALUES('Pansy','LasmHenkvbYaagoeiiLl','Chester Laila','Byland  Walk, 9489','','Laila_Chester5117@gompie.com');
INSERT INTO FELHASZNALO VALUES('Apple','12HtYWcmdP3AQzHB2Ajz','Little Catherine','Howard Pass, 2650','','Catherine_Little1536@fuliss.net');
INSERT INTO FELHASZNALO VALUES('Chinese Evergreen','pl4fW3iRqBJM2ETRltWC','Kennedy Alba','Blake  Road, 3032','','Alba_Kennedy9859@liret.org');
INSERT INTO FELHASZNALO VALUES('Periwinkle','dOWMqxn9e36itM8ZmWjs','Gaynor Carla','Arbutus   Rue, 2129','','Carla_Gaynor1833@vetan.org');
INSERT INTO FELHASZNALO VALUES('Coneflower','MXpt5NwxAMQpSGzZeA2g','Shaw Ron','Carolina  Rue, 1100','','Ron_Shaw8813@typill.biz');
INSERT INTO FELHASZNALO VALUES('Urn Plant','8eMhFSgQzy8LmmKTCLik','Taylor Julian','Linden Pass, 5844','','Julian_Taylor3042@womeona.net');
INSERT INTO FELHASZNALO VALUES('Lily','mCY7FCrEIMxTIoM3U8Db','Tobin Gina','Glenwood Tunnel, 2425','','Gina_Tobin4710@eirey.tech');
INSERT INTO FELHASZNALO VALUES('Cactus','6wwvPMwkNhkdO48uQGE7','Thomson Zara','King Edward  Grove, 3109','','Zara_Thomson6772@grannar.com');
INSERT INTO FELHASZNALO VALUES('Pansy','slwWlLZBi2baTGad8GJt','Owen Grace','Meadow Street, 3653','','Grace_Owen6240@nimogy.biz');
INSERT INTO FELHASZNALO VALUES('Eucalyptus','cjobaf5xHnsissNnhgJ3','Willis Penny','Castle Route, 6086','','Penny_Willis6508@bauros.biz');
INSERT INTO FELHASZNALO VALUES('Banyan','98e7sGTx92lfp0dbKvPK','Pearce Alex','Sheringham   Hill, 5586','','Alex_Pearce3269@sveldo.biz');
INSERT INTO FELHASZNALO VALUES('Japanese Iris','zwuqMHoNkAm4ziohYTeG','Horton Jack','Durweston   Avenue, 777','','Jack_Horton517@nanoff.biz');
INSERT INTO FELHASZNALO VALUES('Bleeding Heart','YY9ShKF0zdtyNjvnPsQb','Harris Ethan','Maple Way, 8969','','Ethan_Harris2829@supunk.biz');
INSERT INTO FELHASZNALO VALUES('Elephant Ear','lJ6vRMmnlRYiqjzuSu1G','Cavanagh Rocco','Longmoore   Lane, 4511','','Rocco_Cavanagh9372@liret.org');
INSERT INTO FELHASZNALO VALUES('Periwinkle','ZQvLkNUwD6XJAoa22TlL','Rose Blake','Castile  Avenue, 7957','','Blake_Rose4052@naiker.biz');
INSERT INTO FELHASZNALO VALUES('Hedge plant','TV7ORMBmXFVf7Oyd70K4','Chadwick Madelyn','Collins  Way, 1840','','Madelyn_Chadwick4826@typill.biz');
INSERT INTO FELHASZNALO VALUES('Vervain','YLafutlZ4scYQeOPq4Ws','Bell Denis','Bellenden  Way, 8993','','Denis_Bell227@brety.org');
INSERT INTO FELHASZNALO VALUES('Ginseng','DxYSX9459NfNDCIrfvEY','Gray Rufus','Queen Grove, 40','','Rufus_Gray1927@grannar.com');
INSERT INTO FELHASZNALO VALUES('Columbine','ms92F05EG2fUUqr1f9xa','Preston Lara','Boldero   Rue, 3341','','Lara_Preston9644@grannar.com');
INSERT INTO FELHASZNALO VALUES('Columbine','SLaQHXefU8LMnZ2jECy1','Morgan Aiden','Hamilton  Pass, 2152','','Aiden_Morgan8852@liret.org');
INSERT INTO FELHASZNALO VALUES('Ginseng','hHSrHyrEDMTMVKAlNR8X','Bloom Brad','Ben   Pass, 3587','','Brad_Bloom3765@typill.biz');
INSERT INTO FELHASZNALO VALUES('Easter orchid','DOJBKx13eglLeAzepOTM','Jordan Aileen','Dunton  Tunnel, 789','','Aileen_Jordan2511@jiman.org');
INSERT INTO FELHASZNALO VALUES('Ironwood','VtAsYA8KKLXIstvWMlQF','Oldfield Chanelle','Carpenter Avenue, 7791','','Chanelle_Oldfield5304@famism.biz');
INSERT INTO FELHASZNALO VALUES('Morning Glory','74gpVJwlcFA1TeD5DaQz','Sheldon Bree','Abourne   Road, 1102','','Bree_Sheldon2942@muall.tech');
INSERT INTO FELHASZNALO VALUES('Mistletoe','626URNQ1dXj8vtgPN5MF','Garner Samantha','Egerton  Walk, 7984','','Samantha_Garner63@dionrab.com');
INSERT INTO FELHASZNALO VALUES('Mistletoe','iCfLFgNDgCQwEkDq1GJH','Stone Josh','Bury  Grove, 4961','','Josh_Stone9598@gembat.biz');
INSERT INTO FELHASZNALO VALUES('Pansy','hQJ9V4UEwqMTMr36TdIC','Drummond Melania','Gathorne   Lane, 1433','','Melania_Drummond7549@nickia.com');
INSERT INTO FELHASZNALO VALUES('Red Hot Poker Plant','rHTb49vHxtptlEa6yiMd','Giles Hank','Lake Alley, 7328','','Hank_Giles396@mafthy.com');
INSERT INTO FELHASZNALO VALUES('Cornflower','0kPnAFj32SrHzgucTf2d','Saunders Aisha','Camberwell  Avenue, 2144','','Aisha_Saunders5685@cispeto.com');
INSERT INTO FELHASZNALO VALUES('Apple','r1YY36IaFl80D6QeVpps','Irving Tyson','Arundel   Pass, 9073','','Tyson_Irving2355@womeona.net');
INSERT INTO FELHASZNALO VALUES('Grapefruit','abk5oKaTs5jmCN33m5X6','Powell Jane','Monroe Crossroad, 9222','','Jane_Powell6183@twipet.com');
INSERT INTO FELHASZNALO VALUES('Filipendula','epZtopJY5YwzKmuFGjMn','Mitchell Jayden','East Vale, 4542','','Jayden_Mitchell7838@gompie.com');
INSERT INTO FELHASZNALO VALUES('Bellflower','AC2GnOQJ2YiufqhlGyOJ','Davies Rocco','Catherine  Alley, 6923','','Rocco_Davies8535@tonsy.org');
INSERT INTO FELHASZNALO VALUES('African Violet','R1Gln5V3thYe5NKo2Tlv','Oswald Nate','Lake Boulevard, 3971','','Nate_Oswald9984@tonsy.org');
INSERT INTO FELHASZNALO VALUES('Columbine','ZwC33kgbI1vLsWR0pyl2','Simmons Harriet','Lonsdale  Way, 6025','','Harriet_Simmons7322@bungar.biz');
INSERT INTO FELHASZNALO VALUES('Grapefruit','NouWEUuVkCmoMubzjz8r','Whitehouse Jules','Coley  Hill, 1137','','Jules_Whitehouse3962@vetan.org');
INSERT INTO FELHASZNALO VALUES('Alstroemeria','SJonq5NBznCgfEv8OMDG','Bell William','Fairholt   Drive, 1965','','William_Bell2802@irrepsy.com');
INSERT INTO FELHASZNALO VALUES('Shasta Daisy','Pqtf3S28AgyNytM6K9oZ','Varley Josh','Dunstable   Hill, 1393','','Josh_Varley6788@eirey.tech');
INSERT INTO FELHASZNALO VALUES('Mesquite','bYcu1k6TAlw2ANqP27Sr','Moore Agnes','Vincent  Walk, 523','','Agnes_Moore5640@gmail.com');
INSERT INTO FELHASZNALO VALUES('Silene','XNCnQjHWd7IPmJX2gkpf','Redfern Sasha','Spruce Drive, 5431','','Sasha_Redfern6812@joiniaa.com');
INSERT INTO FELHASZNALO VALUES('Kauila','rSOcHnXuPtoi2ZAKcY14','Walker Caleb','Bliss  Rue, 9867','','Caleb_Walker8876@sveldo.biz');
INSERT INTO FELHASZNALO VALUES('Arrowwood','FkJBsvp4weg9IQ1A7Z0s','Neville Rhea','Chelsea Manor  Hill, 1956','','Rhea_Neville7040@nanoff.biz');
INSERT INTO FELHASZNALO VALUES('Guaco','dOh3pKIegJnVPp3V4xPG','Phillips William','Wager   Tunnel, 7807','','William_Phillips2895@fuliss.net');
INSERT INTO FELHASZNALO VALUES('Banyan','zBkUYTP9GcGsgaPNXhYY','Jenkins John','Adderley   Lane, 2190','','John_Jenkins8401@elnee.tech');
INSERT INTO FELHASZNALO VALUES('Drumstick','GXJ02rIDA1WnWyUJXJlN','Watson Lucas','Battis   Way, 9064','','Lucas_Watson3932@grannar.com');
INSERT INTO FELHASZNALO VALUES('Filipendula','Hh2er9F72osGJWpCu1di','Matthews Rosa','Blue Anchor  Crossroad, 5482','','Rosa_Matthews2332@deavo.com');
INSERT INTO FELHASZNALO VALUES('Butterfly weed','6eJBX3TdJoyPMff2G3CE','Purvis Chester','Arundel   Alley, 5522','','Chester_Purvis9063@twipet.com');
INSERT INTO FELHASZNALO VALUES('Hedge plant','6dScZ6KjFwdWilMoTjTL','Lunt Jack','Virgil   Rue, 5508','','Jack_Lunt9697@naiker.biz');
INSERT INTO FELHASZNALO VALUES('Arrowwood','ddlcaMKgxwjVTBHisAhU','Tate Lexi','Camdale  Drive, 6842','','Lexi_Tate939@cispeto.com');
INSERT INTO FELHASZNALO VALUES('Bindweed','4bJNelS23HYCIgwuznZO','Uttley Alexander','Church Tunnel, 6221','','Alexander_Uttley6598@liret.org');
INSERT INTO FELHASZNALO VALUES('Bindweed','vVrC22UZIzZyqy2ISRsh','Mullins Ema','Archery  Alley, 8993','','Ema_Mullins5326@dionrab.com');
INSERT INTO FELHASZNALO VALUES('Bluebonnet','kzXJPIwq9PncUrx9ZaAF','Campbell Johnny','Charnwood   Avenue, 5907','','Johnny_Campbell4220@bungar.biz');
INSERT INTO FELHASZNALO VALUES('Bearberry','IVy0fhACobqFbSBFF2Io','Bloom Chris','Arlington  Alley, 4002','','Chris_Bloom8081@jiman.org');
INSERT INTO FELHASZNALO VALUES('California sycamore','jyN4E03zlzKx7v8U9oBV','Bright Aiden','Fair Walk, 2290','','Aiden_Bright5285@nickia.com');
INSERT INTO FELHASZNALO VALUES('Collard','crRiLFmdLXcHQeD80IsH','Benfield Taylor','Oxford Tunnel, 984','','Taylor_Benfield4335@dionrab.com');
INSERT INTO FELHASZNALO VALUES('Fig','qhLpEJH2PvqW1yRjNKAd','Veale Jacob','East Lane, 1121','','Jacob_Veale166@famism.biz');
INSERT INTO FELHASZNALO VALUES('Hedge plant','cuAUCfzQcLV6FlWCv2k2','Aldridge Liam','Apostle  Alley, 8028','','Liam_Aldridge6409@bretoux.com');
INSERT INTO FELHASZNALO VALUES('Japanese Iris','iDGj0wBpByTbSv8phrvB','Simpson Sarah','Carpenter Grove, 6644','','Sarah_Simpson3782@mafthy.com');
INSERT INTO FELHASZNALO VALUES('Chinese Evergreen','hYMpB4HOWPzVWtDRaWGS','Robinson Brad','Lincoln Hill, 1309','','Brad_Robinson3465@tonsy.org');
INSERT INTO FELHASZNALO VALUES('Candytuft','4cMhteaGvR00aLb6pgmF','Mcnally Sonya','Canon Avenue, 1886','','Sonya_Mcnally5351@jiman.org');
INSERT INTO FELHASZNALO VALUES('Cotton plant','hqsMkbxmynOmKpFQb8Ff','Russell Alice','Pine Hill, 8231','','Alice_Russell4883@nimogy.biz');
INSERT INTO FELHASZNALO VALUES('Manzanita','VMO8bOkIo0toT12Yd9j5','Johnson Raquel','Viscount   Street, 9522','','Raquel_Johnson753@deons.tech');
INSERT INTO FELHASZNALO VALUES('Baobab','XFvV3cbAotaeHxIV0Qk5','Mason Denny','Vine  Alley, 5298','','Denny_Mason5181@mafthy.com');
INSERT INTO FELHASZNALO VALUES('Hedge plant','BWItAQu7TaZbYyPIaF7a','Whatson Savannah','Fairbairn  Avenue, 9280','','Savannah_Whatson9466@yahoo.com');
INSERT INTO FELHASZNALO VALUES('Candytuft','yX1y7nWSvHgXYh0LexhP','Williams Penelope','Elgood   Way, 2183','','Penelope_Williams2087@bulaffy.com');
INSERT INTO FELHASZNALO VALUES('Kauila','yDOJTeChnaL20p7aCbi6','Thorpe Jack','Camley   Avenue, 3491','','Jack_Thorpe6787@deavo.com');
INSERT INTO FELHASZNALO VALUES('Cornflower','kusxo7DSOEDyn1WVWIbd','Jennson Hank','Ashley Route, 6150','','Hank_Jennson3343@gmail.com');
INSERT INTO FELHASZNALO VALUES('Bellflower','xnwFUCqdELs3HxWfIpjw','Burge Ramon','Magnolia Tunnel, 4747','','Ramon_Burge53@joiniaa.com');
INSERT INTO FELHASZNALO VALUES('Tulip','LTjJjabQsTyq1R6tjFXY','Egerton Peter','Beatty  Walk, 1201','','Peter_Egerton5863@typill.biz');
INSERT INTO FELHASZNALO VALUES('Guaco','mTnrI31ItiX5PaVuGRrk','Andersson Noah','Littlebury  Road, 5953','','Noah_Andersson4943@deavo.com');
INSERT INTO FELHASZNALO VALUES('Fennel','C8lWuF9L8tYElzgAdlDU','Hardwick Matt','Underwood  Alley, 4947','','Matt_Hardwick9810@deavo.com');
INSERT INTO FELHASZNALO VALUES('Mugwort','GnLNVrkvjfUViHhTf6EY','Baker Carl','Blackall   Rue, 3265','','Carl_Baker7329@yahoo.com');
INSERT INTO FELHASZNALO VALUES('Kentia Palm Plant','1vXlj2GN1PH6P3Gs8e2u','Ellis Priscilla','Howard Way, 74','','Priscilla_Ellis5965@infotech44.tech');
INSERT INTO FELHASZNALO VALUES('Guaco','3mq4Qrt7u9PbGor6cvNw','Archer Karla','Blenkarne  Vale, 9173','','Karla_Archer7084@guentu.biz');
INSERT INTO FELHASZNALO VALUES('Manzanita','k84Vq7nbB8MWvNfnTqUV','Mooney George','Caslon   Pass, 9696','','George_Mooney5870@grannar.com');
INSERT INTO FELHASZNALO VALUES('Butterfly weed','9iyBNJAVGZqEeaxBZJHu','Morris Teagan','Heritage Hill, 3783','','Teagan_Morris294@yahoo.com');
INSERT INTO FELHASZNALO VALUES('Pansy','XGaQ4CaXVhEeSMQnRMIC','Thompson Scarlett','Boadicea   Grove, 6250','','Scarlett_Thompson405@supunk.biz');
INSERT INTO FELHASZNALO VALUES('Elephant Ear','nMH0LsTQykXWnEmDPMZu','Camden Margot','Waldram Park  Lane, 1211','','Margot_Camden4277@hourpy.biz');
INSERT INTO FELHASZNALO VALUES('Lily','n1o3HrV6oGd7XdlupFdy','Stewart Mina','Howard Drive, 7801','','Mina_Stewart3481@womeona.net');
INSERT INTO FELHASZNALO VALUES('Cornflower','tv3nPKssdgWQHlF5xhmN','Reynolds Russel','Duthie   Boulevard, 8648','','Russel_Reynolds6578@eirey.tech');
INSERT INTO FELHASZNALO VALUES('Easter orchid','GvK9s5VjUHS2BLiHiOwu','Mccall Ramon','Cecilia  Lane, 1473','','Ramon_Mccall652@jiman.org');
INSERT INTO FELHASZNALO VALUES('Millet','vk4rCWvMQYptVcZUUIQx','Everett Janice','Camelot   Avenue, 2804','','Janice_Everett6246@twace.org');
INSERT INTO FELHASZNALO VALUES('Elephant Ear','0oo6BigXL8yx5RzGAsgY','Bailey Norah','Cliff  Road, 6216','','Norah_Bailey3363@kideod.biz');
INSERT INTO FELHASZNALO VALUES('Alstroemeria','ZaPx6auBxU426JJbASBl','Shepherd John','Ellerman   Way, 5655','','John_Shepherd6751@yahoo.com');
INSERT INTO FELHASZNALO VALUES('Kauila','TqGW6vij980FFMYmfnpw','Robinson Benjamin','Cedarne  Grove, 5678','','Benjamin_Robinson721@atink.com');
INSERT INTO FELHASZNALO VALUES('Kauila','OQZBXenxgAXl1AULgREg','Grady Tyler','Heritage Route, 9421','','Tyler_Grady835@nimogy.biz');
INSERT INTO FELHASZNALO VALUES('Filipendula','x1mC6usbDrsuy9mRLqls','Parr Deborah','Cephas  Alley, 9820','','Deborah_Parr6523@nanoff.biz');
INSERT INTO FELHASZNALO VALUES('Hedge plant','FSx9ItIui5QltckWwLEa','Pierce Abdul','West Alley, 9395','','Abdul_Pierce4288@bauros.biz');
INSERT INTO FELHASZNALO VALUES('Ironwood','DRjeZ8Z5vqQdhmvVGfkM','Bailey Elijah','Wager   Alley, 7934','','Elijah_Bailey9635@bretoux.com');
INSERT INTO FELHASZNALO VALUES('Urn Plant','Dr8DMeoqHUdLaAfy7hIm','Wallace Denis','Littlebury  Vale, 8851','','Denis_Wallace8342@qater.org');
INSERT INTO FELHASZNALO VALUES('Cactus','rboeNs8RZUIHo8LGBRL8','Smith Melanie','Ayres   Street, 2783','','Melanie_Smith9655@gembat.biz');
INSERT INTO FELHASZNALO VALUES('Gillyflower','KWnzOa3zqNSghhMAfF1t','Vaughn Hayden','Sheffield Rue, 8441','','Hayden_Vaughn1676@qater.org');
INSERT INTO FELHASZNALO VALUES('Bilberry','NPfMbO8fRahRRUD2bvSN','Shaw Emerald','Durweston   Boulevard, 442','','Emerald_Shaw7886@bretoux.com');
INSERT INTO FELHASZNALO VALUES('Carrot','9Dj2Vc8xUFTOeOoTcvhe','Dubois Lorraine','Rivervalley Hill, 8058','','Lorraine_Dubois2951@kideod.biz');
INSERT INTO FELHASZNALO VALUES('Shasta Daisy','Jo5JhRW8Z52FFGp88qgN','Taylor Harry','Blanchard  Walk, 3281','','Harry_Taylor1790@mafthy.com');
INSERT INTO FELHASZNALO VALUES('Dumb Cane','EDAlnLaYE77SVCzoYrSt','Olson Clarissa','Geary   Lane, 1525','','Clarissa_Olson1465@grannar.com');
INSERT INTO FELHASZNALO VALUES('Pansy','zWrs8V12ec5Ok3tj5piL','Harrington Helen','Hickory Lane Boulevard, 9123','','Helen_Harrington4206@liret.org');
INSERT INTO FELHASZNALO VALUES('Huckleberry','bemxOPkPkWq8w4OWf953','Thornton Alan','Fairfield  Road, 4398','','Alan_Thornton304@guentu.biz');
INSERT INTO FELHASZNALO VALUES('Aspen','xiGaxC8SaVoITUT1NUBP','Brooks Phoebe','Union  Boulevard, 5570','','Phoebe_Brooks7127@gembat.biz');
INSERT INTO FELHASZNALO VALUES('Bearberry','WMVs1wykh91QEEnRuC3K','Tailor Rebecca','Marina  Crossroad, 6302','','Rebecca_Tailor4708@supunk.biz');
INSERT INTO FELHASZNALO VALUES('Dogwood','1Fy7qEJSacieRpVJ91Ux','Hastings Erick','Bendall   Boulevard, 8536','','Erick_Hastings4831@atink.com');
INSERT INTO FELHASZNALO VALUES('Narcissus','FXYrwq3CTYAe9UkUp1hV','Haines Catherine','Caldwell   Alley, 3276','','Catherine_Haines7727@dionrab.com');
INSERT INTO FELHASZNALO VALUES('Bramble','GM5nyVEKxf9bHpdTSCdF','Windsor Macy','Under  Way, 1603','','Macy_Windsor7798@elnee.tech');
INSERT INTO FELHASZNALO VALUES('Cherry','WAmdiMLF0L9fK2Vi3k8I','Kennedy Lynn','Collent   Hill, 3293','','Lynn_Kennedy5042@bungar.biz');
INSERT INTO FELHASZNALO VALUES('Chamomile','dB4S0aeW8idROb1ejyTQ','Watson Brad','Dunstable   Grove, 6449','','Brad_Watson5870@acrit.org');
INSERT INTO FELHASZNALO VALUES('Lucky Bamboo','JCRmvXJFNUb1L5Be0fj2','Campbell Raquel','Blue Anchor  Way, 2958','','Raquel_Campbell2749@gembat.biz');
INSERT INTO FELHASZNALO VALUES('Fig','oPFNUyfLocErYWe1Z1UJ','Exton Kurt','Lexington Walk, 4047','','Kurt_Exton9356@supunk.biz');
INSERT INTO FELHASZNALO VALUES('Filipendula','UeKTnjEWn0GgTLCeKrYL','Yates Josh','Marischal  Lane, 6832','','Josh_Yates4715@qater.org');
INSERT INTO FELHASZNALO VALUES('Eucalyptus','yYaJfU84YvxZevANnolC','Walsh Maia','Central  Road, 1737','','Maia_Walsh9185@kideod.biz');
INSERT INTO FELHASZNALO VALUES('Drumstick','mKs3DzcqWx1Ekv6kvPGZ','Adler Angelique','Bempton   Tunnel, 1311','','Angelique_Adler343@gompie.com');
INSERT INTO FELHASZNALO VALUES('Goldenglow','8l33nvkFfb6ihQ1u8qdS','Tate Alma','Emden   Boulevard, 6704','','Alma_Tate6192@mafthy.com');
INSERT INTO FELHASZNALO VALUES('Indian paintbrush','vBPSRYM8K79VfPyK1Hv7','Mccormick Cara','Duthie   Alley, 8581','','Cara_Mccormick9910@gompie.com');
INSERT INTO FELHASZNALO VALUES('Ironwood','NALOmuaqPQ2pvxte64I1','Yard Logan','Victoria Rise Walk, 4042','','Logan_Yard9542@vetan.org');
INSERT INTO FELHASZNALO VALUES('Shasta Daisy','bRyQZ66yH2fXdl13RtWm','Baker Marina','Pine Grove, 760','','Marina_Baker3900@joiniaa.com');
INSERT INTO FELHASZNALO VALUES('Catmint','zpIugy8DYW0wpzCndqNn','Camden Livia','Clerkenwell Tunnel, 578','','Livia_Camden5608@womeona.net');
INSERT INTO FELHASZNALO VALUES('Rose','LBhabSMXm7w3z3Xfz5EC','Gallacher Harry','Timothy  Street, 8869','','Harry_Gallacher4557@deavo.com');
INSERT INTO FELHASZNALO VALUES('Cabbage','r7RvpMUTWOhzP1satEN0','Dale Peyton','Cockspur  Grove, 1737','','Peyton_Dale5894@mafthy.com');
INSERT INTO FELHASZNALO VALUES('Ginseng','h8kuf5AfHKqCLdqhMit9','Larkin Cherish','Charnwood   Avenue, 6026','','Cherish_Larkin1201@irrepsy.com');
INSERT INTO FELHASZNALO VALUES('Gillyflower','kEmA8yP7Fu5s5l4hxiu6','Mann Chuck','Howard Crossroad, 3276','','Chuck_Mann5680@supunk.biz');
INSERT INTO FELHASZNALO VALUES('Poppy','JYcqphFDCNoakHyyR0hc','Tait Erick','Comet House  Pass, 3890','','Erick_Tait9241@vetan.org');
INSERT INTO FELHASZNALO VALUES('Grapefruit','qZZo15VdCPEydvVFfT0O','Farmer Regina','Kilner   Crossroad, 1380','','Regina_Farmer1520@acrit.org');
INSERT INTO FELHASZNALO VALUES('Bellflower','Ru4DSVyOwtLcUPlcocCN','Gardner Josh','Caldwell   Pass, 8057','','Josh_Gardner7272@iatim.tech');
INSERT INTO FELHASZNALO VALUES('Millet','frkguufJvLZg0sjpwsxH','Wilton Aiden','Chesterfield  Boulevard, 6122','','Aiden_Wilton1179@joiniaa.com');
INSERT INTO FELHASZNALO VALUES('Pansy','PjsIqQCl5kfFS2RmqvKB','Dowson Lynn','Canon Crossroad, 5647','','Lynn_Dowson1658@yahoo.com');
INSERT INTO FELHASZNALO VALUES('African Violet','4mVWAgmrYKchD0ISBFmZ','Knight Candice','Bel   Tunnel, 1106','','Candice_Knight608@liret.org');
INSERT INTO FELHASZNALO VALUES('Morning Glory','jfPBUA7KsSVo5SksdBK2','Summers Jacqueline','King Route, 6081','','Jacqueline_Summers5735@extex.org');
INSERT INTO FELHASZNALO VALUES('Dogwood','Q6SDyzoMgt0KITwQuvmv','Eaton Adina','Adams  Road, 6724','','Adina_Eaton3530@yahoo.com');
INSERT INTO FELHASZNALO VALUES('Bee Balm Flower','ZvBqDcWClHd5f6SUrYNR','Johnson Hayden','Chandos  Route, 5151','','Hayden_Johnson5722@iatim.tech');
INSERT INTO FELHASZNALO VALUES('Elephant Ear','YcxNWH7yeE0aNJoJzBqs','Heaton Stella','Boleyn  Walk, 1551','','Stella_Heaton6952@grannar.com');
INSERT INTO FELHASZNALO VALUES('Candytuft','KezbxMopsIzVfNTW15sJ','Booth Cadence','St. Johs  Drive, 1873','','Cadence_Booth5350@elnee.tech');
INSERT INTO FELHASZNALO VALUES('Nemesia','EpjAKTkB8a69dG30XNun','Bradshaw Sloane','Berry  Crossroad, 8074','','Sloane_Bradshaw4296@irrepsy.com');
INSERT INTO FELHASZNALO VALUES('Morning Glory','QPwJrocPVU3tV2evJujo','Drake Erick','Kingly  Rue, 8552','','Erick_Drake5303@sheye.org');
INSERT INTO FELHASZNALO VALUES('Bellflower','Mt0oIsKKzwcalC204GZQ','Glass Phillip','Castlereagh   Lane, 2837','','Phillip_Glass7894@kideod.biz');
INSERT INTO FELHASZNALO VALUES('Poppy','SK2ifIkDEMKUlT7HOevb','Wilcox Nicole','Ayres   Boulevard, 6300','','Nicole_Wilcox6679@grannar.com');
INSERT INTO FELHASZNALO VALUES('Chinese Evergreen','WVPOEhlk2F3Rxz4P6dUs','Irwin Makenzie','Linden Rue, 4830','','Makenzie_Irwin2635@gmail.com');
INSERT INTO FELHASZNALO VALUES('Ambrosia','50lhHs04FgwVgWZ1KCGf','Gilmour Julius','Clarks  Street, 3376','','Julius_Gilmour1509@bretoux.com');
INSERT INTO FELHASZNALO VALUES('Millet','uyK1D6OStqHEU16iWPr3','Savage Ciara','Fieldstone Tunnel, 2358','','Ciara_Savage4254@eirey.tech');
INSERT INTO FELHASZNALO VALUES('Aspen','M7ZxVUsmedZKjaW9bvyP','Lewin Chuck','Gathorne   Way, 1593','','Chuck_Lewin7388@kideod.biz');
INSERT INTO FELHASZNALO VALUES('Bluebonnet','nmrk4hssR9hN62wStP21','Marshall Kurt','Virginia Grove, 3928','','Kurt_Marshall7358@liret.org');
INSERT INTO FELHASZNALO VALUES('Dogwood','nl2Ir00rjp3nRKwRCsFH','Hope Hazel','Hickory Lane Hill, 7162','','Hazel_Hope6392@hourpy.biz');
INSERT INTO FELHASZNALO VALUES('Drumstick','MKTo4nXoEOB5kKk9N9m2','Briggs Florence','Jackson Vale, 9551','','Florence_Briggs4851@gembat.biz');
INSERT INTO FELHASZNALO VALUES('Cherry','aDA2aWej9WgZn7dELtQ3','Andrews Aiden','Chatfield  Street, 1001','','Aiden_Andrews1349@qater.org');
INSERT INTO FELHASZNALO VALUES('Apricot','qabPUoKACJxGZNmGcfYh','Glass Emerald','Battis   Lane, 2349','','Emerald_Glass7555@bungar.biz');
INSERT INTO FELHASZNALO VALUES('Dogwood','wSgVZT6FJTSTDJkdxJQB','Blythe Vivian','Durham Grove, 6188','','Vivian_Blythe1030@bungar.biz');
INSERT INTO FELHASZNALO VALUES('Bramble','AjtuMQ0QuA4qASLGNAmK','Ebbs Isabel','Elba  Rue, 4025','','Isabel_Ebbs6883@atink.com');
INSERT INTO FELHASZNALO VALUES('Arrowwood','sSXQkJuji02tMCJVUGUb','Devonport Domenic','Eaglet  Boulevard, 5100','','Domenic_Devonport297@gompie.com');
INSERT INTO FELHASZNALO VALUES('Red Hot Poker Plant','VgHLLCrhZaJbgpKtaQYb','Plumb Valentina','Ampton  Walk, 2279','','Valentina_Plumb7366@ubusive.com');
INSERT INTO FELHASZNALO VALUES('Huckleberry','vijvfNUviBAcy5pL9zt5','Saunders Gloria','Berry  Vale, 5240','','Gloria_Saunders7538@twipet.com');
INSERT INTO FELHASZNALO VALUES('Eucalyptus','7breco1kqAcz71OY9eI5','Sherry Alan','Ensign   Way, 2891','','Alan_Sherry4990@nickia.com');
INSERT INTO FELHASZNALO VALUES('Aspen','Pu5YclkS8VRxkTyRFmNh','Hall Bob','Bales  Vale, 97','','Bob_Hall6765@deavo.com');
INSERT INTO FELHASZNALO VALUES('Cucumber','M78FLaPgbfPoFBI1HC5G','Holt Valerie','Gatonby   Grove, 2502','','Valerie_Holt6204@deavo.com');
INSERT INTO FELHASZNALO VALUES('Soapwort','Yw3DLvYSsZ2ivoH83qfH','Marshall Jackeline','Cadogan  Walk, 4334','','Jackeline_Marshall8094@extex.org');
INSERT INTO FELHASZNALO VALUES('Guaco','zjsutCsWl4PujYnChhhv','Emerson Summer','Caxton  Street, 3798','','Summer_Emerson5187@corti.com');
INSERT INTO FELHASZNALO VALUES('Dogwood','mXwTw3zKxBlYlSvPXreA','Osman Cedrick','Boldero   Grove, 3035','','Cedrick_Osman423@irrepsy.com');
INSERT INTO FELHASZNALO VALUES('Kentia Palm Plant','XNhjP8hdawfx1tg6X1EK','Ward Janelle','Bempton   Road, 1444','','Janelle_Ward3530@brety.org');
INSERT INTO FELHASZNALO VALUES('Cherry','AtaMpayDzVTOw649M2Jt','Freeburn Brooklyn','Byland  Route, 4678','','Brooklyn_Freeburn5423@gmail.com');
INSERT INTO FELHASZNALO VALUES('Butterfly weed','a4PaJZDFkMSs2hgu5LE3','Chadwick Eduardo','Wager   Hill, 3731','','Eduardo_Chadwick8080@deons.tech');
INSERT INTO FELHASZNALO VALUES('Lily','tHDZgZbDymg13mq0BnXo','Wright Michael','Bury  Boulevard, 5071','','Michael_Wright5211@corti.com');
INSERT INTO FELHASZNALO VALUES('Bearberry','DVUeE0EPTWIErGihBHTw','Knight Erin','Garfield Rue, 9115','','Erin_Knight3742@tonsy.org');
INSERT INTO FELHASZNALO VALUES('Birch','394BWvRMXzwllsROk6ax','Holmes Chris','Walnut Vale, 6431','','Chris_Holmes9845@deavo.com');
INSERT INTO FELHASZNALO VALUES('Bindweed','jroSdZWNDUVRVnShKGn2','Farrell Aisha','Camelot   Pass, 9633','','Aisha_Farrell29@joiniaa.com');
INSERT INTO FELHASZNALO VALUES('Collard','XXDGjyHHTHT5BhlFgZ0F','Sherry Nick','Blackall   Alley, 2896','','Nick_Sherry1663@eirey.tech');
INSERT INTO FELHASZNALO VALUES('Morning Glory','Vd9vdp7RKwzKZ18T7bxy','Flynn Jack','Ampton  Hill, 5089','','Jack_Flynn1151@bulaffy.com');
INSERT INTO FELHASZNALO VALUES('Snowflake','yYj1O8oTKh1oxVnA4Nl4','Stone Anais','Champion  Grove, 4482','','Anais_Stone2091@bulaffy.com');
INSERT INTO FELHASZNALO VALUES('Goldenglow','PWvcSWXQTK3T9x35K2F7','Styles Logan','Monroe Boulevard, 5737','','Logan_Styles2317@corti.com');
INSERT INTO FELHASZNALO VALUES('Cucumber','ZBEv44LFLf9PulCrlvgz','Malone Parker','Camdale  Walk, 9272','','Parker_Malone8450@nickia.com');
INSERT INTO FELHASZNALO VALUES('Indian paintbrush','3E1rJ3IziF3s08WFsy80','Neal Chuck','Wager   Drive, 8498','','Chuck_Neal5879@twace.org');
INSERT INTO FELHASZNALO VALUES('Vervain','zEPsmSbHhlr31CpmGqT7','Upsdell Jocelyn','Dutton   Rue, 6083','','Jocelyn_Upsdell8525@bulaffy.com');
INSERT INTO FELHASZNALO VALUES('Coneflower','0ivbktBn9Np57KNR7t6x','Tobin Mandy','Eldon  Walk, 7306','','Mandy_Tobin5112@vetan.org');
INSERT INTO FELHASZNALO VALUES('Cup Flower','GwX0OqC5cRTo9HcnCwDy','Addley Phillip','Angel  Drive, 7997','','Phillip_Addley5568@sveldo.biz');
INSERT INTO FELHASZNALO VALUES('Columbine','sEG8E2bRFtdLVecmIVmb','Poulton Johnathan','Thrale   Hill, 2275','','Johnathan_Poulton1740@kideod.biz');
INSERT INTO FELHASZNALO VALUES('Goldenglow','CpjX8uMMq5OBV6CkmDJo','Jenkin Mason','Hamilton  Avenue, 2114','','Mason_Jenkin7694@fuliss.net');
INSERT INTO FELHASZNALO VALUES('Butterfly weed','u3av2CD3yWuPacaYZzuq','Simpson Oliver','Chicksand  Boulevard, 111','','Oliver_Simpson612@supunk.biz');
INSERT INTO FELHASZNALO VALUES('Arrowwood','KNs1o5ByPd49qyrZY5Mw','Barrett Kurt','Bective  Tunnel, 6482','','Kurt_Barrett5653@atink.com');
INSERT INTO FELHASZNALO VALUES('Baobab','vypkynIBYvgYjKV0rSwZ','Hilton Rick','Carlisle  Vale, 6926','','Rick_Hilton9772@gmail.com');
INSERT INTO FELHASZNALO VALUES('Indian paintbrush','NFwPqepOY2KiXAJqXgnk','Bright Tom','Apostle  Route, 3633','','Tom_Bright2406@atink.com');
INSERT INTO FELHASZNALO VALUES('Bramble','3zQ1jKquI3pqlSal1fl9','Gordon Nicholas','Dunstans  Pass, 6917','','Nicholas_Gordon268@jiman.org');
INSERT INTO FELHASZNALO VALUES('Chestnut','3bV9ufC4qxzd5Om73zn0','Kennedy Rufus','Longleigh   Hill, 6910','','Rufus_Kennedy9948@mafthy.com');
INSERT INTO FELHASZNALO VALUES('Guaco','Ki41UPcUr0xXrKswgjEz','Whinter Erick','Parkfields Way, 9686','','Erick_Whinter6588@supunk.biz');
INSERT INTO FELHASZNALO VALUES('Dogwood','Su5oXfP5lk9KmL80dDVA','Riley Ethan','Boadicea   Avenue, 5594','','Ethan_Riley7382@gmail.com');
INSERT INTO FELHASZNALO VALUES('Drumstick','3q1uhZF2sToc148FoKmO','Dubois Aiden','Bacon  Road, 6937','','Aiden_Dubois410@twace.org');
INSERT INTO FELHASZNALO VALUES('Chestnut','GnI4or4HZFw28utqi3Qb','Simmons Cedrick','Blomfield  Pass, 1147','','Cedrick_Simmons4953@supunk.biz');
INSERT INTO FELHASZNALO VALUES('Groundberry','DeRvcmpfiNNE7PE0Wyu1','Janes Tony','Carlisle  Crossroad, 8887','','Tony_Janes5@tonsy.org');
INSERT INTO FELHASZNALO VALUES('Goldenrod','wJTzSVkeGfHDK9qCWcoe','Santos Joseph','Blue Anchor  Rue, 2051','','Joseph_Santos4709@bulaffy.com');
INSERT INTO FELHASZNALO VALUES('Dindle','2calIvD3Pp3dVPSmyKIb','Samuel Caleb','St. Johs  Hill, 5789','','Caleb_Samuel4532@yahoo.com');
INSERT INTO FELHASZNALO VALUES('Cotton plant','mzaODODrcCOnIHwuAjfX','Chadwick Domenic','Zealand Walk, 9089','','Domenic_Chadwick6112@acrit.org');
INSERT INTO FELHASZNALO VALUES('Cabbage','BqtkPmzdPSBO5VI4ypYu','May Benny','Gatonby   Avenue, 798','','Benny_May6375@liret.org');
INSERT INTO FELHASZNALO VALUES('Candytuft','Ub2JzbVeC3f7RvQeJFDJ','Wild Barney','Aberavon  Drive, 1506','','Barney_Wild678@kideod.biz');
INSERT INTO FELHASZNALO VALUES('Daisy','flXSy40IFG4xawv3xgxl','Rodgers Eduardo','Lonsdale  Street, 3823','','Eduardo_Rodgers7914@liret.org');
INSERT INTO FELHASZNALO VALUES('Clarkia','9v8iRgSHoc1aVD9IWbTK','Michael Nate','Fair Rue, 1896','','Nate_Michael1828@mafthy.com');
INSERT INTO FELHASZNALO VALUES('Calla Lily','4BpVNFV5PIPdvJE6Lp2i','Watson Gabriel','Bel   Lane, 3346','','Gabriel_Watson8541@muall.tech');

INSERT INTO velemeny VALUES('943582','csoki','Praktikus a csomagolása, ellenben a porciózása az én mértékeimhez kicsit kicsi.','KopiTomi');
INSERT INTO velemeny VALUES('546251','Tokaji aszú','csodáltaos íz mélysége van, kellően savas míg megörzi a gyümölcsösséget','BALAZS');

INSERT INTO megrendeles VALUES('654','KopiTomi',SYSDATE,DEFAULT);
INSERT INTO megrendeles VALUES('352','Gezuka',SYSDATE,DEFAULT);
INSERT INTO megrendeles VALUES('513','Bence',SYSDATE,DEFAULT);
INSERT INTO megrendeles VALUES('846','Keve',SYSDATE,DEFAULT);
--INSERT INTO OSSZEKESZIT VALUES('BALAZS','654');
commit;
