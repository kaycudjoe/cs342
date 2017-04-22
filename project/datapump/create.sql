drop user kec32 cascade;

create user kec32
	identified by password
	quota 5M on System;
grant
	connect,
	create table,
	create session,
	create sequence,
	create view,
	create materialized view,
	create procedure,
	create trigger,
	unlimited tablespace,
	to kec32;

DROP DIRECTORY exp_dir;
CREATE DIRECTORY exp_dir AS  'C:Users\kec32\Documents\project';
GRANT READ, WRITE ON DIRECTORY exp_dir to kec32;