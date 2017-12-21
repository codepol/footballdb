-- Report to show the top teams in the current season by Highest Possession %, Highest Pass Completion %
-- and top goal scorers.  Can be run using the @ symbol in SQL PLus.

set serveroutput on
set pagesize 24
set newpage 0
set linesize 70
set echo on

DECLARE
  a varchar2(30);
  b varchar2(30);
  c varchar2(30);
begin
  a := maxpossesion();
  b := maxpassperc();
  c := maxgoals();
  dbms_output.put_line('Top Teams by Stat - Current Season');
  dbms_output.put_line('Highest Poss%: ' || a);
  dbms_output.put_line('Highest PassComp%: ' || b);
  dbms_output.put_line('Top Scorers: ' || c);
end;
/

