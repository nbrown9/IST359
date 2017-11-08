-- check to see we are guest user --
SELECT user_name()

-- select --
SELECT * FROM fudgemart_employees

-- test insert privileges --
INSERT INTO fudgemart_employees (employee_id,employee_ssn,employee_lastname,employee_firstname,employee_jobtitle,employee_department,employee_birthdate,employee_hiredate, employee_hourlywage)
VALUES (35,111220035, 'Brown', 'Nick', 'Sales Associate', 'Customer Service', 06/27/1995, 09/01/2017, 70.00)

-- test new privileges --
SELECT * FROM fudgemart_employees
SELECT * FROM v_fudgemart_employee_managers