-- Pre-lab 7 Query 3 --
-- Nicholas Brown --

set implicit_transactions on

select @@OPTIONS & 2

-- delete --
delete from fudgemart_employee_timesheets
delete from fudgemart_employees

-- select --
select * from fudgemart_employee_timesheets
select * from fudgemart_employees

-- transaction count --
select @@TRANCOUNT

-- rollback --
rollback