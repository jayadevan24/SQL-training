﻿--command to create a database
CREATE DATABASE employee_db;


--list all databases in MSSQL server
--run the following stores procedure
SELECT name FROM master.sys.databases ORDER BY name;

--switch  to another database using the USE command
USE employee_db2;


--To know which database we are currently poinying to
SELECT db_name();

--to backup a database so that we can transfer it to another computer or server

BACKUP DATABASE employee_db TO DISK = 'C:\SQL QUery1\employee_db.bak';

--trying to restore already backed up database into the server
RESTORE DATABASE employee_db FROM DISK = 'C:\SQL QUery1\employee_db.bak';

--to delete a database
--to delete a database,we need to switvh to another database
--then execute the DROP command on the db you want to delete
USE employee_db;
DROP DATABASE employee_db2;

--CREATING A NEW TABLE INSIDE A employee_db

USE employee_db
CREATE TABLE EMP_DEtails1(id INT IDENTITY PRIMARY KEY,name varchar(50),age SMALLINT,location varchar(50));

--ALTERING A TABLE

alter table EMP_DEtails1 add dob date;
alter table EMP_DEtails1 add testcolumn int;

--stored pr0cedure to vuew the schema of the table

exec sp_HELP EMP_DEtails1;

--altering table to change an exixsting column properties
alter table EMP_DEtails1 add testcolumn int;

--dropping an existing colums

alter table EMP_DEtails1 drop column testcolumn ;

--INSERTING VALUE INTO THE TABLE

INSERT INTO EMP_DEtails1 (name,age,location,dob) VALUES ('dasan',67,'India','2016-3-16'),('shiv',78,'USA','2018-2-25');

--view from table
select * from EMP_DEtails1;

--only insert to some column
INSERT INTO EMP_DEtails1 (name,age) VALUES ('sdkj',77),('shiofwiv',38);

--UPDATING THE TABLE

UPDATE EMP_DEtails1 SET name='yash' WHERE name ='dasan';

--DELETING THE A ROW

DELETE FROM EMP_DEtails1 WHERE name='shiv';

--to celar all the data from the table , preserving the tables tructure

TRUNCATE TABLE EMP_DEtails1;

select * from EMP_DEtails1;

--DELETE THE TABLE 

DROP TABLE EMP_DEtails1;


--CHECK THE CURRENT SCHEMA

SELECT SCHEMA_NAME();

--TO CREATE CUSTOM SCHEMA

CREATE SCHEMA myschema1;

--TO CREATE A TABLE UNDER THE NEW SCHEMA

CREATE TABLE EMPLOYEE_DB.myschema1.EMP_DEtails2(id INT IDENTITY PRIMARY KEY,name varchar(50),age SMALLINT,location varchar(50));


--ALTER SCHEMA COMMAND TO ADD OR REMOVE OBJECTS(TABLES) TO A SCHEMA 
ALTER SCHEMA myschema1 TRANSFER OBJECT :: dbo.employees;

--CHANGE THE SCHEMA BACK TO DBO
ALTER SCHEMA dbo TRANSFER OBJECT :: myschema1.employees;

ALTER SCHEMA dbo TRANSFER OBJECT :: myschema1.EMP_DEtails2;
ALTER SCHEMA dbo TRANSFER OBJECT :: myschema1.schema_example;


--TO DROP SCHEMA,MAKE SURE NO OBJECTS ARE UNDER THE SCHEMA

DROP SCHEMA IF EXISTS myschema1;

USE Northwind;
--BASIC CLAUSES

--DISTCINCT GIVE THE NON DUPLICATES ELEMENTS FROM A COLUMN

SELECT * FROM Customers;

SELECT DISTINCT CITY FROM Customers;

SELECT DISTINCT CITY,Region FROM Customers;

--the distinct is only for city , it i not applicable for region

SELECT DISTINCT CITY,Region,Country FROM Customers WHERE Country='uk';

SELECT  CITY,Region,Country FROM Customers WHERE Country='uk';

--GROUP BY CALUSE
--GROUPS ROWS THAT HAS SAME VALUES INTO TEMP ROWS,MOSTLY USEDD ALONG AGG FUN.

