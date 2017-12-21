-- report to get the stadiums with capacities of over 50,000.  Run using the @ command in SQLPLUS

set pagesize 24
set newpage 0
set linesize 70
set echo on

COLUMN CAPACITY HEADING 'MAX|CAPACITY' 
COLUMN STADIUM_NAME  FORMAT A20 WRAP  HEADING 'STADIUM NAME' 
COLUMN TEAM FORMAT A20 WRAP HEADING 'TEAM'

SELECT capacity, stadium_name, team
FROM TEAM_SUMMARY_V
where capacity >50000
order by CAPACITY desc
;
/
