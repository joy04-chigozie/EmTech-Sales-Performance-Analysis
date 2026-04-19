CREATE DATABASE EmTechAnalytics;

USE EmTechAnalytics;
SELECT TOP 10 * FROM EmTech_orders;

ALTER TABLE EmTech_orders
DROP COLUMN REGION;

/* Customer Table*/
SELECT DISTINCT [USER_ID]
INTO customers
FROM EmTech_orders;

DROP TABLE customers;

SELECT DISTINCT [USER_ID],[MARKETING_CHANNEL] ,[ACCOUNT_CREATION_METHOD], [COUNTRY_CODE]
INTO customers
FROM EmTech_orders;

SELECT * FROM customers;

/* Product Table Creation*/
SELECT DISTINCT [PRODUCT_ID], [PRODUCT_NAME]
INTO products
FROM EmTech_orders;

DROP TABLE products;

SELECT DISTINCT [PRODUCT_ID], [PRODUCT_NAME],[USD_PRICE]
INTO products
FROM EmTech_orders;

SELECT * FROM products;

/* KPIs Revenue, Order Volume, AOV Overall Performance*/
SELECT SUM([USD_PRICE]) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders;

 /* Sales Yearly Trends*/
SELECT [YEAR] year,ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
WHERE [YEAR] IS NOT NULL
GROUP BY year
ORDER BY year;

/*Yearly Sales Impact. Contribution Analysis%)*/
WITH yearly_sales AS(
SELECT [YEAR] year, ROUND(SUM([USD_PRICE]),2) current_revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
 WHERE [YEAR] IS NOT NULL
 GROUP BY year
)
 SELECT year,current_revenue,SUM(current_revenue) OVER()overall_revenue,ROUND((current_revenue/SUM(current_revenue) OVER())*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER()overall_order_volume,ROUND((order_volume/SUM(CAST(order_volume AS FLOAT)) OVER())*100,2) orders_pct,
 AOV,SUM(AOV) OVER()overall_aov,ROUND((AOV/SUM(AOV) OVER())*100,2) aov_pct
   FROM yearly_sales;

/*Sales Monthly Trends*/
SELECT [YEAR] year,[MONTH_NUMBER] month_num, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE])*1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
WHERE [YEAR] IS NOT NULL
GROUP BY year,[MONTH_NUMBER]
ORDER BY year, [MONTH_NUMBER];

/*MONTH WITH THE HIGHEST REVENUE*/
SELECT [YEAR] year,[MONTH_NUMBER] month_num, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE])*1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
WHERE [YEAR] IS NOT NULL
GROUP BY year,[MONTH_NUMBER]
ORDER BY revenue DESC;

/*MONTH WITH THE HIGHEST ORDER*/
SELECT [YEAR] year,[MONTH_NUMBER] month_num, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE])*1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
WHERE [YEAR] IS NOT NULL
GROUP BY year,[MONTH_NUMBER]
ORDER BY order_volume DESC;

/*MONTH WITH THE HIGHEST AOV*/
SELECT [YEAR] year,[MONTH_NUMBER] month_num, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE])*1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
WHERE [YEAR] IS NOT NULL
GROUP BY year,[MONTH_NUMBER]
ORDER BY AOV DESC;

