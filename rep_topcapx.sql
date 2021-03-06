-- CURSOR EXAMPLE TO SHOW TOP x TEAMS BY STADIUM CAPACITY
-- where x is defined by the user

set serveroutput on
declare
  team TEAM_SUMMARY_V.TEAM%TYPE;
  stad TEAM_SUMMARY_V.STADIUM_NAME%TYPE;
  cap  TEAM_SUMMARY_V.CAPACITY%TYPE;
  cursor stad_cursor is select 
  team, stadium_name, capacity from team_summary_v
  where CAPACITY is not null
  order by CAPACITY desc;
BEGIN
  open stad_cursor;
  LOOP
    FETCH stad_cursor into team, stad, cap;
    exit when stad_cursor%ROWCOUNT > &NO_OF_TEAMS or stad_cursor%NOTFOUND;
    SYS.DBMS_OUTPUT.PUT_LINE (team || ', ' || stad || ', ' || cap);
    end loop;
    close stad_cursor;
end;
/
