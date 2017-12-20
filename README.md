# footballdb
<b> Football Stats DB for Oracle PL/SQL Diploma Project </b>

<i> Details: </i>

Name: Paul McLaughlin

Email:

Phone Number:


<i> Project Brief: </i>

This is a project to create a working database showing team statisitics top level European Football over the past 3 seasons.  The leagues in question are the English Premier League, the German Bundesliga, the Spanish La Liga and the French Ligue 1.  Statistics have been taken from various sources including whoscored.com and Wikipedia.  Using role permissions certain users can enter stats on to the tables, my "Stattos", and guest users can view lists based on the stats entered on the underlying tables.


<i> Files and Description: </i>

create_users.sql - This is to create the tablespace, schema and roles and permissions required for the main DBA.

create_tables.sql - This will create the tables needed for the project

insert_into_tables.sql - This will insert the existing data collected as at end of November 2017

create_views.sql - This will create views that our guest users can look at.

fsdb_create_users2.sql - This is to create additonal users and assigning the roles and nescessary permissions to them

create_objects.sql - Additional sequences, triggers and functions in order to maintain database entegrity 

cursor - Can be run to show the top 10 teams by order of stadium capacity


<i> Technical Data: </i>

To install on your system, simply run the setup.sql file via SQLPlus or in SQL Developer.  If installing manually using the individual scripts then <b> the scripts should be ran in the following order: </b>

1. create_users.sql
2. create_tables.sql
3. insert_into_tables.sql
4. create_views.sql
5. fsdb_create_users2.sql
6. create_objects.sql
7. TBC
