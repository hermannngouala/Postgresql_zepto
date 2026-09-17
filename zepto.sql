SELECT *
FROM zepto;

-- samples TOP 1O product
SELECT 
*
FROM zepto
LIMIT 10;

-- COUNT rows
SELECT COUNT(*)
FROM zepto;

--products in store and out store
SELECT outofstock, COUNT(*)
FROM zepto
GROUP BY outofstock
ORDER BY 2 DESC

--null values
SELECT *
FROM zepto
WHERE mrp = 0 OR discountedsellingprice = 0;

--data cleaning
DELETE FROM zepto WHERE mrp = 0;

SELECT *
FROM zepto;

SELECT *
FROM zepto
WHERE mrp = 0 OR discountedsellingprice = 0;

-- products name present multiple times
SELECT name, COUNT(*)
FROM zepto
GROUP BY name
ORDER BY 2 DESC;

--convert paise to rupees
UPDATE zepto 
SET mrp = mrp/100.0,
	discountedsellingprice = discountedsellingprice /100.0;
SELECT *
FROM zepto;

--1. Find the TOP 10 best-value products based on the discountpercent
SELECT DISTINCT name, mrp, discountpercent
FROM zepto
ORDER BY discountpercent DESC
LIMIT 10;

--2. The products with High mrp but out of stock
SELECT DISTINCT name, mrp, outofstock
FROM zepto
WHERE outofstock = 'true'
ORDER BY mrp DESC
LIMIT 4;

--3 Estimated total revenu by category
SELECT category,
		SUM(discountedsellingprice*availablequantity) as totalrevenue
FROM zepto
GROUP BY category
ORDER BY 2 DESC;

--4 Find all products where mrp is higher than 500 and discount less than 10%
SELECT DISTINCT name, mrp,discountpercent
FROM zepto
WHERE mrp > 500.00 AND discountpercent < 10.00
ORDER BY 2 DESC;

--5 Indentify Top5 categories offering the highest average discountpercent
SELECT DISTINCT name, ROUND(AVG(discountpercent),2) as avgdiscountpercent
FROM zepto
GROUP BY DISTINCT name
ORDER BY 2 DESC
LIMIT 10;

--6 Find the price per gram for products above 100g and sort by best value
SELECT DISTINCT name, weightingms, discountedsellingprice,
ROUND(discountedsellingprice / weightingms, 2) as price_per_gms
FROM zepto
WHERE weightingms >= 100
ORDER BY 4 ;

--7 Group the product into categories like low, Medium, Bulk and count number in each categories 
WITH cte_wc AS (
SELECT DISTINCT name, weightingms,
	   CASE 
	   		WHEN weightingms < 1000  THEN 'Low'
	   		WHEN weightingms < 5000  THEN 'Medium'
			ELSE 'Bulk'
		END As weight_category
FROM zepto
)
SELECT weight_category, COUNT(*)
FROM cte_wc
GROUP BY weight_category
ORDER BY 2 DESC;

--8 what is the Total inventory Weight Per Category
SELECT category,
		SUM(weightingms * availablequantity) As Totalweight
FROM zepto
GROUP BY category
ORDER BY 2 ;


