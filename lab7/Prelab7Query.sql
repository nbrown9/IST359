-- Pre-lab 7 --
-- Nicholas Brown --


-- Part 1 --

-- create table --
create table colors (
	color_name varchar(50) not null,
	constraint pk_colors primary key (color_name)
	)

-- insert values --
insert into colors values ('red')
insert into colors values ('blue')
insert into colors values ('green')

-- select --
select * from colors