SELECT COUNT(CUSTOMERID) AS 'NO OF CUSTOMERS',Country FROM Customers GROUP BY Country;

SELECT COUNT(CUSTOMERID) AS 'NO OF CUSTOMERS',Country FROM Customers GROUP BY Country ORDER BY 'NO OF CUSTOMERS ';
SELECT COUNT(CUSTOMERID) AS 'NO OF CUSTOMERS',Country FROM Customers GROUP BY Country ORDER BY COUNT(CUSTOMERID);
SELECT COUNT(CUSTOMERID) AS 'NO OF CUSTOMERS',Country FROM Customers GROUP BY Country ORDER BY COUNT(CUSTOMERID) DESC;


--WHERE CALUSE
--CAN BE USED WITH UPDATE AND DELETE
--=OPERATOR

SELECT * FROM Suppliers;

SELECT CompanyName,City FROM Suppliers WHERE Country='USA' ORDER BY CompanyName;
SELECT CompanyName,City,ContactTitle FROM Suppliers WHERE ContactTitle LIKE 'SALES%' ORDER BY CompanyName;
SELECT CompanyName,City,ContactTitle FROM Suppliers WHERE ContactTitle LIKE '%MANAGER' ORDER BY CompanyName;


SELECT CompanyName,City,Country FROM Suppliers WHERE Country LIKE 'NOR%' ORDER BY CompanyName;
--LIKE CAN BE USED WITH %,_ ETC FOR ONLY STRING

SELECT * FROM Employees;

SELECT * FROM Employees WHERE EmployeeID BETWEEN 1 AND 7;

--ORDER BY
--BY DEFAULT IN ASCENDING , FOR GETTING IN DESCENDING GIVE 'DESC'

SELECT CompanyName,City,ContactTitle FROM Suppliers WHERE ContactTitle LIKE '%MANAGER' ORDER BY SupplierID DESC;


SELECT CompanyName,City,ContactTitle,SupplierID FROM Suppliers ORDER BY SupplierID DESC;
SELECT CompanyName,City,ContactTitle,SupplierID FROM Suppliers ORDER BY SupplierID DESC,CITY ASC;

--FIRST IT SORTS IN THE FIRST COMMAND FROM LEFT, THEN IF 2 HAS SAME VALUE IN THE FORST ONE, THEN THE SECOND SORT OCCURS INSIDE

SELECT COMPANYNAME,COUNTRY FROM CUSTOMERS ORDER BY Country;
SELECT COMPANYNAME,COUNTRY FROM CUSTOMERS ORDER BY Country ASC,CompanyName ASC;
SELECT COMPANYNAME,COUNTRY FROM CUSTOMERS ORDER BY Country ASC,CompanyName DESC;


SELECT FIRSTNAME,BIRTHDATE FROM Employees ORDER BY BirthDate DESC;

--HAVING CLAUSE
--WE CANT USE AGG FUN(min,max,count) WITH 'WHERE' SO INSTEAD WE USE HAVING
--SHOULD BE USED WITH GROUP BY CLAUSE
SELECT PRODUCTNAME,UnitPrice FROM Products GROUP BY ProductName, UnitPrice HAVING AVG(UnitPrice)>20;
SELECT AVG(UNITPRICE) FROM PRODUCTS;
SELECT PRODUCTNAME ,UNITPRICE FROM PRODUCTS ORDER BY UnitPrice,ProductName;

--SELECT CLAUSE
SELECT 1+1;

SELECT CONCAT(LASTNAME,' ',FIRSTNAME) AS ' FULL NAMES' FROM Employees;

--GROUPING SETS
--CREATE A  SAMPLE TABLE

USE employee_db

GO

CREATE TABLE EmployeeMaster (        
                  ID INT IDENTITY PRIMARY KEY,
				  EMPLOYEECODE VARCHAR(10),
				  EMPLOYEENAME VARCHAR(20),
				  DEPTCODE VARCHAR(10),
				  LOCATIONCODE VARCHAR(10),
				  SALARY INT
);

