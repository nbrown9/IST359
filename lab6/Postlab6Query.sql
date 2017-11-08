-- Nicholas Brown --
-- Post Lab 6 --

if exists(select 1 from sys.views where name='v_fudgemart_employee_managers' and type='v')
drop view v_fudgemart_employee_managers;

go
-- 3.a --

CREATE VIEW v_fudgemart_employee_managers
AS
SELECT *
	FROM fudgemart_employees
	WHERE employee_id IN (SELECT DISTINCT employee_supervisor_id FROM fudgemart_employees)

GO

-- Check to see its there --
SELECT TABLE_NAME, VIEW_DEFINITION
	FROM INFORMATION_SCHEMA.VIEWS
	WHERE TABLE_NAME = 'v_fudgemart_employee_managers'


-- 3.b --

SELECT employee_firstname, employee_lastname, employee_jobtitle, employee_department, employee_hourlywage
	FROM v_fudgemart_employee_managers
	WHERE employee_hourlywage > 19.00 AND NOT employee_jobtitle = 'CEO'

GO

-- 3.c --

CREATE PROCEDURE p_fudgemart_markup_retail_by_department (
	@department varchar(20),
	@amount money
) AS 
BEGIN
	UPDATE fudgemart_products
	SET product_retail_price = @amount+product_retail_price
	WHERE product_department = @department
END

GO

-- 3.d --

EXECUTE p_fudgemart_markup_retail_by_department 'Clothing', 2.50

GO

EXECUTE p_fudgemart_markup_retail_by_department 'Housewares', 3.75

GO

-- Check to see it worked --

SELECT product_department, product_name, product_retail_price FROM fudgemart_products
	WHERE product_department IN ('Clothing','Housewares')
	ORDER BY product_department, product_name

GO
-- 3.e --

CREATE PROCEDURE p_fudgemart_deactivate_product (
	@product_id int
) AS
BEGIN 
	UPDATE fudgemart_products
	SET product_is_active=0
	WHERE product_id=@product_id
END

GO

-- 3.f --

-- Find product ID's to deactivate --
SELECT * FROM fudgemart_products
	WHERE product_name IN ('Slot Screwdriver','Monkey-Wrench')

GO

-- DECLARE 

DECLARE @SlotScrewdriverID int
DECLARE @MonkeyWrenchID int

SET @SlotScrewdriverID = (SELECT product_id FROM fudgemart_products WHERE product_name='Slot Screwdriver')
SET @MonkeyWrenchID = (SELECT product_id FROM fudgemart_products WHERE product_name='Monkey-Wrench')

-- Deactivate product --
EXECUTE p_fudgemart_deactivate_product @SlotScrewdriverID
EXECUTE p_fudgemart_deactivate_product @MonkeyWrenchID

GO

-- 3.g --

SELECT product_name, product_department FROM v_fudgemart_display_active_products
	WHERE product_department='Hardware'

GO

-- 3.h --

CREATE FUNCTION dbo.f_fudgemart_vendor_product_count (
	@vendor_id int
) 
RETURNS int
AS
BEGIN 
	RETURN(SELECT COUNT(product_id) FROM fudgemart_products WHERE product_vendor_id=@vendor_id)
END

GO

-- 3.i --

CREATE VIEW v_fudgemart_vendors
AS
	SELECT *, dbo.f_fudgemart_vendor_product_count (vendor_id) as vendor_product_count FROM fudgemart_vendors
GO


-- 3.j --

SELECT * FROM v_fudgemart_vendors
	WHERE vendor_product_count < 5
