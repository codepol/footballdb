-- Switch user to FSDB so I don't have to specify schema prefix 
ALTER SESSION SET CURRENT_SCHEMA = FSDB;

-- System Privileges for role FSDB_STAT 
  GRANT CONNECT TO FSDB_STAT;
  GRANT SELECT on fsdb.STAT_IDS to FSDB_STAT;
  GRANT SELECT on fsdb.TEAMS to FSDB_STAT;
  GRANT SELECT on fsdb.TEAM_SEASON_STATS to FSDB_STAT;
  GRANT INSERT on fsdb.TEAM_SEASON_STATS to FSDB_STAT;
  
-- System Privileges for role FSDB_GUEST 
  GRANT CONNECT TO FSDB_GUEST;
  GRANT SELECT on fsdb.AVG_GOALS_BY_CITY_V to FSDB_GUEST;
  GRANT SELECT on fsdb.TEAM_SUMMARY_V to FSDB_GUEST;
  grant select on fsdb.COMPETITIONS to fsdb_guest;
  grant select on fsdb.TEAMS to fsdb_guest;
  grant select on fsdb.TEAM_SEASON_STATS to fsdb_guest;
 
-- Create additional users and assign the to those roles

CREATE USER STAT1
  IDENTIFIED BY Stat1999
  DEFAULT TABLESPACE fs_db
  TEMPORARY TABLESPACE fs_db_tmp
  PROFILE DEFAULT
  ACCOUNT UNLOCK;

GRANT UNLIMITED TABLESPACE TO STAT1;

CREATE USER GUEST1
  IDENTIFIED BY Guest001
  DEFAULT TABLESPACE fs_db
  TEMPORARY TABLESPACE fs_db_tmp
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
  
GRANT UNLIMITED TABLESPACE TO GUEST1;

-- Add users to roles
GRANT FSDB_STAT to STAT1;
GRANT FSDB_GUEST to GUEST1;

-- System Privileges for user GUEST1
  GRANT CREATE SESSION TO GUEST1;
  grant EXECUTE on fsdb.associations to guest1;
  grant execute on fsdb.MAXGOALS to guest1;
  grant execute on fsdb.MAXPASSPERC to guest1;
  grant execute on fsdb.maxpossesion to guest1;

-- System Privileges for user STAT1
  GRANT CREATE SESSION TO STAT1;

