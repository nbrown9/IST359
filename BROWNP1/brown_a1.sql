-- IST359 Project 1
-- Author: Nicholas Brown

--1.1 Place Your Drop Statements Here (including procedure)


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'park_facilities')
	DROP TABLE park_facilities
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'facility_lookup')
	DROP TABLE facility_lookup
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'parks')
	DROP TABLE parks
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'park_class_lookup')
	DROP TABLE park_class_lookup
go


--1.2 CREATE TABLE: facility_lookup
CREATE TABLE facility_lookup (
	fac_code varchar(2) not null,
	fac_desc varchar(30) not null
)


go

-- 1.3 CREATE TABLE: park_class_lookup
CREATE TABLE park_class_lookup (
	pclookup_class_code varchar(3) not null,
	pclookup_class_desc varchar(50) not null UNIQUE
)

 go
 
-- 1.4 CREATE TABLE: parks
CREATE TABLE parks (
	park_id int identity(500,1) not null,
	park_name varchar(50) not null,
	park_street varchar(50) not null,
	park_acres dec(5,2) not null,
	park_ward int not null,
	park_class varchar(50),
	park_turf bit DEFAULT 0 not null,
	park_establish_date int not null,
	park_age AS YEAR(getdate()) - park_establish_date
)
 
go
 

-- 1.5 CREATE TABLE: park_facilities
CREATE TABLE park_facilities (
	pf_park_id int not null,
	pf_fac_code varchar(2) not null
)
 
go

-- Part 2: Add Table Constraints --


-- 2.1 ADD TABLE CONSTRAINTS: park_class_lookup
ALTER TABLE park_class_lookup
	ADD
		CONSTRAINT pk_pclookup_class_code
			PRIMARY KEY (pclookup_class_code) 
go

-- 2.2 ADD TABLE CONSTRAINTS: facility_lookup

ALTER TABLE facility_lookup
	ADD
		CONSTRAINT pk_fac_code
			PRIMARY KEY (fac_code)



-- 2.3 ADD TABLE CONSTRAINTS: parks
ALTER TABLE parks
	ADD
		CONSTRAINT pk_park_id
			PRIMARY KEY (park_id),
		CONSTRAINT ck_park_ward
			CHECK (park_ward between 1 and 50),
		CONSTRAINT ck_park_acres
			CHECK (park_acres > 0)
 
go

-- 2.4 ADD TABLE CONSTRAINTS: park_facilities
ALTER TABLE park_facilities
	ADD
		CONSTRAINT pk_park_fac_id
			PRIMARY KEY (pf_park_id,pf_fac_code)

go

  


-- Part 3: Add Foreign Key Constraints 


-- 3.1 ADD FOREIGN KEY CONSTRAINTS: parks
ALTER TABLE parks
	ADD
		CONSTRAINT fk_park_class
			FOREIGN KEY (park_class)
			REFERENCES park_class_lookup(pclookup_class_desc)
 
go
-- 3.2 ADD FOREIGN KEY CONSTRAINTS: park_facilities
ALTER TABLE park_facilities
	ADD
		CONSTRAINT fk_pf_park_id
			FOREIGN KEY (pf_park_id)
			REFERENCES parks(park_id),
		CONSTRAINT fk_pf_fac_code
			FOREIGN KEY (pf_fac_code)
			REFERENCES facility_lookup(fac_code)
go  
-- Part 5: Insert Base Data as shown in the assignment. Order is important. Do a table
-- at a time and place a go statement after each set of inserts. 

-- 5.1 Add Your First Table Rows Here
INSERT INTO facility_lookup (
	fac_code,
	fac_desc
	) 
	VALUES (
	'SC',
	'Senior Center' ),
	( 'SF',
	  'Spray Feature'),
	( 'P',
	  'Playground'),
	( 'W',
	  'Water'),
	( 'FC',
	  'Fitness Center'),
	( 'G',
	  'Gymnasium'),
	( 'BC',
	  'Boce Court'),
	( 'FS',
	  'Football/Soccer'),
	( 'PO',
	  'Pool (outdoor)'),
	( 'PI',
	  'Pool (indoor)'),
	( 'GT',
	  'Go-Cart Track'),
	( 'T',
	  'Tennis'),
	( 'HT',
	  'Hiking Trail')
