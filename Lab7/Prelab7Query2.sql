-- Pre-lab 7 --
-- Nicholas Brown --

set implicit_transactions on

select @@OPTIONS & 2

-- inserts --
insert into colors values ('cyan')
insert into colors values ('magenta')
insert into colors values ('yellow')

-- transaction count --
select @@TRANCOUNT

-- select colors --
select * from colors

-- commit --
commit

-- rollback --