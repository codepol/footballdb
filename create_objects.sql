-- Switch user to FSDB so I don't have to specify schema prefix 
ALTER SESSION SET CURRENT_SCHEMA = FSDB;

-- Add sequences in order to create unique entries each time in the correct order
 
 CREATE SEQUENCE 
 "FSDB"."TESESTAT_SEQ"  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 1873 
 NOCACHE  NOORDER  NOCYCLE ;
 
  CREATE SEQUENCE 
  "FSDB"."TEAMS_SEQ"  MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 151 
  NOCACHE  NOORDER  NOCYCLE ;
  
  CREATE SEQUENCE 
 "FSDB"."STAT_SEQ"  MINVALUE 5 MAXVALUE 9995 INCREMENT BY 5 START WITH 45 
 NOCACHE  NOORDER  NOCYCLE ;
 
  CREATE SEQUENCE 
 "FSDB"."STADIUM_SEQ"  MINVALUE 5 MAXVALUE 99995 INCREMENT BY 5 START WITH 755 
 NOCACHE  NOORDER  NOCYCLE ;
 
  CREATE SEQUENCE 
 "FSDB"."FA_SEQ"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 56 
 NOCACHE  NOORDER  NOCYCLE ;
 
  CREATE SEQUENCE 
 "FSDB"."COMP_SEQ"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 17
 NOCACHE  NOORDER  NOCYCLE ;

-- Create a trigger to print out any capacity change when updating the stadiums table


CREATE OR REPLACE TRIGGER fsdb.display_capacity_change
BEFORE DELETE OR INSERT OR UPDATE ON stadiums
FOR EACH ROW 
WHEN (NEW.stadiumid > 0) 
DECLARE 
   cap_diff number; 
BEGIN 
   cap_diff := :NEW.capacity  - :OLD.capacity; 
   dbms_output.put_line('Old Capacity: ' || :OLD.capacity); 
   dbms_output.put_line('New Capacity: ' || :NEW.capacity); 
   dbms_output.put_line('Capacity difference: ' || cap_diff); 
END;
/
-- Create a procedure to protect the database from changes outside of normal hours.
-- Allows a window for routine updates and maintenance

create or replace PROCEDURE fsdb.secure_dml
IS
BEGIN
  IF TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '03:00' AND '23:59'
        THEN
	RAISE_APPLICATION_ERROR (-20205,
		'You may not make changes during this time.  Go to bed');
  END IF;
END secure_dml;
/
-- Create a procedure to track when a team moves to a new stadium.
-- A new entry is created on table TEAM_STAD_HIST which is actioned using a trigger

create or replace PROCEDURE fsdb.add_stad_hist
  (  p_teamid          team_stad_hist.teamid%type
   , p_stadid          TEAM_STAD_HIST.STADIUMID%type
   , p_enddate         TEAM_STAD_HIST.ENDDATE%type  )
IS
BEGIN
  INSERT INTO TEAM_STAD_HIST (teamid, STADIUMID, ENDDATE)
    VALUES(p_teamid, p_stadid, p_enddate);
END add_stad_hist;
/
create or replace TRIGGER fsdb.update_stad_hist
  AFTER UPDATE OF stadiumid ON teams
  FOR EACH ROW
BEGIN
  add_stad_hist(:old.teamid, :old.stadiumid, sysdate);
END;
/
-- Create Functions to return team with best stats in the current season. 

CREATE OR REPLACE FUNCTION fsdb.maxgoals
RETURN VARCHAR2 IS 
   mgoals varchar2(30); 
BEGIN 
   SELECT t2.teamname into mgoals 
   FROM TEAM_SEASON_STATS t, COMPETITIONS c, teams t2
   where t.COMPID = c.COMPID
   and t.TEAMID = t2.TEAMID
   and c.INDCURRENT = 'Y'
   and t.STATID = 5
   and t.VALUE = 
     (select max(value) 
     from team_season_stats t3, COMPETITIONS c2
     where t3.COMPID = c2.COMPID 
     and t3.statid = 5
     and c2.INDCURRENT = 'Y');
   RETURN mgoals; 
END;
/
CREATE OR REPLACE FUNCTION fsdb.maxpassperc
RETURN VARCHAR2 IS 
   mpass varchar2(30); 
BEGIN 
   SELECT t2.teamname into mpass 
   FROM TEAM_SEASON_STATS t, COMPETITIONS c, teams t2
   where t.COMPID = c.COMPID
   and t.TEAMID = t2.TEAMID
   and c.INDCURRENT = 'Y'
   and t.STATID = 25
   and t.VALUE = 
     (select max(value) 
     from team_season_stats t3, COMPETITIONS c2
     where t3.COMPID = c2.COMPID 
     and t3.statid = 25
     and c2.INDCURRENT = 'Y');
   RETURN mpass; 
END;
/
CREATE OR REPLACE FUNCTION fsdb.maxpossesion
RETURN VARCHAR2 IS 
   mpos varchar2(30); 
BEGIN 
   SELECT t2.teamname into mpos
   FROM TEAM_SEASON_STATS t, COMPETITIONS c, teams t2
   where t.COMPID = c.COMPID
   and t.TEAMID = t2.TEAMID
   and c.INDCURRENT = 'Y'
   and t.STATID = 20
   and t.VALUE = 
     (select max(value) 
     from team_season_stats t3, COMPETITIONS c2
     where t3.COMPID = c2.COMPID 
     and t3.statid = 20
     and c2.INDCURRENT = 'Y');
   RETURN mpos; 
END;
/

-- Create a package to get FA Name and Top Division with a user-defined variable for FA ID

create or replace PACKAGE fsdb.associations AS
  -- get FA country and name as fullname
  FUNCTION get_fullname(n_faid NUMBER)
    RETURN VARCHAR2;
  -- get FA top division
  FUNCTION get_topdiv(n_faid NUMBER)
    RETURN VARCHAR2;
END;
/
--  Package associations body for above with further detail

CREATE OR REPLACE PACKAGE BODY fsdb.associations AS
  -- get FA country and name as fullname
  FUNCTION get_fullname(n_faid NUMBER) RETURN VARCHAR2 IS
      v_fullname VARCHAR2(46);
  BEGIN
    SELECT country || ',' ||  assocname
    INTO v_fullname
    FROM football_assoc
    WHERE faid = n_faid;
 
    RETURN v_fullname;
 
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
  WHEN TOO_MANY_ROWS THEN
    RETURN NULL;
  END; -- end get_fullname
 
   -- get FA top division
  FUNCTION get_topdiv(n_faid NUMBER) RETURN VARCHAR2 IS
    n_topdiv VARCHAR2(46);
  BEGIN
    SELECT topdivision
    INTO n_topdiv
    FROM football_assoc
    WHERE faid = n_faid;
 
    RETURN n_topdiv;
 
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN NULL;
      WHEN TOO_MANY_ROWS THEN
        RETURN NULL;
  END;
END;
/
-- Give permissions to use the functions and packages required for reporting

  grant EXECUTE on fsdb.associations to guest1;
  grant execute on fsdb.MAXGOALS to guest1;
  grant execute on fsdb.MAXPASSPERC to guest1;
  grant execute on fsdb.maxpossesion to guest1;
