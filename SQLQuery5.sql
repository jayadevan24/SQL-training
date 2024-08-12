select * from Products;

--AGGREGATE FUNCTION

--MIN,MAX,AVG,COUNT FUNCTION

SELECT MIN(UnitPrice) FROM Products;

SELECT MIN(UnitPrice),MIN(UnitsInStock) FROM Products;

SELECT MAX(UnitPrice) FROM Products;

SELECT AVG(UnitPrice) AS 'Average' FROM Products ;

SELECT PRODUCTID,PRODUCTNAME,UNITPRICE FROM Products WHERE  UNITPRICE=MIN(UNITPRICE); -- WE CANT INCLUDE A AGGREGATE IN WHERE

SELECT PRODUCTID,PRODUCTNAME,UNITPRICE FROM Products WHERE  UNITPRICE=(SELECT MIN(UnitPrice) FROM Products);


SELECT PRODUCTID,PRODUCTNAME,UNITPRICE FROM Products WHERE  UNITPRICE>(SELECT AVG(UnitPrice)FROM Products) ;


--SUM AGGREGATE IS USED TO GET TOTAL VALUE OF THE COLUMN

SELECT SUM(UnitsInStock) as 'Total Stock' from products;

SELECT SUM(UnitsInStock) as 'Stock discontinued' from products where discontinued=1;

--COUNT AGGREGATE FUNCTION TO GET COUNT OF ITEMS
--OR NUMBER OF ROWS THAT MATCH THE CONDITION

--TO COUNT NUMBER OF PRODUCTS

SELECT COUNT(PRODUCTID) as 'No: of Products' FROM Products;

--NUMBER OF PRODUCTS DISCONTINUED
SELECT COUNT(PRODUCTID) as 'discontinued Products' FROM Products WHERE discontinued=1;



