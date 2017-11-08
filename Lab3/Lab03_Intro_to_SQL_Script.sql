/* ***********************************************************************************************
   IST 359 - Intro to DBMS
   Lab 03 - Intro to SQL

   Your Name:Nicholas Brown


   NOTE: This lab will be done in 2 parts. You will want to use the same file for both parts.
   When you are finished with both parts, you should be able to run this script in its entirety.

   *********************************************************************************************** */

-- Part  1 Leave the following line of code here.
USE IST359_M002_nlbrown

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'fudgemart_employees')
   DROP TABLE fudgemart_employees 
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'fudgemart_jobtitles_lookup')
   DROP TABLE fudgemart_jobtitles_lookup 
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'fudgemart_timesheets')
   DROP TABLE fudgemart_timesheets 
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'fudgemart_departments_lookup')
   DROP TABLE fudgemart_departments_lookup 

GO
--  2.a. Enter the code from the task in lab 03, part 1 here: DDL CREATE Fudgemart Departments

-- SELECT * FROM INFORMATION_SCHEMA.TABLES --

CREATE TABLE fudgemart_departments_lookup (
	department_id varchar(20) NOT NULL,
	CONSTRAINT PK_fudgemart_department_id
		PRIMARY KEY (department_id)
)

GO
--  2.b. Enter the code from the task in lab 03, part 1 here: Get Data in Fudgemart Department

INSERT INTO fudgemart_departments_lookup
	(department_id) VALUES ('Customer Service')

INSERT INTO fudgemart_departments_lookup
	(department_id) VALUES ('Electronics')
	
INSERT INTO fudgemart_departments_lookup
	(department_id) VALUES ('Hardware')
	
INSERT INTO fudgemart_departments_lookup
	(department_id) VALUES ('Sporting Goods')

SELECT * FROM fudgemart_departments_lookup

GO
--  2.c. Enter the code from the task in lab 03, part 1 here: DDL for Jobtitles 

CREATE TABLE fudgemart_jobtitles_lookup (
	jobtitle_id varchar(20) not null
)

GO
-- 2.d. Enter the code from the task in lab 03, part 1 here: Define Jobtitles PK

ALTER TABLE fudgemart_jobtitles_lookup
    ADD CONSTRAINT pk_jobtitle_id
		PRIMARY KEY(jobtitle_id)

GO
--  2.e. Enter the code from the task in lab 03, part 1 here: Get some data in Jobtitles

INSERT INTO fudgemart_jobtitles_lookup
(jobtitle_id) VALUES ('CEO')

INSERT INTO fudgemart_jobtitles_lookup
(jobtitle_id) VALUES ('Store Manager')

INSERT INTO fudgemart_jobtitles_lookup
(jobtitle_id) VALUES ('Department Manager')

INSERT INTO fudgemart_jobtitles_lookup
(jobtitle_id) VALUES ('Sales Associate')

SELECT * FROM fudgemart_jobtitles_lookup

GO
--  2.f. Enter the code from the task in lab 03, part 1 here: DDL to create Employees w constraints

CREATE TABLE fudgemart_employees (
	employee_id int not null,
	employee_ssn char(9) not null,
	employee_lastname varchar(50) not null,
	employee_firstname varchar(50) not null,
	employee_jobtitle varchar(20) not null,
	employee_department varchar(20) not null,
	employee_birthdate datetime not null,
	employee_hiredate datetime DEFAULT getdate() not null,
	employee_termdate datetime null,
	employee_hourlywage money DEFAULT 8 not null,
	employee_supervisor_id int null,
	CONSTRAINT pk_employee_id PRIMARY KEY (employee_id),
	CONSTRAINT ck_employee_minimum_wage CHECK
		(employee_hourlywage>=8),
	CONSTRAINT u_employee_ssn UNIQUE (employee_ssn),
	CONSTRAINT ck_employee_birthdate CHECK
		(datediff(yy,employee_birthdate,getdate())>15)
)

GO
-- 2.g. Enter the code from the task in lab 03, part 1 here: Define FK constraint in Employees

ALTER TABLE fudgemart_employees
	ADD
		CONSTRAINT fk_employee_department
				FOREIGN KEY (employee_department)
			REFERENCES fudgemart_departments_lookup(department_id),
		CONSTRAINT fk_employee_jobtitle
			FOREIGN KEY (employee_jobtitle)
			REFERENCES fudgemart_jobtitles_lookup(jobtitle_id)

GO
-- 2.h. Enter the code from the task in lab 03, part 1 here: Load up 6 employees

INSERT INTO fudgemart_employees (
	employee_id,
	employee_ssn,
	employee_lastname,
	employee_firstname,
	employee_jobtitle,
	employee_department,
	employee_birthdate,
	employee_hiredate,
	employee_hourlywage
) VALUES
	(1,
	'111220001',
	'Photo',
	'Arial',
	'Sales Associate',
	'Electronics',
	'1/12/1982',
	'4/16/2004',
	12.70
	),
	(2,
	'111220002',
	'Ladd',
	'Sal',
	'Sales Associate',
	'Electronics',
	'11/30/1982',
	'7/26/2005',
	11.90
	),
	(3,
	'111220003',
	'Dawind',
	'Dustin',
	'Sales Associate',
	'Hardware',
	'9/3/1972',
	'7/2/2004',
	12.45
	),
	(4,
	'111220004',
	'Shores',
	'Sandi',
	'Sales Associate',
	'Hardware',
	'5/13/1990',
	'6/26/2005',
	10.50
	),
	(5,
	'111220005',
	'Gunnering',
	'Isabelle',
	'Department Manager',
	'Electronics',
	'2/22/1974',
	'8/16/2005',
	15.50
	),
	(6,
	'111220006',
	'Hvmeehom',
	'Lee',
	'Department Manager',
	'Hardware',
	'7/29/1973',
	'1/26/2004',
	14.85
	)

