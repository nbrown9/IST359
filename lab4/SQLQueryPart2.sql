SELECT * FROM fudgemart_products
	WHERE product_department = 'Sporting Goods'
	ORDER BY product_name asc

SELECT employee_lastname, employee_firstname, employee_department, employee_hourlywage FROM fudgemart_employees
	WHERE employee_department = 'Customer Service' AND employee_hourlywage > 15.00
	ORDER BY employee_hourlywage asc

SELECT TOP 5 product_name, product_department, product_retail_price, product_wholesale_price, product_retail_price - product_wholesale_price as product_markup FROM fudgemart_products
	ORDER BY product_markup desc 

SELECT TOP 2 employee_firstname + ' ' + employee_lastname as employee_name, employee_hourlywage FROM fudgemart_employees
	ORDER BY employee_hourlywage desc

SELECT TOP 10 timesheet_id, timesheet_payrolldate, timesheet_employee_id, timesheet_hours FROM fudgemart_employee_timesheets
	WHERE DATENAME(month,timesheet_payrolldate) = 'December'
	ORDER BY timesheet_hours desc

SELECT vendor_name, product_department, product_name FROM fudgemart_products
	INNER JOIN fudgemart_vendors ON fudgemart_products.product_vendor_id = fudgemart_vendors.vendor_id
	ORDER BY vendor_name, product_department, product_name asc

SELECT product_name, product_wholesale_price, product_add_date FROM fudgemart_products
	INNER JOIN fudgemart_vendors ON fudgemart_products.product_vendor_id = fudgemart_vendors.vendor_id--
	WHERE vendor_name = 'Mikey'
	ORDER BY product_add_date asc

SELECT TOP 10 timesheet_id, timesheet_payrolldate, employee_firstname + ' ' + employee_lastname as employee_name, timesheet_hours FROM fudgemart_employee_timesheets
	INNER JOIN fudgemart_employees ON fudgemart_employee_timesheets.timesheet_employee_id=fudgemart_employees.employee_id
	WHERE DATENAME(month,timesheet_payrolldate) = 'December'
	ORDER BY timesheet_hours desc

SELECT DISTINCT employee_firstname + ' ' + employee_lastname as employee_name, employee_department FROM fudgemart_employees
	INNER JOIN fudgemart_employee_timesheets ON fudgemart_employees.employee_id = fudgemart_employee_timesheets.timesheet_employee_id
	WHERE timesheet_hours > 40
	ORDER BY employee_department asc

SELECT * FROM fudgemart_vendors
	WHERE vendor_website IS NULL

SELECT * FROM INFORMATION_SCHEMA.TABLES 