INSERT INTO EmployeeMaster VALUES ( 'E001','SUSMIN','IT','TVM','4000'),
                               ( 'E002','AKASH','IT','TVM','4000'),
							   ( 'E003','DEVIKA','QA','KLM','3000'),
							   ( 'E004','ARUNIMA','QA','KLM','3000'),
							   ( 'E005','MEENKASHI','HR','TVM','5000'),
                               ( 'E006','KEERTHANA','HR','KTM','5000'),
							   ( 'E007','PRETHI','HR','KTM','5000'),
							   ( 'E008','SANJU','IT','TVM','4000'),
							   ( 'E009','JAYADEVAN','QA','TVM','3000');

SELECT * FROM EmployeeMaster;

--USING GROUPING SET CLAUSE TRYINGNTO GET THE DATA
--LIST TO TOTAL COAST BY EACH EMPLOYEE
--GET TOTAL COST BY DEPT
--GET TOTAL COST BY DEPT BY LOCATION
--GET THE TOTAL COST TO THE COMPANY FOR ALL DEPARTMENT

SELECT EMPLOYEECODE,EMPLOYEENAME,DEPTCODE,LOCATIONCODE,SUM(SALARY) AS TOTALCOST FROM EmployeeMaster 
 GROUP BY
     GROUPING SETS ( (EMPLOYEECODE,EMPLOYEENAME,DEPTCODE,LOCATIONCODE),--THINGSREQ TO CALCULATE THE REST OF SETS
	                (EMPLOYEECODE,EMPLOYEENAME),
	               (DEPTCODE),--TOTAL COST FOR EACH DEPT
				   (LOCATIONCODE),--TOTAL COST FRO EACH LOCATION 
				   ()--TOTAL COST TO COMPANY
	 );

--BASIC OPERATORS

SELECT * FROM EmployeeMaster WHERE SALARY=3000;
SELECT * FROM EmployeeMaster WHERE SALARY>3000;
SELECT * FROM EmployeeMaster WHERE SALARY<=3000;
SELECT * FROM EmployeeMaster WHERE SALARY>=3000;
SELECT * FROM EmployeeMaster WHERE SALARY!>3000;
SELECT * FROM EmployeeMaster WHERE SALARY!<3000;

--IN AND NOT

SELECT * FROM EmployeeMaster WHERE SALARY IN(3000,5000);
SELECT * FROM EmployeeMaster WHERE SALARY NOT IN(3000,5000);
SELECT * FROM EmployeeMaster WHERE SALARY =5000 OR SALARY=4000 ;

SELECT * FROM EmployeeMaster WHERE EMPLOYEENAME IN('SANJU','AKASH');

SELECT * FROM EmployeeMaster WHERE SALARY BETWEEN 3000 AND 5000;

SELECT * FROM EmployeeMaster WHERE SALARY IS NULL;
SELECT * FROM EmployeeMaster WHERE SALARY IS NOT NULL;

--WILDCARD SEARCH

SELECT * FROM EmployeeMaster WHERE EMPLOYEENAME LIKE 'SAN%';

SELECT * FROM EmployeeMaster WHERE EMPLOYEENAME NOT LIKE '%UN%';

SELECT * FROM EmployeeMaster WHERE EMPLOYEENAME LIKE '%A';

SELECT * FROM EmployeeMaster WHERE EMPLOYEENAME LIKE '%KA%';

SELECT * FROM EmployeeMaster WHERE EMPLOYEENAME LIKE 'SAN%';

SELECT * FROM EmployeeMaster;

--USE[] TO MATCH ANY CHAR INSIDE IT SEPERATED BY COMMAS

SELECT * FROM EmployeeMaster WHERE EMPLOYEENAME LIKE 'SAN[JUY]U';

SELECT * FROM EmployeeMaster WHERE EMPLOYEENAME LIKE 'SAN[^UY]U';

SELECT * FROM EmployeeMaster WHERE EMPLOYEENAME NOT LIKE 'SAN[JUY]';

--EXISTS OPERATOR


SELECT * FROM EMPLOYEEMASTER WHERE EXISTS (SELECT * FROM EMPLOYEEMASTER WHERE EMPLOYEENAME LIKE 'KEERTHANA');

--UNION AND INTERSECTION
--CREATE ONE MORE TABLE TO DEMONSTRATE UNION AND INTERSECTION



