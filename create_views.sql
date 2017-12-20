-- Switch user to FSDB so I don't have to specify schema prefix 
ALTER SESSION SET CURRENT_SCHEMA = FSDB;

-- create views

CREATE OR REPLACE FORCE VIEW "FSDB"."AVG_GOALS_BY_CITY_V" ("CITY", "NO_OF_TEAMS", "AVG_GOALS_CURR_SEASON") AS 
select s.city, count(t.teamid), AVG(ts.value)
from STADIUMS s, TEAMS t, TEAM_SEASON_STATS ts, COMPETITIONS c
where s.TEAMID = t.TEAMID
and t.TEAMID = ts.TEAMID
and ts.COMPID = c.COMPID
and ts.STATID = 5
and c.INDCURRENT = 'Y'
group by s.city
order by AVG(value) DESC;

create or replace view team_summary_v ("TEAM", "STADIUM_NAME", "CITY", "CAPACITY", "GOALS_THIS_SEASON")as 
select t.TEAMNAME, s.STADIUMNAME, s.city, s.CAPACITY, SUM(ts.value)
from STADIUMS s, TEAMS t, TEAM_SEASON_STATS ts, COMPETITIONS c
where s.TEAMID = t.TEAMID
and t.TEAMID = ts.TEAMID
and ts.COMPID = c.COMPID
and ts.STATID = 5
and c.INDCURRENT = 'Y'
group by t.TEAMNAME, s.STADIUMNAME, s.city, s.CAPACITY
order by t.TEAMNAME;

