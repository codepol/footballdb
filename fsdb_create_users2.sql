-- Log in as FSDB user and run in SQL Plus or SQL Developer

-- System Privileges for role FSDB_STAT 
  GRANT CONNECT TO FSDB_STAT;
  GRANT UNLIMITED TABLESPACE TO FSDB_STAT;

-- Assign the additional users to those roles

CREATE USER STAT1
  IDENTIFIED BY Stat1999
  DEFAULT TABLESPACE fs_db
  TEMPORARY TABLESPACE fs_db_tmp
  PROFILE DEFAULT
  ACCOUNT UNLOCK;

CREATE USER GUEST1
  IDENTIFIED BY Guest001
  DEFAULT TABLESPACE fs_db
  TEMPORARY TABLESPACE fs_db_tmp
  PROFILE DEFAULT
  ACCOUNT UNLOCK;

-- Add users to roles
GRANT FSDB_STAT to STAT1;
GRANT FSDB_GUEST to GUEST1;

-- System Privileges for user GUEST1
  GRANT CREATE SESSION TO GUEST1;

-- System Privileges for user STAT1
  GRANT CREATE SESSION TO STAT1;