CREATE TABLE EmployeeMaster (        
                  ID INT IDENTITY PRIMARY KEY,
				  EMPLOYEECODE VARCHAR(10),
				  EMPLOYEENAME VARCHAR(20),
				  DEPTCODE VARCHAR(10),
				  LOCATIONCODE VARCHAR(10),
				  SALARY INT
);
--INSERT DATA WITH COMMAN NAMES AND VALUES

INSERT INTO EmployeeMaster2 VALUES ( 'E001','SUSMIN','IT','TVM','4000'),
                               ( 'E002','AKASH','IT','TVM','4000'),
							   ( 'E003','ANU','QA','KLM','3000'),
							   ( 'E004','MANU','QA','KLM','3000'),
							   ( 'E005','SINU','HR','TVM','5000'),
                               ( 'E006','BINU','HR','KTM','5000'),
							   ( 'E007','TINU','HR','KTM','5000');

--UNION OPERATOR

SELECT * FROM EMPLOYEEMASTER UNION SELECT * FROM EMPLOYEEMASTER2;

SELECT * FROM EMPLOYEEMASTER WHERE SALARY >4000 UNION SELECT * FROM EMPLOYEEMASTER2;

SELECT * FROM EMPLOYEEMASTER WHERE SALARY >4000 UNION SELECT * FROM EMPLOYEEMASTER2 WHERE SALARY>3000;

--INTERSECT-GIVES THE COMMAN OPERATORS

SELECT * FROM EMPLOYEEMASTER  INTERSECT SELECT * FROM EMPLOYEEMASTER2;

SELECT * FROM EMPLOYEEMASTER WHERE SALARY >3000 UNION SELECT * FROM EMPLOYEEMASTER2;




--CREATE  A TAL FOR POPULAR DATA TYPES
CREATE TABLE data_types_eg(
bit_col BIT,
char_col char(3)
date_col date,
date_time_col datetime2(3),
date_time_offset_col datetimeoffset(2),
dec_col decimal(4,2),
num_col numeric(4,2),
bigint_col bigint,
in_col int,
samllint_col smallint,
tinyint_col tinyint
nvarchar_col nvarchar(10),
time_col time(0),
varchar_col(10)

);

INSERT INTO data_types_eg values(
1,
'ABC',
'2024-07-22',
'2024-07-22 02:51:00',
'2024-07-22 02:51:00 +05:30',
10.25,
23.56,
5151545454545454545115,
543564654654,
56238,
230,
N'സുഖമാണോ',
N'സുഖമാണോ123',
'02:51:00',
'gOOD'
);

--SAL CONSTRAINTS.
--PRIMARY KEY,FOREIGN KEY CONSTRAINT

CREATE TABLE usage_logs(
logid int not null identity primary key,
MESSAHE CHAR(255) NOT NULL,
);

--REMOVED THE PRIMARY KEY USING OBJECT ECPLORER
--ONCE AGAIN SET PRIMARY KEY FOR A A;READY EXISTIN GTABLE USING ALTER TABLE
--

ALTER TABLE USAGE_LOGS ADD CONSTRAINT 
LOGID_PK PRIMARY KEY (logid);

--TO FIND THE CONSTRAINT INDEX NAME USING A STORED PROCEDURE 

EXEC SP_HELP usage_logs;

--disable primary key
ALTER INDEX LOGID_PK on usage_logs disable;

--reenable primary key 
ALTER INDEX LOGID_PK on usage_logs rebuild;

--drop the primary key permanantly(here also we need the index name)

alter table usage_logs drop constraint logid_pk;


--foreign key
--creating two tables to demonstrate foreign key
-- create a product table from which we will use productid as primary key

create table myproducts(
product_id int not null IDENTITY PRIMARY KEY,
PRODUCT_NAME VARCHAR(50) NOT NULL,
CATEGORY VARCHAR(25)
);

--CREATE A INVENTORY TABLE WITH FOREIGN KEY REFFERING TI PRODUCT ID OF THE PRPDUCT TABLE(PARENT TABLE)

CREATE TABLE INVENTORY (
INVENTORY_ID  INT NOT NULL PRIMARY KEY,
MYPRODUCT_ID INT NOT NULL,--FOREIGN KEY
QUANTITY INT,
MIN_LEVEL INT,
MAX_LEVEL INT,
CONSTRAINT FK_PRODUCTID FOREIGN KEY (MYPRODUCT_ID) REFERENCES myproducts(product_id)
);

