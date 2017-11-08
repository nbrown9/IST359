/*Example*/

select *
	from fudgemart_departments_lookup
	order by department_id desc

/*2.a*/
select employee_lastname, employee_firstname
	from fudgemart_employees
	where employee_jobtitle = 'Sales Associate'
	order by employee_lastname, employee_firstname

/*2.b*/
select employee_lastname, employee_firstname, employee_department
	from fudgemart_employees
	where employee_department like 'H%'
	order by employee_lastname, employee_firstname

/*2.c*/
select employee_firstname + ' ' + employee_lastname as employee_name,
		getdate() as today_date,
		employee_hiredate,
		datediff(dd, employee_hiredate,getdate())/365 as years_of_service
	from fudgemart_employees
	order by years_of_service desc

/*2.d*/
select top 10 employee_firstname + ' ' + employee_lastname as employee_name,
		getdate() as today_date,
		employee_hiredate,
		datediff(dd, employee_hiredate, getdate())/365 as years_of_service
	from fudgemart_employees
	order by years_of_service desc

/*2.e*/
select top 1 product_name,
		product_retail_price
	from fudgemart_products
	order by product_retail_price desc

/*2.f*/
select vendor_name,
		product_name,
		product_retail_price,
		product_wholesale_price,
		product_retail_price - product_wholesale_price as product_markup
	from fudgemart_vendors
		left join fudgemart_products on vendor_id=product_vendor_id
	order by vendor_name desc

/*2.g*/
select employee_firstname + ' ' + employee_lastname as employee_name,
	timesheet_payrolldate,
	timesheet_hours
	from fudgemart_employees
		join fudgemart_employee_timesheets on employee_id = timesheet_employee_id
	where employee_id = 1 and
		month(timesheet_payrolldate)=1 and
		year(timesheet_payrolldate)=2006
	order by timesheet_payrolldate

/*2.h*/
select employee_firstname + ' ' + employee_lastname as employee_name,
	employee_hourlywage,
	timesheet_hours,
	employee_hourlywage*timesheet_hours as employee_gross_pay
	from fudgemart_employee_timesheets
		join fudgemart_employees on employee_id = timesheet_employee_id
	where timesheet_payrolldate = '1/6/2006'
	order by employee_gross_pay asc

/*2.i*/
select distinct product_department,
	employee_firstname + ' ' + employee_lastname as department_manager,
	vendor_name as department_vendor,
	vendor_phone as department_vendor_phone
	from fudgemart_employees
		join fudgemart_departments_lookup on employee_department = department_id
		join fudgemart_products on product_department = department_id
		join fudgemart_vendors on product_vendor_id = vendor_id
	where employee_jobtitle='Department Manager'

/*2.j*/
select vendor_name, vendor_phone
	from fudgemart_vendors
		left join fudgemart_products on vendor_id=product_vendor_id
	where product_name is null