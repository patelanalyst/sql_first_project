SELECT*FROM retail_sales
--HOW many sales we have ?
SELECT COUNT(*) as total_sale FROM retail_sales

--How many unique customers we have ?
SELECT COUNT (DISTINCT customer_id) as total_sale FROM retail_sales


SELECT DISTINCT category FROM retail_sales

--data analysis & Business anaylysis key problem and ansswers
--q-1 Write a sql query to retrive all columns for sales made on '2022-11-05'

SELECT *FROM retail_sales
WHERE sales_date = '2022-11-05';

--ques-2
Write a sql query to retrive all transactions where the catogory is clothing and the quantity sold is more than 4 in
the month of Nov_2022


SELECT *FROM retail_sales
WHERE category ='Clothing'
AND 
TO_CHAR(sales_date,'YYYY-MM')='2022-11'
AND
quantity>=4


ques-3-Write a sql query to calculate the total sales(total_sale) for each category

SELECT
     category,
	 SUM(total_sale) as net_sale,
	 COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1

QUES--4 write a sql query to find the avarage age of customer who purchased item from the 'beauty' category .

SELECT 
    ROUND(AVG(age),2) as avg_age
FROM retail_sales	
WHERE category ='Beauty'

ques-5--write a sql query to find the all transactions where the total_sale is greater than 1000

SELECT *FROM retail_sales
WHERE total_sale>1000

ques--6 write a sql query to find the total number of transactions(transction_id) made by each gender in each category

SELECT 
      category,
	  gender,
	  COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
	category,
	gender
ORDER BY 1	

QUES-7 -- write a sql query to calculate the average sale for each month .find out best selling month in each year
 
SELECT 
     year,
	 month,
	 avg_sale
FROM
(
SELECT 
     EXTRACT(YEAR FROM sales_date) as year,
	 EXTRACT(MONTH FROM sales_date)as month,
	 AVG(total_sale) as avg_sale,
	 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sales_date) ORDER BY AVG (total_sale) DESC) as rank
FROM retail_sales
  GROUP BY 1,2
)  as t1
WHERE rank =1 
--order by 1,3 DESC



---8 write a sql query to find the top 5 customers based on the highest total sales

SELECT 
      customer_id,
	  SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


---QUES--9 WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM  EACH CATEGORY

SELECT 
     category ,
	 COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM  retail_sales
GROUP BY category


--question 10-- write a sql query to create each shift and number of orders(Example MOrning<=12) 
WITH hourly_sale
AS
(
SELECT *,
    CASE 
	     WHEN EXTRACT (HOUR FROM sales_time) <12 THEN 'Morning'
	     WHEN EXTRACT (HOUR FROM sales_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		 
		 ELSE 'Evening'
		 
		 END as shift 
		 
FROM retail_sales
)
SELECT
shift ,
COUNT(*) as total_orders
FROM hourly_sale
GROUP BY SHIFT
SELECT EXTRACT(HOUR FROM CURRENT_TIME)
--end project