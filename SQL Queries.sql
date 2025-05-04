-- 1.Monthly Sales and Profit Trends
SELECT 
  DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
  ROUND(SUM(Sales), 2) AS Total_Sales,
  ROUND(SUM(Profit), 2) AS Total_Profit
FROM Walmart
GROUP BY Month
ORDER BY Month;

-- 2.Top 10 States by Total Profit
SELECT 
  State,
  ROUND(SUM(Profit), 2) AS Total_Profit
FROM Walmart
GROUP BY State
ORDER BY Total_Profit DESC
LIMIT 10;


-- 3.Products with Negative Total Profit
SELECT 
  Product_Name,
  ROUND(SUM(Profit), 2) AS Total_Profit
FROM Walmart
GROUP BY Product_Name
HAVING Total_Profit < 0
ORDER BY Total_Profit ASC;


-- 4.Total Orders and Sales by Segment
SELECT 
  Segment,
  COUNT(DISTINCT Order_ID) AS Total_Orders,
  ROUND(SUM(Sales), 2) AS Total_Sales
FROM Walmart
GROUP BY Segment
ORDER BY Total_Sales DESC;


-- 5.Rank Sub-Categories by Sales within Each Category
SELECT 
  Category,
  Sub_Category,
  ROUND(SUM(Sales), 2) AS Total_Sales,
  RANK() OVER (PARTITION BY Category ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM Walmart
GROUP BY Category, Sub_Category;


-- 6.Average Delivery Time (in Days)
SELECT 
  ROUND(AVG(DATEDIFF(Ship_Date, Order_Date)), 2) AS Avg_Delivery_Days
FROM Walmart;


-- 7.Compare Current Month’s Profit with Previous Month
SELECT 
  DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
  ROUND(SUM(Profit), 2) AS Current_Profit,
  LAG(ROUND(SUM(Profit), 2)) OVER (ORDER BY DATE_FORMAT(Order_Date, '%Y-%m')) AS Previous_Profit
FROM Walmart
GROUP BY Month
ORDER BY Month;


-- 8.Top 10 Most Ordered Products
SELECT 
  Product_Name,
  SUM(Quantity) AS Total_Quantity
FROM Walmart
GROUP BY Product_Name
ORDER BY Total_Quantity DESC
LIMIT 10;


-- 9.Running Total of Sales per Region
SELECT 
  Region,
  Order_Date,
  ROUND(SUM(Sales) OVER (PARTITION BY Region ORDER BY Order_Date), 2) AS Running_Sales
FROM Walmart
ORDER BY Region, Order_Date;
