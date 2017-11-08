-- Pre-lab 7 --
-- Nicholas Brown --

set implicit_transactions off

select @@OPTIONS & 2
go

-- drop procedure --
DROP PROCEDURE p_add_two_colors
GO

-- Procedure --
create procedure p_add_two_colors (
	@color1 varchar(20),
	@color2 varchar(20)
)	as
begin
	declare @rc1 int
	declare @rc2 int

	begin transaction

	insert into colors values (@color1)
	set @rc1 = @@ROWCOUNT

	insert into colors values (@color2)
	set @rc2 = @@ROWCOUNT

	if (@rc1 = 1 and @rc2 = 1)
	begin
		commit
		return 2
	end
	else
	begin
		rollback
		return 0
	end
end
go

-- Execute --
execute p_add_two_colors 'black','white'
execute p_add_two_colors 'grey','black'

execute p_add_two_colors 'blue','purple'
execute p_add_two_colors 'teal','pink'
-- Select --
select * from colors

select COUNT(color_name) as color_count from colors