EXEC SP_HELP INVENTORY;


--DISABLING FOREIGN KEY
--SO THAT FOREIGN KEY EILL OT BE CHECKED WHILE SAVING

alter TABLE INVENTORY NOCHECK constraint FK_PRODUCTID;

--RO RENEW A FOREIGN KY

ALTER TABLE INVENTORY CHECK CONSTRAINT FK_PRODUCTID;


-- TO DROP A FOREIGN KEY
ALTER TABLE INVENTORY DROP CONSTRAINT FK_PRODUCTID;


--NOT NULL CONSTRAINT
--INCLUDING A NOT NULL DURING TABLE CREATION

CREATE TABLE usage_logs (
LOGID INT NOT NULL,
MESSAGE VARCHAR(25)
);

INSERT INTO usage_logs VALUES (1,'TEST MESSAGE1');
INSERT INTO usage_logs VALUES (2,'TEST MESSAGE2');
INSERT INTO usage_logs VALUES (3,'TEST MESSAGE3');
SELECT * FROM usage_logs;
INSERT INTO usage_logs VALUES (NULL,'TEST MESSAGE2');--ERROR

--REMOVE THE NOT NULL CONSTRAINT USING ALTER TABLE

ALTER TABLE usage_logs ALTER COLUMN LOGID INT null;

--REENABLE NOT NULL
ALTER TABLE usage_logs ALTER COLUMN LOGID INT NOT NULL;

--LETS DROP USAGE LOGS
DROP TABLE usage_logs;

--UNIQUE CONSTRAINT ENSURES ALL VAKUES ENSURED ARE UNIQUE

CREATE TABLE USAGE_LOGS(LOGID INT UNIQUE,
                         MESSAGE VARCHAR(25));


INSERT INTO usage_logs VALUES (1,'TEST MESSAGE1');
INSERT INTO usage_logs VALUES (2,'TEST MESSAGE2');
INSERT INTO usage_logs VALUES (3,'TEST MESSAGE3');
INSERT INTO usage_logs VALUES (NULL,'TEST 4');-- WILL WORK, ONLY ACCEPST ONE NULL
INSERT INTO usage_logs VALUES (NULL,'TEST5');
INSERT INTO usage_logs VALUES (2,'TEST MESSAG89');--ERROR

SELECT * FROM usage_logs;

--TO ALTER A UNIQUE KEY, WE NEED THE INDEX KEY NAME/CONSTRAINT NAME

EXEC SP_HELP usage_logs;-- TO GET THE NAME OF THE INDEX OF UNIQUE KEY

--DROP THE UNIQUE CONSTRAINT WILL NEED A CONSTRAINT NAME 

ALTER TABLE usage_logs DROP CONSTRAINT UQ__USAGE_LO__E39E279F529252E6;

--ADD THE UNIQUE CONSTRAING TI AN EXIXTIBG TABLE

ALTER TABLE usage_logs ADD CONSTRAINT UNIQUE_LOGID UNIQUE (LOGID);

EXEC SP_HELP usage_logs;

ALTER TABLE usage_logS DROP CONSTRAINT UNIQUE_LOGID;

DROP TABLE USAGE_LOGS;

--CHECK CONDITION TO RESTRICT THE ENTRY DATA OF SIENTIST

CREATE TABLE USAGE_LOGS(LOGID INT UNIQUE NOT NULL CHECK(LOGID>10),
                         MESSAGE VARCHAR(25));

						 
INSERT INTO USAGE_LOGS VALUES(55,'WOJJROJRJOFRJFOJ');
INSERT INTO usage_logs VALUES (2,'TEST MESSAGE2');
INSERT INTO usage_logs VALUES (3,'TEST MESSAGE3');
INSERT INTO usage_logs VALUES (NULL,'TEST 4');-- WILL WORK, ONLY ACCEPST ONE NULL
INSERT INTO usage_logs VALUES (NULL,'TEST5');
INSERT INTO usage_logs VALUES (2,'TEST MESSAG89');--ERROR

EXEC SP_HELP usage_logs;


