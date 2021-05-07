CREATE OR REPLACE TRIGGER kosar_reset
AFTER INSERT
ON megrendeles
FOR EACH ROW
BEGIN
    UPDATE Rendel SET megrendelt=1;
END;
/

create or replace TRIGGER update_termek
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

