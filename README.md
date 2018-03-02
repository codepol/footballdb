# footballdb
<b> Football Stats DB for Oracle PL/SQL Diploma Project </b>

<i> Project Brief: </i>

This is a project to create a working database showing team statisitics top level European Football over the past 3 seasons.  The leagues in question are the English Premier League, the German Bundesliga, the Spanish La Liga and the French Ligue 1.  Statistics have been taken from various sources including whoscored.com and Wikipedia.  Using role permissions certain users can enter stats on to the tables, my "Stattos", and guest users can view lists based on the stats entered on the underlying tables.


<i> Files and Description: </i>

setup.sql - This is the master installation file which can be ran to create the database and objects.  It contains a script to run create_users, create_tables, insert_into_tables, create_views, fsdb_create_users2 and create_objects file to enable a quick and easy setup to get you started.

create_users.sql - This is to create the tablespace, schema and roles and permissions required for the main DBA.

create_tables.sql - This will create the tables needed for the project

insert_into_tables.sql - This will insert the existing data collected up to the end of November 2017 and adds the foreign key constraints to the tables.

create_views.sql - This will create views to enable better and more user-friendly lists reporting.

fsdb_create_users2.sql - This is to create additonal users and assigning the roles and nescessary permissions to them.

create_objects.sql - Additional sequences, triggers, functions and packages in order to maintain database entegrity and automate certain tasks. 

rep_topstatsnew.sql - Report to show the best performing teams in three areas; Possesion%, Pass Completion Rate and Goals Scored.  Can be run using the @ symbol in SQL PLus. 

rep_topcapx.sql - Report to show the stadiums with with the highest capacity.  It demonstrates the use of a cursor and can be run to show the top x teams by order of stadium capacity, where x is defined at run-time.  Can be run using the @ symbol in SQL PLus.

report_topcap.sql - Report to show the stadiums with with a capacity over 50,000.  This is the predecessor of the rep_topcapx and demonstrates the ability to format columns heading for SQL reports.  Can be run using the @ symbol in SQL PLus.

fsdb_model_screenshots.docx - An illustrative image showing the relationship between the tables and views in the schema with prinary key and foreign key links.

<i> Technical Data: </i>

To install on your system, simply run the setup.sql file via SQLPlus or in SQL Developer.  If installing manually using the individual scripts then <b> the scripts should be ran in the following order: </b>

1. create_users.sql
2. create_tables.sql
3. insert_into_tables.sql
4. create_views.sql
5. fsdb_create_users2.sql
6. create_objects.sql

========================================================================================================================================

Thanks for reading and please email if you have any comments or suggestions.

Paul
