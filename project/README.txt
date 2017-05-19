Karen Cudjoe
Spring 2017
CS342 Final Project - Calvin Lifework Database 

To gain access to this database, log into Oracle using the system account. Then run the create.sql file (run @create). 
The user calvinLW is then created with access to the database. 

This database was created using Oracle SQL Syntax. 
This document clarifies how to use the scripts for the Calvin Lifework Database. 

create.sql: Whilst in the corerct path with the database files, run @create to create your user, connect to the account and load the database. This runs load.sql. 

load.sql: Drops and reloads table declarations and loads the table data when the user is logged in as calvinLW. 

schema.sql: This is run in the load.sql file and defines the full schema of the database. 

data.sql: This is run in the load.sql file and loas raw data with INSERT commands. 

drop.sql: This is run in the load.sql file and drops the database tables and sequences. 

queries.sql: This is run with the @queries command and it runs some queries on the database. 

procedures.sql: This is run with the @procedure command after the database is created. This updates the lastname and email for an existing Graduate who has changed his or her lastName or email. 

trigger.sql: This is run with the @triggers command, after the database is created. It creates an integrity constraint which checks to see if a graduate has already been assigned the maximum number of students. 

calvinLW.par: This creates a dump file and log for the dump. 