GO
-- 2.i. Enter the code from the task in lab 03, part 1 here: DML: Lets see our employees

SELECT * from fudgemart_employees

GO
-- 2.j. Enter the code from the task in lab 03, part 1 here: DML: Who’s working in Electronics?

SELECT * from fudgemart_employees
	WHERE employee_department = 'Electronics'

GO
--  2.k. Enter the code from the task in lab 03, part 1 here: DML: And who are the managers?

SELECT * from fudgemart_employees
	WHERE employee_department = 'Electronics'
	AND employee_jobtitle <> 'Department Manager'

GO
--  2.l. Enter the code from the task in lab 03, part 1 here DML: DML to update a row

UPDATE fudgemart_employees
	SET employee_supervisor_id=5
	WHERE employee_department = 'Electronics'
	AND employee_jobtitle <> 'Department Manager'

GO
--  2.m. Enter the code from the task in lab 03, part 1 here DML: DML to search and sort!

SELECT employee_firstname, employee_lastname, employee_hourlywage
	FROM fudgemart_employees
	WHERE employee_hourlywage > 12
	ORDER BY employee_hourlywage

GO


-- Part 2
-- 3.a. 
-- Write the SQL statement to build the fudgemart_timesheets 
--   table columns only as outlined in section 1.b of the lab. Do not 
--   create any constraints at this time
CREATE TABLE fudgemart_timesheets (
	timesheet_id int identity(1,1) not null,
	timesheet_payrolldate datetime not null,
	timesheet_employee_id int not null,
	timesheet_hours dec(3,1) DEFAULT 40.00 not null
)

-- 3.b. 
-- Modify the fudgemart_timesheets table to add the constraints
--   as outlined in section 1.b of the lab
ALTER TABLE fudgemart_timesheets
	ADD
		CONSTRAINT pk_timesheet_id
			PRIMARY KEY (timesheet_id),
		CONSTRAINT fk_timesheet_employee_id
			FOREIGN KEY (timesheet_employee_id)
			REFERENCES fudgemart_employees(employee_id),
		CONSTRAINT ck_timesheet_hours
			CHECK (timesheet_hours between 0 and 60)
GO
-- 3.c. 
-- Write the code to add one week of timesheets for each employee
--   (6 statements total) for the week of 9/10/2007. Each employee
--   worked 45 hours
INSERT INTO fudgemart_timesheets (
	timesheet_payrolldate,
	timesheet_employee_id,
	timesheet_hours
) VALUES
	(
	'9/10/2007',
	1,
	45.00
	),
	(
	'9/10/2007',
	2,
	45.00
	),
	(
	'9/10/2007',
	3,
	45.00
	),
	(
	'9/10/2007',
	4,
	45.00
	),
	(
	'9/10/2007',
	5,
	45.00
	),
	(
	'9/10/2007',
	6,
	45.00
	)
	
GO
--  3.d. 
-- Write the code to change the hours worked to 50 hours for the 2
--   managers  HINT: you might have to look up their ID
UPDATE fudgemart_timesheets
	SET timesheet_hours = 50.00
	WHERE timesheet_employee_id = 5 OR timesheet_employee_id = 6
GO
--  3.e. 
-- Write the single statement to change Lee Hvmeehom's name to Mike
--   Rofone. HINT: write your query such that you DO NOT USE THE ID
UPDATE fudgemart_employees
	SET employee_firstname = 'Mike', employee_lastname = 'Rofone'
	WHERE employee_firstname = 'Lee' AND employee_lastname = 'Hvmeehom'

GO
--  3.f.
-- Write the single statement to change the supervisor id of everyone 
--   who works in the hardware department to the employee id of the 
--   manager of that department. Hint: First figure out the ID of the manager of the Hardward Dept.
UPDATE fudgemart_employees
	SET employee_supervisor_id = 6
	WHERE employee_department = 'Hardware'

GO
-- 4.a.
-- Write the statement to show ALL of the rows in the table fudgemart_timesheets
SELECT * FROM fudgemart_timesheets

GO
--  4.b.
-- Execute the SQL from Section 4, question 2 of the lab here. In your Word document,
--   explain why it didn't work (in your own words. Don't copy/paste the error!)
INSERT INTO fudgemart_employees (
	employee_id,
	employee_ssn,
	employee_lastname,
	employee_firstname,
	employee_jobtitle,
	employee_department,
	employee_birthdate,
	employee_hiredate,
	employee_hourlywage
) VALUES
	(1,
	'111220007',
	'Kent',
	'Belevit',
	'CEO',
	'Customer Service',
	'12/1/1965',
	'4/1/2003',
	0
	)
GO
--  4.c. 
-- Execute the SQL from Section 4, question 3 of the lab here. In your Word document, 
--   explain why it didn't work (in your own words. Don't copy/paste the error!)
INSERT INTO fudgemart_employees (
	employee_id,
	employee_ssn,
	employee_lastname,
	employee_firstname,
	employee_jobtitle,
	employee_department,
	employee_birthdate,
	employee_hiredate,
	employee_hourlywage
) VALUES
	(100,
	'111220004',
	'Kent',
	'Belevit',
	'CEO',
	'Customer Service',
	'12/1/1965',
	'4/1/2003',
	0
	)

GO

INSERT INTO fudgemart_timesheets (
	timesheet_payrolldate,
	timesheet_employee_id,
	timesheet_hours
) VALUES
	(
	'9/10/2007',
	1,
	61
	)
GO