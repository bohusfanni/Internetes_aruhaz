
Table STOCK dropped.


Table BASKET dropped.


Table STOCK created.


Table BASKET created.


1 row inserted.


1 row inserted.


Commit complete.


Error starting at line : 8 in command -
CREATE OR REPLACE TRIGGER update_stock
  BEFORE DELETE OR INSERT OR UPDATE ON basket
  FOR EACH ROW
DECLARE
    stock_amount number;
    stock_name varchar2(200);
    my_fancy_exception EXCEPTION;
    PRAGMA EXCEPTION_INIT( my_fancy_exception, -20001 );
BEGIN
  if inserting then
     select amount,name into stock_amount, stock_name from stock where item_id=:new.item_id for update  ;
     if (stock_amount<:new.amount) then
       raise_application_error (-20001, 'kifogyott az '||stock_name);
     end if;
     update stock s set s.amount=s.amount-:new.amount
       where s.item_id=:new.item_id;
  end if;
  if updating then
     update stock s set s.amount=s.amount-:new.amount+:old.amount
       where s.item_id=:new.item_id;
  end if;
  if deleting then
     update stock s set s.amount=s.amount+:old.amount where s.item_id=:old.item_id;
  end if;
END;
Error report -
ORA-00603: ORACLE server session terminated by fatal error
ORA-00600: internal error code, arguments: [kqlidchg0], [], [], [], [], [], [], [], [], [], [], []
ORA-00604: error occurred at recursive SQL level 1
ORA-00001: unique constraint (SYS.I_PLSCOPE_SIG_IDENTIFIER$) violated
00603. 00000 -  "ORACLE server session terminated by fatal error"
*Cause:    An Oracle server session was in an unrecoverable state.
*Action:   Log in to Oracle again so a new server session will be created
           automatically.  Examine the session trace file for more
           information.

Error starting at line : 35 in command -
insert into basket values ('Vevő Viktor', 1,20)
Error at Command Line : 35 Column : 1
Error report -
SQL Error: Nem olvasható több adat a programcsatornáról.
