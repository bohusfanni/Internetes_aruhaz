create or replace TRIGGER megrendel
AFTER INSERT OR UPDATE OR DELETE ON Rendel
BEGIN
  UPDATE megrendeles
  SET megrendeles.osszeg = megrendeles.osszeg + (rendel.ar * rendel.darab)
  WHERE felhnev = megrendeles.felhnev;
END;
/