-- SQL Retail Sales Analysis

create database franklin_one;

--create table
CREATE TABLE retail_sales
(
transaction_id INT PRIMARY KEY,	
sale_date DATE,	 
sale_time TIME,	
customer_id	INT,
gender	VARCHAR(15),
age	INT,
category VARCHAR(15),	
quantiy INT,
price_per_unit FLOAT,	
cogs FLOAT,
total_sale FLOAT
 );
			

-- data cleaning
select * from retail_sales
where 
transactions_id is null
or
retail_sales is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or 
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales



SELECT DISTINCT category FROM retail_sales

--Q.1 write sql query to retrive all column for sales made on 2022-11-05
select * from retail_sales
where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category
------is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022

select *
from retail_sales
where category = 'Clothing'
and
to_char(sale_date,'yyyy-mm')= '2022-11'
and
quantiy >= 2



-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category,
sum(total_sale) as net_sales
from retail_sales
group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select
round(avg(age),2) as avg_age
from retail_sales
where category = 'Beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select total_sale
from retail_sales
where total_sale > '1000'

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select
category, 
gender,
count(*) as total_transactions
from retail_sales
group by category, gender
order by category, 
gender


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select
extract(month from sale_date) as month,
extract(year from sale_date) as year,
avg(total_sale) as avg_sale
from retail_sales
group by month,year


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select
customer_id,
sum(total_sale) as sum_sales
from retail_sales
group by customer_id
order by sum_sales desc
limit 5


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select
category,
count(distinct customer_id) as unique_cus
from retail_sales
group by category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12,
--Afternoon Between 12 & 17, Evening >17)

with hourly_order
as
(
select *,
case
    when extract(hour from sale_time) <12 then 'morning'
	when extract(hour from sale_time) between 12 and 17 then 'afternoon'
	else 'evening'
 end as shift
from retail_sales
)
select 
shift,
count(*) as total_order
from hourly_order
group by shift

--end of the project












