SELECT avg(product_wholesale_price) as avg_wholesale, avg(product_retail_price) as avg_retail FROM fudgemart_products

SELECT employee_department, avg(employee_hourlywage) as average_hourly_wage FROM fudgemart_employees
	GROUP BY employee_department
	ORDER BY average_hourly_wage asc

SELECT vendor_id, vendor_name, avg(product_wholesale_price) as avg_wholesale, avg(product_retail_price) as avg_retail FROM fudgemart_products
	JOIN fudgemart_vendors ON vendor_id = product_vendor_id
	GROUP BY vendor_id, vendor_name

SELECT employee_jobtitle, employee_department, count(employee_jobtitle) as count_of_employees FROM fudgemart_employees
	WHERE employee_jobtitle = 'Sales Associate' and (select count(employee_jobtitle) from fudgemart_employees) > 1
	GROUP BY employee_jobtitle, employee_department
	ORDER BY count_of_employees asc

SELECT vendor_id, vendor_name, max(product_retail_price) as most_expensive_item, min(product_retail_price) as least_expensive_item FROM fudgemart_products
	JOIN fudgemart_vendors ON vendor_id = product_vendor_id
	GROUP BY vendor_id, vendor_name 
	ORDER BY vendor_id asc

SELECT month(timesheet_payrolldate) as timesheet_month, sum(employee_hourlywage * timesheet_hours) as total_pay FROM fudgemart_employee_timesheets
	JOIN fudgemart_employees ON timesheet_employee_id = employee_id
	WHERE year(timesheet_payrolldate)=2006
	GROUP BY month(timesheet_payrolldate)
	ORDER BY timesheet_month asc

SELECT vendor_id, vendor_name, count(product_vendor_id) as product_count FROM fudgemart_vendors
	LEFT JOIN fudgemart_products ON vendor_id = product_vendor_id
	GROUP BY vendor_id, vendor_name
	ORDER BY vendor_id asc

SELECT employee_firstname + ' ' + employee_lastname as employee_fullname, employee_jobtitle, employee_department, count(product_name) as product_count FROM fudgemart_employees
	LEFT JOIN fudgemart_products ON employee_department = product_department
	WHERE employee_jobtitle = 'Department Manager'
	GROUP BY employee_firstname, employee_lastname, employee_jobtitle, employee_department
	ORDER BY product_count asc