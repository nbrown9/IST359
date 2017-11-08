select avg(employee_hourlywage) as average_hourly_wage
	from fudgemart_employees

select employee_department, count(*) as number_of_employees
	from fudgemart_employees
	group by employee_department

select product_department,
	avg(product_wholesale_price) as average_wholesale_price,
	avg(product_retail_price) as average_retail_price
	from fudgemart_products
	group by product_department

select count(*) as employee_count
	from fudgemart_employees
	where employee_hourlywage < (select avg(employee_hourlywage)
									from fudgemart_employees)

select employee_jobtitle, count(*) as employee_count, avg(employee_hourlywage) as employee_avg_wage
	from fudgemart_employees
	group by employee_jobtitle
	order by employee_avg_wage desc

select month(timesheet_payrolldate) as timesheet_month,
	sum(timesheet_hours) as total_hours
	from fudgemart_employee_timesheets
	where year(timesheet_payrolldate)=2006
	group by month(timesheet_payrolldate)
	order by timesheet_month

select employee_firstname + ' ' + employee_lastname as employee_fullname,
	employee_hourlywage, sum(timesheet_hours) as total_hours_ytd,
	sum(employee_hourlywage * timesheet_hours) as total_pay_ytd
	from fudgemart_employees
		join fudgemart_employee_timesheets on employee_id = timesheet_employee_id
	where year(timesheet_payrolldate)=2006
	group by employee_firstname, employee_lastname, employee_hourlywage
	order by total_pay_ytd desc

select department_id, count(product_department) as product_count
	from fudgemart_departments_lookup
		left join fudgemart_products on department_id=product_department
	group by department_id
	order by product_count