ALTER TABLE USAGE_LOGS DROP CONSTRAINT CK__USAGE_LOG__LOGID__73BA3083;

--DEFAULT CONDITION--PUTS A DEFAULT VALUE IN THE POSITION IF THE USER D

DROP TABLE USAGE_LOGS;

CREATE TABLE USAGE( )

T]-- TO CHECK G


ALTER TABLE TSABAGE ADD CONSNSTRAIN
DEF_MESSAGE DB_

ALTER TABLE USAGE


--TO GET TODAYS DATE USE GETDATE()

CREATE TABLE USAE_LOGS(
LOGID int NOT NULL UNIQUE,
MESSAGE CHAR(255),
MSGDATE DATETIME NOT NULL DEFAULT GETDATE()

);



--ASCCI,CHARINDEX,CONCAT

SELECT ASCII('A');
select

--SOUNDEX(),DIFFERENCE ,LEFt(),RIGHT()

SELECT SOUNDX('TEXT');

SELECT ASCII('B');

SELECT CHARINDEX('WORLD','HELLON WORLD');

SELECT CONCAT('HELLO','-','WORLD');

SELECT LEFT('HELLO WORLD',5);

SELECT RIGHT('HELLO WORLD',5);

SELECT RIGHT('HELLO WORLD',2);

SELECT LOWER('HELLO');
SELECT UPPER('HELLO');

SELECT REPLICATE('HELLO',4);


--Date functions

select CURRENT_TIMESTAMP;--GET THE CURRENT SYSTEM TIME STAMP YY-MM-DD HH-MM-SS-MS
select GETDATE();--SAME THING AS ABOVE


SELECT GETUTCDATE();--GET THE GMT UNIVERSAL TIME

SELECT SYSDATETIME();--MORE PRECISION

SELECT DATENAME(DAY,'2024/7/23');

SELECT DATENAME(MONTH,'2024/7/23');--GET

SELECT DATENAME(YEAR,'2024/7/23');--GET YEAR

SELECT DAY('2024/7/23');
SELECT MONTH('2024/7/23');
SELECT YEAR('2024/7/23');

SELECT DATEDIFF(DD,'2024/7/18','2024/07/23');
SELECT DATEDIFF(MM,'2024/7/18','2024/07/23');

SELECT DATEDIFF(WK,'2024/7/18','2024/07/23');

--MATHEMATICAL FUNCTIONS

SELECT SQRT(25);

SELECT ABS(-34);

SELECT CEILING(34.2);--NEXT HIGHEST VAL

SELECT FLOOR(34.2);--PREVIOUS MIN VALUE

SELECT SIGN(34.2);

SELECT POWER(3,2);

SELECT LOG(25);





--CONVERSTION FUNCTIONS

--"CONVERT(DATA_TYPE,EXPR,LENGTH);"

SELECT CONVERT(INT , 35.256);-- CONVTING A FLOAT TO AN INTEGER
SELECT CONVERT(INT , 35.858);

SELECT CONVERT(datetime,'2024/7/23')

SELECT CONVERT(varchar,'2024/7/23',100);

SELECT CAST(35.56 AS INT);

SELECT CAST('2024/7/23' AS datetime);



--JOINS

CREATE DATABASE TRAINING;
USE TRAINING;

CREATE TABLE TRAINEE(
ID INT PRIMARY KEY IDENTITY,
ADMISSIONNO VARCHAR(50) NOT NULL,
FIRSTNAME VARCHAR(50) NOT NULL,
LASTNAME VARCHAR(50) NOT NULL,
AGE INT,
CITY VARCHAR(30) NOT NULL
);

CREATE TABLE FEE(
ADMISSIONNO VARCHAR(50) NOT NULL,
SEMNO INT NOT NULL,
COURSE VARCHAR(50) NOT NULL,
AMOUNT INT
);

CREATE TABLE SEMESTER(
SEMNO INT NOT NULL,
SEMNAME VARCHAR(50));

INSERT INTO TRAINEE VALUES
('3354','SPIDER','MAN',13,'TEXAS'),
('2135','JAMES','BOND',15,'ALASKA'),
('4321','JACK','SPARORW',14,'CALIFORNIA'),
('4213','JOHN','McLANE',17,'NEW YORK'),
('5112','OPTIMUS','PRIME',16,'FLORIDA'),
('6113','CAPTAIN','KIRK',15,'ARIZONA'),
('7555','HARRY','POTTER',14,'NEW YORK'),
('8345','ROSE','DAWSON',13,'CALIFORNIA');

