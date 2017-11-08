-- Place Your Name Here or lose 5 PTS!
-- Author: Nicholas Brown

-- Q1 All Table and Procedure Drops Go Here
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'driver_vehicles')
	DROP TABLE driver_vehicles 
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'drivers')
	DROP TABLE drivers
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'vehicles')
	DROP TABLE vehicles
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'p_ny_driver_raise')
	DROP PROCEDURE p_ny_driver_raise
 go

-- In Q2-Q4 you will create your tables. Do not build constraints in this section

-- Q2 CREATE TABLE: vehicles  
CREATE TABLE vehicles (
	veh_lic_plate varchar(8) not null,
	veh_make varchar(25) not null,
	veh_model varchar(25) not null
)
go
 
-- Q3 CREATE TABLE:  driver_vehicles  
CREATE TABLE driver_vehicles (
	dv_drive_id int not null,
	dv_lic_plate varchar(8) not null
)
go
 
-- Q4 CREATE TABLE: drivers  
CREATE TABLE drivers (
	driver_id int identity(10,5) not null,
	driver_name varchar(25) not null,
	driver_lic_expiration_date date not null,
	driver_lic_state char(2) not null,
	driver_day_rate money not null
)
go

 
-- In Q5-Q7 you will create your table constraints.  
-- Q5 ADD Primary Key Constraint: drivers  
ALTER TABLE drivers
	ADD
		CONSTRAINT pk_driver
			PRIMARY KEY(driver_id)        
go
 
-- Q6 ADD Primary Key Constraint: vehicles  
ALTER TABLE vehicles
	ADD
		CONSTRAINT pk_vehicles
			PRIMARY KEY(veh_lic_plate) 
go
 
-- Q7 ADD PK, Foreign Key CONSTRAINTS: driver_vehicles  
ALTER TABLE driver_vehicles
	ADD
		CONSTRAINT pk_driver_vehicle    
			PRIMARY KEY(dv_drive_id, dv_lic_plate),
		CONSTRAINT fk_dv_drive_id
			FOREIGN KEY (dv_drive_id)
			REFERENCES drivers(driver_id),
		CONSTRAINT fk_dv_lic_plate
			FOREIGN KEY (dv_lic_plate)
			REFERENCES vehicles(veh_lic_plate)
go

-- In Q8-Q10 we will add data to our tables using various methods  

-- Q8 Add data to vehicles table.  
 INSERT INTO vehicles
           (veh_lic_plate, veh_make, veh_model)
   VALUES  ('SYR555','BMW','S3'),
           ('NY123','Audi','Q5'),
		   ('SU44','Toyota','Rav4')
go


 
-- Q9 Add data to drivers table.  
INSERT INTO drivers
	(driver_name, driver_lic_expiration_date, driver_lic_state, driver_day_rate)
	VALUES ('Smith,Ted','12/31/2020','NY',$100.00),
		   ('Nosky,Deb','7/7/2018','PA',$200.00),
		   ('Tang,Max','9/1/2019','NY',$300.00),
		   ('Lee,Pedro','5/15/2020','FL',$400.00)      
       
go


--Q10  Add data to driver_vehicles table. Wow, looks like it is almost done!!!!
Insert into driver_vehicles
           (dv_drive_id, dv_lic_plate)
   VALUES  (10, 'SYR555'),
           (10, 'NY123'),
		   (15, 'NY123'),
           (20, 'NY123'),
           (20, 'SYR555'),
		   (25, 'SU44')

go


-- In Q11-Q12 we will create and execute a procedure


-- Q11 NY License Raise Procedure Goes Here
CREATE PROCEDURE p_ny_driver_raise
(
	@increase_amount money
)
AS
	BEGIN
		UPDATE drivers
		SET driver_day_rate = driver_day_rate+@increase_amount
		WHERE driver_lic_state = 'NY'
	END
go	   
-- Q12 Run your new proedure here to give NY State Drivers a $50 raise.
EXECUTE p_ny_driver_raise $50.00        
 
go

--Q13-Q14 Data Validation. Be sure to see result set in printed exam. 
  
--Q13 Let's look at everything to see if it is loaded correctly 
SELECT driver_id, driver_name, driver_day_rate, driver_lic_state, veh_lic_plate, veh_make, veh_model, driver_lic_expiration_date FROM drivers
	JOIN driver_vehicles ON drivers.driver_id = driver_vehicles.dv_drive_id
	JOIN vehicles ON driver_vehicles.dv_lic_plate = vehicles.veh_lic_plate
	ORDER BY driver_id asc
 go  

--Q14 So what's the lowest and highest day rates we are paying drivers?
SELECT MIN(driver_day_rate) as 'Lowest Rate', MAX(driver_day_rate) as 'Most We Pay' FROM drivers

go    
    

	
	
	

       