/*Monthly Sales Impact. Contribution Analysis%)*/
WITH monthly_sales AS(
SELECT [YEAR] year,[MONTH_NUMBER] AS month_number, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
 WHERE [YEAR] IS NOT NULL
 GROUP BY year,[MONTH_NUMBER]
)
 SELECT year,month_number,revenue,SUM(revenue) OVER(PARTITION BY year)overall_revenue,ROUND((revenue/SUM(revenue) OVER(PARTITION BY year))*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER(PARTITION BY year)overall_order_volume,ROUND((order_volume/SUM(CAST(order_volume AS FLOAT)) OVER(PARTITION BY year))*100,2) orders_pct,
 AOV,SUM(AOV) OVER(PARTITION BY year)overall_aov,ROUND((AOV/SUM(AOV) OVER(PARTITION BY year))*100,2) aov_pct
   FROM monthly_sales
   ORDER BY year, month_number;

/*YEAR-OVER-YEAR SALES GROWTH(YoY%)*/

WITH yearly AS ( 
SELECT [YEAR] year,ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
WHERE [YEAR] IS NOT NULL
GROUP BY year
)
SELECT year, revenue,
LAG(revenue) OVER (ORDER BY year) AS prev_year_revenue,
ROUND(((revenue- LAG(revenue) OVER (ORDER BY year)) * 1.0/ LAG(revenue) OVER (ORDER BY year))*100,2) AS revenue_yoy_growth, order_volume,
LAG(order_volume) OVER (ORDER BY year) AS prev_year_orders,
ROUND(((order_volume- LAG(order_volume) OVER (ORDER BY year)) * 1.0/ LAG(CAST(order_volume AS FLOAT)) OVER (ORDER BY year))*100,2) AS orders_yoy_growth,
 AOV,
 LAG(AOV) OVER (ORDER BY year) AS prev_year_aov,
ROUND(((AOV- LAG(AOV) OVER (ORDER BY year)) * 1.0/ LAG(AOV) OVER (ORDER BY year))*100,2) AS aov_yoy_growth
FROM yearly;

/*Month-over-Month Sales Growth(MoM%)*/

WITH monthly AS(
SELECT [YEAR] year,[MONTH_NUMBER] AS month_number, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
WHERE [YEAR] IS NOT NULL
GROUP BY year,[MONTH_NUMBER]
)
SELECT year, 
month_number,
revenue,
LAG(revenue) OVER ( ORDER BY year) AS prev_month_revenue,
ROUND(((revenue-LAG(revenue) OVER (ORDER BY  year)) * 1.0/ LAG(revenue) OVER (ORDER BY  year))*100,2) AS mom_revenue_growth
,order_volume, LAG(order_volume) OVER ( ORDER BY year) AS prev_month_orders,
ROUND(((order_volume-LAG(order_volume) OVER (ORDER BY  year)) * 1.0/ LAG(CAST (order_volume AS FLOAT)) OVER (ORDER BY  year))*100,2) AS mom_orders_growth,
AOV, LAG(AOV) OVER ( ORDER BY year) AS prev_month_aov,
ROUND(((AOV-LAG(AOV) OVER (ORDER BY  year)) * 1.0/ LAG(AOV) OVER (ORDER BY  year))*100,2) AS mom_aov_growth
FROM monthly;


/* PRODUCT ANALYSIS*/
/* OVERALL PRODUCT PERFORMANCE. TOP PRODUCTS*/

SELECT [PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
 GROUP BY PRODUCT_NAME
 ORDER BY revenue DESC;

 /* OVERALL CONTRIBUTION ANALYSIS.TOP PRODUCTS BY REVENUE*/
WITH product_sales AS(
SELECT [PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) current_revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
 GROUP BY PRODUCT_NAME
)
 SELECT product,current_revenue,SUM(current_revenue) OVER()overall_revenue,ROUND((current_revenue/SUM(current_revenue) OVER())*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER()overall_order_volume,ROUND((order_volume/SUM(CAST(order_volume AS FLOAT)) OVER())*100,2) orders_pct,
 AOV,SUM(AOV) OVER()overall_aov,ROUND((AOV/SUM(AOV) OVER())*100,2) aov_pct
   FROM product_sales
   ORDER BY current_revenue DESC;

   
 /* OVERALL CONTRIBUTION ANALYSIS.TOP PRODUCTS BY ORDERS*/
WITH product_sales AS(
SELECT [PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) current_revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
 GROUP BY PRODUCT_NAME
)
 SELECT product,current_revenue,SUM(current_revenue) OVER()overall_revenue,ROUND((current_revenue/SUM(current_revenue) OVER())*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER()overall_order_volume,ROUND((order_volume/SUM(CAST(order_volume AS FLOAT)) OVER())*100,2) orders_pct,
 AOV,SUM(AOV) OVER()overall_aov,ROUND((AOV/SUM(AOV) OVER())*100,2) aov_pct
   FROM product_sales
   ORDER BY order_volume DESC;

   /* OVERALL CONTRIBUTION ANALYSIS.TOP PRODUCTS BY AOV*/
WITH product_sales AS(
SELECT [PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) current_revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
 GROUP BY PRODUCT_NAME
)
 SELECT product,current_revenue,SUM(current_revenue) OVER()overall_revenue,ROUND((current_revenue/SUM(current_revenue) OVER())*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER()overall_order_volume,ROUND((order_volume/SUM(CAST(order_volume AS FLOAT)) OVER())*100,2) orders_pct,
 AOV,SUM(AOV) OVER()overall_aov,ROUND((AOV/SUM(AOV) OVER())*100,2) aov_pct
   FROM product_sales
   ORDER BY AOV DESC;

 /*PRODUCT Yearly TREND*/
 SELECT [YEAR] year, [PRODUCT_NAME], ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
 WHERE DATE_STATUS = 'Dated'
 GROUP BY year,PRODUCT_NAME
 ORDER BY year, revenue DESC
 ;

 /*PRODUCT YEARLY CONTRIBUTION%*/
 WITH yearly_product AS(
 SELECT [YEAR] year, [PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
 WHERE DATE_STATUS = 'Dated'
 GROUP BY year,PRODUCT_NAME
)
 SELECT year,product,revenue,SUM(revenue) OVER(PARTITION BY year ) overall_revenue,
 ROUND((revenue/SUM(revenue) OVER(PARTITION BY year))*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER(PARTITION BY year)overall_order_volume,
 ROUND((CAST(order_volume AS FLOAT)/SUM(order_volume) OVER(PARTITION BY year ))*100,2) orders_pct,
 AOV,SUM(AOV) OVER(PARTITION BY year)overall_aov,
 ROUND((AOV/SUM(AOV) OVER(PARTITION BY year ))*100,2) aov_pct
   FROM yearly_product
   ORDER BY year, revenue DESC;

   /*TOP PRODUCTS IN THE PEAK YEAR,2020 BY REVENUE.*/
 WITH yearly_product AS
 (
 SELECT [YEAR] year, [PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
 WHERE DATE_STATUS = 'Dated' AND [YEAR] = 2020
 GROUP BY year,PRODUCT_NAME
 )
 SELECT year,product,revenue,SUM(revenue) OVER(PARTITION BY year ) overall_revenue,
 ROUND((revenue/SUM(revenue) OVER(PARTITION BY year))*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER(PARTITION BY year)overall_order_volume,
 ROUND((CAST(order_volume AS FLOAT)/SUM(order_volume) OVER(PARTITION BY year ))*100,2) orders_pct,
 AOV,SUM(AOV) OVER(PARTITION BY year)overall_aov,
 ROUND((AOV/SUM(AOV) OVER(PARTITION BY year ))*100,2) aov_pct
   FROM yearly_product
   ORDER BY year, revenue DESC;
 
    /*TOP PRODUCTS IN THE PEAK YEAR,2020 BY ORDERS.*/
 WITH yearly_product AS
 (
 SELECT [YEAR] year, [PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
 WHERE DATE_STATUS = 'Dated' AND [YEAR] = 2020
 GROUP BY year,PRODUCT_NAME
 )
 SELECT year,product,revenue,SUM(revenue) OVER(PARTITION BY year ) overall_revenue,
 ROUND((revenue/SUM(revenue) OVER(PARTITION BY year))*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER(PARTITION BY year)overall_order_volume,
 ROUND((CAST(order_volume AS FLOAT)/SUM(order_volume) OVER(PARTITION BY year ))*100,2) orders_pct,
AOV,SUM(AOV) OVER(PARTITION BY year)overall_aov,
 ROUND((AOV/SUM(AOV) OVER(PARTITION BY year ))*100,2) aov_pct
   FROM yearly_product
   ORDER BY year, order_volume DESC;

    /*TOP PRODUCTS IN THE AOV PEAK YEAR,2021.*/
  WITH yearly_product AS
 (
 SELECT [YEAR] year, [PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
 WHERE DATE_STATUS = 'Dated' AND [YEAR] = 2021
 GROUP BY year,PRODUCT_NAME
 )
 SELECT year,product,revenue,SUM(revenue) OVER(PARTITION BY year ) overall_revenue,
 ROUND((revenue/SUM(revenue) OVER(PARTITION BY year))*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER(PARTITION BY year)overall_order_volume,
 ROUND((CAST(order_volume AS FLOAT)/SUM(order_volume) OVER(PARTITION BY year ))*100,2) orders_pct,
AOV,SUM(AOV) OVER(PARTITION BY year)overall_aov,
 ROUND((AOV/SUM(AOV) OVER(PARTITION BY year ))*100,2) aov_pct
   FROM yearly_product
   ORDER BY year, AOV DESC;

 /*PRODUCT Monthly TREND*/
 SELECT [YEAR] year,[MONTH_NUMBER] month_num,[PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
WHERE [YEAR] IS NOT NULL
GROUP BY year,[MONTH_NUMBER],[PRODUCT_NAME]
ORDER BY year, [MONTH_NUMBER], revenue Desc;

/* WITH CONTRIBUTION ANALYSIS*/
WITH monthly_product_pct AS(
SELECT [YEAR] year,[MONTH_NUMBER] month_num,[PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
WHERE [YEAR] IS NOT NULL
GROUP BY year,[MONTH_NUMBER],[PRODUCT_NAME]
)
SELECT year,month_num,product,revenue,SUM(revenue) OVER(PARTITION BY year,month_num ) overall_revenue,
 ROUND((revenue/SUM(revenue) OVER(PARTITION BY year,month_num))*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER(PARTITION BY year,month_num)overall_order_volume,
 ROUND((CAST(order_volume AS FLOAT)/SUM(order_volume) OVER(PARTITION BY year,month_num ))*100,2) orders_pct,
 AOV,SUM(AOV) OVER(PARTITION BY year,month_num)overall_aov,
 ROUND((AOV/SUM(AOV) OVER(PARTITION BY year ))*100,2) aov_pct
   FROM monthly_product_pct
   ORDER BY year, month_num,revenue DESC;

 
 /*PRODUCT YEARLY GROWTH RATE*/
/*Year-over-Year Growth(YoY%)*/

WITH yearly_product AS ( 
SELECT [YEAR] year,[PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
WHERE [YEAR] IS NOT NULL
GROUP BY year,[PRODUCT_NAME]
)
SELECT year, product,revenue,
LAG(revenue) OVER (PARTITION BY product ORDER BY year) AS prev_year_revenue,
round(((revenue- LAG(revenue) OVER (PARTITION BY product ORDER BY year)) * 1.0/ LAG(revenue) OVER (PARTITION BY product ORDER BY year))*100,2) AS revenue_yoy_growth, order_volume,
LAG(order_volume) OVER (PARTITION BY product ORDER BY year) AS prev_year_orders,
ROUND(((order_volume- LAG(CAST(order_volume AS FLOAT)) OVER (PARTITION BY product ORDER BY year)) / LAG(order_volume) OVER (PARTITION BY product ORDER BY year))*100,2) AS orders_yoy_growth,
 AOV,
 LAG(AOV) OVER (PARTITION BY product ORDER BY year) AS prev_year_aov,
ROUND(((AOV- LAG(AOV) OVER (PARTITION BY product ORDER BY year)) * 1.0/ LAG(AOV) OVER (PARTITION BY product ORDER BY year))*100,2) AS aov_yoy_growth
FROM yearly_product
;

 /*Month-over-month Product Sales*/
WITH monthly_product AS ( 
SELECT [YEAR] year,[MONTH_NUMBER] month_number, [PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
WHERE [YEAR] IS NOT NULL
GROUP BY year,month_number,[PRODUCT_NAME]
)
SELECT year, month_number,product,revenue,
LAG(revenue) OVER (PARTITION BY product ORDER BY year, month_number) AS prev_year_revenue,
round(((revenue- LAG(revenue) OVER (PARTITION BY product ORDER BY year, month_number)) * 1.0/ LAG(revenue) OVER (PARTITION BY product ORDER BY year, month_number))*100,2) AS revenue_yoy_growth, order_volume,
LAG(order_volume) OVER (PARTITION BY product ORDER BY year, month_number) AS prev_year_orders,
ROUND(((order_volume- LAG(CAST(order_volume AS FLOAT)) OVER (PARTITION BY product ORDER BY year, month_number)) / LAG(order_volume) OVER (PARTITION BY product ORDER BY year, month_number))*100,2) AS orders_yoy_growth,
 AOV,
 LAG(AOV) OVER (PARTITION BY product ORDER BY year, month_number) AS prev_year_aov,
ROUND(((AOV- LAG(AOV) OVER (PARTITION BY product ORDER BY year, month_number)) * 1.0/ LAG(AOV) OVER (PARTITION BY product ORDER BY year, month_number))*100,2) AS aov_yoy_growth
FROM monthly_product;


/*REGION*/
/*REGIONAL SALES TREND*/
SELECT REGION_CLEANED region, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders 
 GROUP BY REGION_CLEANED
 ORDER BY revenue DESC;


 WITH regional_sales_pct AS
 (
 SELECT REGION_CLEANED region, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders 
 GROUP BY REGION_CLEANED
 )
 SELECT region,revenue,SUM(revenue) OVER() overall_revenue,
 ROUND((revenue/SUM(revenue) OVER())*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER()overall_order_volume,
 ROUND((CAST(order_volume AS FLOAT)/SUM(order_volume) OVER())*100,2) orders_pct,
 AOV,SUM(AOV) OVER()overall_aov,
 ROUND((AOV/SUM(AOV) OVER())*100,2) aov_pct
   FROM  regional_sales_pct
   ORDER BY revenue DESC;

 /*REGION YEARLY CONTRIBUTION%*/

 WITH yearly_region_sales AS(
 SELECT[YEAR] year,REGION_CLEANED region, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
 WHERE DATE_STATUS = 'Dated'
 GROUP BY year,REGION_CLEANED
)
 SELECT year,region,revenue,SUM(revenue) OVER(PARTITION BY year ) overall_revenue,
 ROUND((revenue/SUM(revenue) OVER(PARTITION BY year))*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER(PARTITION BY year)overall_order_volume,
 ROUND((CAST(order_volume AS FLOAT)/SUM(order_volume) OVER(PARTITION BY year ))*100,2) orders_pct,
 AOV,SUM(AOV) OVER(PARTITION BY year)overall_aov,
 ROUND((AOV/SUM(AOV) OVER(PARTITION BY year ))*100,2) aov_pct
   FROM yearly_region_sales
   ORDER BY year, revenue DESC;
 
 
/* REGIONAL MONTHLY CONTRIBUTION ANALYSIS*/
/*WITH monthly_region_pct AS(
SELECT [YEAR] year,[MONTH_NUMBER] month_num,REGION_CLEANED region, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
WHERE [YEAR] IS NOT NULL
GROUP BY year,[MONTH_NUMBER],REGION_CLEANED
)
SELECT year,month_num,region,revenue,SUM(revenue) OVER(PARTITION BY year,month_num ) overall_revenue,
 ROUND((revenue/SUM(revenue) OVER(PARTITION BY year,month_num))*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER(PARTITION BY year,month_num)overall_order_volume,
 ROUND((CAST(order_volume AS FLOAT)/SUM(order_volume) OVER(PARTITION BY year,month_num ))*100,2) orders_pct,
 AOV,SUM(AOV) OVER(PARTITION BY year,month_num)overall_aov,
 ROUND((AOV/SUM(AOV) OVER(PARTITION BY year ))*100,2) aov_pct
   FROM monthly_region_pct
   ORDER BY year, month_num,revenue DESC;*/

   /* REGIONAL PRODUCT PERFORMANCE: Products Driving Each Region*/
   SELECT REGION_CLEANED region,[PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders 
 GROUP BY REGION_CLEANED,PRODUCT_NAME
 ORDER BY region,revenue DESC;

 /*MARKET SHARE*/
 WITH regional_product_pct AS
 (
 SELECT REGION_CLEANED region,[PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders 
 GROUP BY REGION_CLEANED,PRODUCT_NAME
 )
 SELECT region,product,revenue,SUM(revenue) OVER(PARTITION BY region) overall_revenue,
 ROUND((revenue/SUM(revenue) OVER(PARTITION BY region))*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER(PARTITION BY region)overall_order_volume,
 ROUND((CAST(order_volume AS FLOAT)/SUM(order_volume) OVER(PARTITION BY region))*100,2) orders_pct,
 AOV,SUM(AOV) OVER(PARTITION BY region)overall_aov,
 ROUND((AOV/SUM(AOV) OVER(PARTITION BY region))*100,2) aov_pct
   FROM  regional_product_pct
   ORDER BY region,revenue DESC;


   /*MARKETING CHANNEL*/
/*MARKETING CHANNEL SALES TREND*/
SELECT MARKETING_CHANNEL marketing_channel, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders 
 GROUP BY MARKETING_CHANNEL
 ORDER BY revenue DESC;


 WITH  marketing_channel_sales_pct AS
 (
 SELECT MARKETING_CHANNEL marketing_channel, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders 
 GROUP BY marketing_channel
 )
 SELECT marketing_channel,revenue,SUM(revenue) OVER() overall_revenue,
 ROUND((revenue/SUM(revenue) OVER())*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER()overall_order_volume,
 ROUND((CAST(order_volume AS FLOAT)/SUM(order_volume) OVER())*100,2) orders_pct,
 AOV,SUM(AOV) OVER()overall_aov,
 ROUND((AOV/SUM(AOV) OVER())*100,2) aov_pct
   FROM  marketing_channel_sales_pct
   ORDER BY revenue DESC;

 /*MARKETING CHANNEL YEARLY CONTRIBUTION%*/

 WITH yearly_marketing_channel_sales AS(
 SELECT[YEAR] year,MARKETING_CHANNEL marketing_channel, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders
 WHERE DATE_STATUS = 'Dated'
 GROUP BY year,MARKETING_CHANNEL
)
 SELECT year,marketing_channel,revenue,SUM(revenue) OVER(PARTITION BY year ) overall_revenue,
 ROUND((revenue/SUM(revenue) OVER(PARTITION BY year))*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER(PARTITION BY year)overall_order_volume,
 ROUND((CAST(order_volume AS FLOAT)/SUM(order_volume) OVER(PARTITION BY year ))*100,2) orders_pct,
 AOV,SUM(AOV) OVER(PARTITION BY year)overall_aov,
 ROUND((AOV/SUM(AOV) OVER(PARTITION BY year ))*100,2) aov_pct
   FROM yearly_marketing_channel_sales
   ORDER BY year, revenue DESC;
 

   /* MARKETING CHANNEL PRODUCT PERFORMANCE: Products Driving Each Marketing Channel*/
   SELECT MARKETING_CHANNEL marketing_channel,[PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders 
 GROUP BY marketing_channel,PRODUCT_NAME
 ORDER BY marketing_channel,revenue DESC;

 /*MARKET SHARE*/
 WITH marketing_channel_product_pct AS
 (
 SELECT MARKETING_CHANNEL marketing_channel,[PRODUCT_NAME] product, ROUND(SUM([USD_PRICE]),2) revenue, COUNT(DISTINCT [ORDER_ID]) order_volume,
 ROUND(SUM([USD_PRICE]) *1.0 / COUNT(DISTINCT [ORDER_ID]),2) AOV
 FROM EmTech_orders 
 GROUP BY MARKETING_CHANNEL,PRODUCT_NAME
 )
 SELECT marketing_channel,product,revenue,SUM(revenue) OVER(PARTITION BY marketing_channel) overall_revenue,
 ROUND((revenue/SUM(revenue) OVER(PARTITION BY marketing_channel))*100,2) revenue_pct,
 order_volume,SUM(order_volume) OVER(PARTITION BY marketing_channel)overall_order_volume,
 ROUND((CAST(order_volume AS FLOAT)/SUM(order_volume) OVER(PARTITION BY marketing_channel))*100,2) orders_pct,
 AOV,SUM(AOV) OVER(PARTITION BY marketing_channel)overall_aov,
 ROUND((AOV/SUM(AOV) OVER(PARTITION BY marketing_channel))*100,2) aov_pct
   FROM  marketing_channel_product_pct
   ORDER BY marketing_channel,revenue DESC;