SELECT * FROM TRAINEE;

INSERT INTO SEMESTER VALUES 
(1,'FIRST SEM'),
(2,'SECOND SEM'),
(3,'THIRD SEM'),
(4,'FOURTH SEM');

SELECT * FROM SEMESTER;

INSERT INTO FEE VALUES
(3354,1,'JAVA',20000),
(7555,1,'ANDROID',22000),
(4321,2,'PYTHON',18000),
(8345,2,'SQL',15000),
(9345,2,'BLOCK CHAIN',16000),
(9321,3,'ETHICAL HACKING',17000),
(5112,1,'MACHINE LEARNING',30000);

SELECT * FROM FEE;

--MS SQL JOINS
--INNER JOIN
--RETURNS THE ONLY THE ROWA THAT HAVE THE MATCHING FIELD.

--INNER JOINING 2 TABLES
SELECT TRAINEE.ADMISSIONNO,TRAINEE.FIRSTNAME,TRAINEE.LASTNAME,FEE.COURSE,FEE.AMOUNT FROM 
TRAINEE INNER JOIN FEE
ON TRAINEE.ADMISSIONNO=FEE.ADMISSIONNO;


--INNER JOINING 3 TABLES
SELECT TRAINEE.ADMISSIONNO,TRAINEE.FIRSTNAME,TRAINEE.LASTNAME,FEE.COURSE,FEE.AMOUNT,SEMESTER.SEMNAME FROM 
(TRAINEE INNER JOIN FEE--INNER JOIN WITH A TABLE
ON TRAINEE.ADMISSIONNO=FEE.ADMISSIONNO )
INNER JOIN SEMESTER ON SEMESTER.SEMNO=FEE.SEMNO;--INNER JOINING WITH 3RD

--LEFT OUTER JOIN



--LEFT OUTER JOINING 2 TABLES
SELECT TRAINEE.ADMISSIONNO,TRAINEE.FIRSTNAME,TRAINEE.LASTNAME,FEE.COURSE,FEE.AMOUNT FROM 
TRAINEE LEFT OUTER JOIN FEE
ON TRAINEE.ADMISSIONNO=FEE.ADMISSIONNO;


--RIGHT OUTER JOINING 2 TABLES
SELECT TRAINEE.ADMISSIONNO,TRAINEE.FIRSTNAME,TRAINEE.LASTNAME,FEE.COURSE,FEE.AMOUNT FROM 
TRAINEE RIGHT OUTER JOIN FEE
ON TRAINEE.ADMISSIONNO=FEE.ADMISSIONNO;

--FULL OUTER JOINING 2 TABLES
SELECT TRAINEE.ADMISSIONNO,TRAINEE.FIRSTNAME,TRAINEE.LASTNAME,FEE.COURSE,FEE.AMOUNT FROM 
TRAINEE FULL OUTER JOIN FEE
ON TRAINEE.ADMISSIONNO=FEE.ADMISSIONNO;

--SELF JOIN-CONSIDER A SINGLE TABLE WITH 2 ALIAS NAMES AS TWO TABLES AND DO JOIN

SELECT T1.FIRSTNAME,T1.LASTNAME,T2.CITY 
FROM TRAINEE T1,TRAINEE T2 
WHERE T1.ADMISSIONNO=T2.ADMISSIONNO 
AND T1.CITY=T2.CITY 
ORDER BY T2.CITY;

--CROSS JOIN-THE CARTISIAN PRODUCT OF 2 TABLES

SELECT * FROM TRAINEE CROSS JOIN FEE;

SELECT * FROM FEE CROSS JOIN TRAINEE;

SELECT * FROM TRAINEE CROSS JOIN TRAINEE;


--STORED PROCEDURE--SET OF PRE COMPILED SQL STATEMENTS IDENTIFIED BY A NAME

CREATE PROCEDURE TRAINEEAGEWISELIST
AS BEGIN
     SELECT FIRSTNAME,AGE,CITY 
	 FROM TRAINEE
	 ORDER BY AGE;
