-- Nicholas Brown --
-- Pre Lab 6 --

-- 2.a --
create procedure p_fudgemart_add_product
(
	@product_department varchar(20),
	@product_name varchar(50),
	@product_retail_price money,
	@product_wholesale_price money,
	@product_vendor_id int
)
as
begin
	insert into fudgemart_products (
		product_department, product_name, product_retail_price, product_wholesale_price, product_is_active, product_add_date, product_vendor_id
	) values (
			@product_department, @product_name, @product_retail_price,
			@product_wholesale_price, 1, GETDATE(),
			@product_vendor_id
	)
	return @@identity
end

select ROUTINE_NAME, ROUTINE_TYPE, ROUTINE_DEFINITION
	from INFORMATION_SCHEMA.ROUTINES
	where ROUTINE_NAME = 'p_fudgemart_add_product'


-- 2.b --
execute p_fudgemart_add_product 'Hardware','Monkey-Wrench', 12.95, 6.95, 3

select top 1 * from fudgemart_products order by product_id desc


-- 2.c --

--dec
declare @product_id int
--exec
execute @product_id = p_fudgemart_add_product
							@product_name='Slot Screwdriver',
							@product_department='Hardware',
							@product_retail_price=6.95,
							@product_wholesale_price=3.95,
							@product_vendor_id=3

--select
select * from fudgemart_products where product_id=@product_id

--select
select * from fudgemart_products where product_department='Hardware'

go


-- 2.d --
create view v_fudgemart_display_active_products
as
select	product_id, product_name, product_department,product_wholesale_price, product_retail_price, vendor_id, vendor_name, vendor_website
	from fudgemart_products join fudgemart_vendors on vendor_id=product_vendor_id
	where product_is_active=1

go

--select
select TABLE_NAME, VIEW_DEFINITION
	from INFORMATION_SCHEMA.VIEWS
	where TABLE_NAME = 'v_fudgemart_display_active_products'

-- 2.e --
select vendor_name, product_name, product_wholesale_price, product_retail_price
	from v_fudgemart_display_active_products
	where product_department='Hardware'
	order by vendor_name, product_name

go
-- 2.f --
select LEN('mike') as expecting_a_4

go

--function
create function dbo.f_fudgemart_product_markup (
	@retail_price money,
	@wholesale_price money
)
returns money
as
begin
	return (@retail_price - @wholesale_price)
end

go

--select
select ROUTINE_NAME, ROUTINE_TYPE, ROUTINE_DEFINITION
	from INFORMATION_SCHEMA.ROUTINES
	where ROUTINE_NAME = 'f_fudgemart_product_markup'

go

-- 2.f continued --
select dbo.f_fudgemart_product_markup(10,9) as should_be_1

--select
select vendor_name, product_name, product_retail_price, product_wholesale_price,
		dbo.f_fudgemart_product_markup(product_retail_price, product_wholesale_price) as product_markup
	from v_fudgemart_display_active_products
	where product_department = 'Electronics' and vendor_name = 'Soney'
	order by product_name