go

-- SELECT * FROM facility_lookup

-- 5.2 Add Your Second Table Rows Here
INSERT INTO park_class_lookup (
	pclookup_class_code,
	pclookup_class_desc
	)
	VALUES (
	'COM',
	'COMMUNITY'),
	('NEI',
	 'NEIGHBORHOOD'),
	('MIN',
	 'MINI-PARK'),
	('COP',
	 'COMMUNITY PARK')

-- SELECT * FROM park_class_lookup
	
go

-- 5.3 Add Your Third Table Rows Here
INSERT INTO parks (
	park_name,
	park_street,
	park_acres,
	park_ward,
	park_class,
	park_turf,
	park_establish_date
	)
	VALUES (
	'ABBOT (ROBERT)',
	'49 E 95th St',
	22.74,
	6,
	'COMMUNITY',
	0,
	1947 ),
	(
	'ADAMS (GEORGE & ADELE)',
	'1919 N Seminary Ave',
	0.66,
	43,
	'NEIGHBORHOOD',
	0,
	1959 ),
	(
	'ARCHER (WILLIAM BEATTY)',
	'4901 S. Kilbourn Ave.',
	13.22,
	23,
	'MINI-PARK',
	0,
	1934 ),
	(
	'ARCHER (WILLIAM BEATTY)',
	'3309 S Shields Ave',
	8.22,
	11,
	'COMMUNITY PARK',
	1,
	1941 ),
	(
	'ARMSTRONG (LILLIAN HARDIN)',
	'4433 S St Lawrence Ave',
	8.6,
	6,
	'COMMUNITY PARK',
	0,
	1941 )
go

-- SELECT * FROM parks
-- 5.4 Add Your Fourth Table Rows Here

INSERT INTO park_facilities (
	pf_park_id,
	pf_fac_code
	) 
	VALUES (
	500,
	'SC'
	),
	(
	500,
	'SF'
	),
	(
	501,
	'P'
	),
	(
	501,
	'W'
	),
	(
	502,
	'FC'
	),
	(
	502,
	'G'
	),
	(
	502,
	'SF'
	),
	(
	502,
	'BC'
	),
	(
	503,
	'FS'
	),
	(
	503,
	'PI'
	),
	(
	503,
	'PO'
	),
	(
	503,
	'GT'
	),
	(504,
	'T'
	),
	(504,
	'HT'
	)
go

-- SELECT * FROM park_facilities

-- Part 6: Data Verification

-- 6.1 Query 1 goes here
-- Quick and dirty way of concatenating var chars into single row --
SELECT park_id, park_name, park_street, park_acres, park_ward, park_class, park_turf, park_establish_date, park_age, 
		STUFF((SELECT DISTINCT ', ' + fac_desc
		FROM facility_lookup, park_facilities
		WHERE facility_lookup.fac_code = park_facilities.pf_fac_code and park_facilities.pf_park_id = parks.park_id
		FOR XML PATH('')),1,1,'') AS facilities
	FROM parks
	JOIN park_facilities ON parks.park_id = park_facilities.pf_park_id
	JOIN facility_lookup ON park_facilities.pf_fac_code = facility_lookup.fac_code
	GROUP BY park_id, park_name, park_street, park_acres, park_ward, park_class, park_turf, park_establish_date, park_age
	ORDER BY park_id asc

GO

-- 6.2 Query 2 goes here
-- Use [] braces instead of AS because of space in column title names
SELECT park_ward as Ward, COUNT(park_name) [Num Parks], SUM(park_acres) [Total Acres] FROM parks
	GROUP BY park_ward

GO