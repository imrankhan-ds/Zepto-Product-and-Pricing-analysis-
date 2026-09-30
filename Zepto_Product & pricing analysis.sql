create database zepto_analysis;
use zepto_analysis;

CREATE TABLE products (
    Product_ID INT AUTO_INCREMENT PRIMARY KEY,
    Category VARCHAR(100),
    Product_name VARCHAR(255),
    Price DECIMAL(10,2),
    Packsize VARCHAR(50),
    Rating DECIMAL(3,2),
    Original_price DECIMAL(10,2),
    Discount DECIMAL(5,2)
);
select count(*) as Total_products
 from products;

SELECT
    COUNT(*) AS total_rows,
    SUM(Category IS NULL) AS missing_category,
    SUM(Product_name IS NULL) AS missing_product,
    SUM(Price IS NULL) AS missing_price,
    SUM(Packsize IS NULL) AS missing_packsize,
    SUM(Rating IS NULL) AS missing_rating,
    SUM(Original_price IS NULL) AS missing_original_price,
    SUM(Discount IS NULL) AS missing_discount
FROM products;

select * from products;


-- question 1 -- how much product in each category 

select category , count(*) as Total_products 
from products 
group by category 
order by  Total_products desc;




-- question 2 -- Average price by category 

select category , round(avg(Price),2) as Average_price
from products 
group by category 
order by avg(Price) desc;

-- question  3 -- which category has the highest avg discount 

select category , round(avg(Discount),2) as average_discount 
from products 
group by category 
order by average_discount desc;

-- top 10 product has the highest selling price 

select Product_name , Price
from products 
order by Price desc
limit 10;


-- Top 10 products has the highest discount 

select Product_name , Discount
from products 
order by Discount desc
limit 10;

--  question 6 which category has the hisghest avg selling price

select category , avg(Price)
from products
group by category
order by avg(Price) desc
limit 1;

--  question 7 which product has the rating highest than overall avg rating
select Product_name, Rating 
from products 
where rating > (
select avg(Rating)
from products 
)order by Rating desc;


-- question 8 which category has more than 50 products 

select category , count(*) as Total_products 
from products 
group by category 
having count(*)>50
order by Total_products desc;


-- question 9 Discount classification
 select Product_name , Discount,
 case 
     when Discount>=30 then "High Discount"
     when Discount >=10 then "Medium  Discount"
     else "Low Discount"
End as Disount_classification
from products;
     
-- question 10 average price by discount category 

SELECT
    CASE
        WHEN Discount >= 30 THEN 'High Discount'
        WHEN Discount >= 10 THEN 'Medium Discount'
        ELSE 'Low Discount'
    END AS Discount_Category,
    ROUND(AVG(Price), 2) AS average_price
FROM products
GROUP BY
    CASE
        WHEN Discount >= 30 THEN 'High Discount'
        WHEN Discount >= 10 THEN 'Medium Discount'
        ELSE 'Low Discount'
    END;

--  question 11 --- top 10 product that has highest difference between original price and price 

SELECT 
    Product_name,
    Original_price,
    Price,
    ROUND(Original_price - Price, 2) AS Price_Difference
FROM products
ORDER BY Price_Difference DESC
LIMIT 10;

-- question 12 --- Product above Average price 

select Product_name, Price 
from products 
where Price > (
select avg(Price)
from products
) ;

-- question 13 -- highest priced product in each category 

select category , max(Price) 
from products 
group by category ;


-- question 14 --- find the categories that has more product  than the average number of product per category 

select category , count(*) as Total_number_of_products
from products
group by category 
having count(*) > 
(select avg(category_count)
from (
select count(*) as category_count 
from products 
group by category 
) as category_counts)
order by Total_number_of_products desc;


 -- question 15 --  Lowest rating products 
 
 select Product_name , Rating 
 from products 
 order by Rating asc
 limit 10;
 
 
 -- question 16 -- product whose discount is 0 or less than 10
 
 select Product_name , Discount 
 from products 
 where  (Discount =0) or (Discount <10);
 
 
--  question 17 -- Category wise highest rating 

select category , max(Rating )
from products 
group by category 
order by max(Rating) desc;


 -- question 18 -- Top 3 products by rating 
 
 select Product_name , Rating 
 from Products 
 order by Rating desc
 limit 3;
 
 -- question 19 ---  Rank product within each category 
 
 select * 
 from (
 select category , product_name , Price ,
 Rank() over (partition by category
 order by Price desc
 ) as price_rank
 from products 
 ) as ranked_products 
 where price_rank <=3
 order by category , price_rank;
 
 
  -- question 20 --- top 3 highest rated product in each category 
  select * 
  from(
  select Product_name , Rating , category ,
  rank() over(partition by category 
  order by Rating desc) as ranks 
  from products) as ranked_product 
  where ranks<=3
  order by category , ranks;
  
  
  
  