END;

--CALL THE STORED PROCEDURE 

EXEC TRAINEEAGEWISELIST;


SELECT * FROM SYS.procedures;

--TO DELETE A STORED PROCEDURE

DROP PROCEDURE TRAINEEAGEWISELIST;

--PASSING PARAPETERS IN STORED PROCEDURE

CREATE PROCEDURE SPGETTRAINEESROMCITY(@CITY VARCHAR(50))
AS BEGIN
        SET NOCOUNT ON;--SET TO ON ,SO DBMS WILL NOT GIVE BACK AFFECTED ROW
		SELECT FIRSTNAME,LASTNAME,AGE,CITY FROM TRAINEE WHERE CITY=@CITY;
END;

EXEC SPGETTRAINEESROMCITY 'TEXAS';
EXEC SPGETTRAINEESROMCITY 'CALIFORNIA';

--GETING DATA FROM THE STORED PROCEDURE
--CREATE A STORED PROCEDURE WITH A VARIALBLE NAE TO SEND THE OUTPUT AND KEYWORD OUTPUT

CREATE PROCEDURE GETTRAINEECOUNT(@TRAINEECOUNT INT OUTPUT)
AS BEGIN
		SELECT @TRAINEECOUNT=COUNT(ID) FROM TRAINEE;--COUNT INTEGER IS SAVED IN TRAINEE COUNT
END;

--CALLING THE STORED PROCEDURE
--TO RECIEVE THE DATA FROM STORED PROCEDURE
--FIRST DECLARE A KEYWORD TO STORRE THE RECIEVED VALUE

DECLARE @MYTRAINEECOUNT INT;

--EXECURE THE STORED PROCEDURE
EXEC GETTRAINEECOUNT @MYTRAINEECOUNT OUTPUT;

--PRINT THE VARIABLE
PRINT @MYTRAINEECOUNT


--THE STATEMENTS MUST BE RUN TOGETHER


--SUB QUERIES

SELECT * FROM TRAINEE WHERE ID IN (SELECT ID FROM TRAINEE  WHERE AGE>15);S

--SQL SERVER VIEWS
--A VIRTUAL TABLE BASED ON THE RESUULT OF A SQL QUERY

CREATE VIEW [CALIFORNIATRAINEES] AS
		SELECT FIRSTNAME,LASTNAME


SELECT * FROM SEMESTER;

--TRANSACTIONS IN SQL,EXECUTE A SEQUENCE OF SQL STAMEMENTS AS A TRANSACTION,
--TWO POSSIBLE OUTCOMES IF EVERYTHING WORK FINE IT WILL BE COMMITED AND THE DB CHANGES MADE PERMANENT .
--IF ANY ISSURES DURING THE WORKING OF STATEMENTS,THEN THE CHANHES TILL THEN WILL BE REVERTED.

--CREATING TRANSACTION AND DO A MANUAL COMMIT WITHOUT ANY CONDITION

BEGIN TRANSACTION
--STATEMENTS OF THE TRANSACTION

INSERT INTO SEMESTER(SEMNO,SEMNAME) VALUES (5,'SEM 5');
UPDATE SEMESTER SET SEMNAME = 'S5' WHERE SEMNO=5;

--COMMIT CHANGES
COMMIT TRANSACTION

-- RUN TOGETHER

--ROLLBACK
--CREATING TRANSACTION AND DO A MANUAL ROLLBACK WITHOUT ANY CONDITION

BEGIN TRANSACTION
--STATEMENTS OF THE TRANSACTION

INSERT INTO SEMESTER(SEMNO,SEMNAME) VALUES (6,'SEM 6');
UPDATE SEMESTER SET SEMNAME = 'S6' WHERE SEMNO=6;

--COMMIT CHANGES
ROLLBACK TRANSACTION

SELECT * FROM SEMESTER;


BEGIN TRANSACTION
--STATEMENTS OF THE TRANSACTION

INSERT INTO SEMESTER(SEMNO,SEMNAME) VALUES (7,'SEM 7');
UPDATE SEMESTER SET SEMNO = 'S7' WHERE SEMNO=7;

--COMMIT CHANGES
COMMIT TRANSACTION


