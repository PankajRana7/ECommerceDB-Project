-- Create Database
CREATE DATABASE ECommerceDB;

-- Use Database
USE ECommerceDB;

-- Create Tables
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description TEXT,
    Price DECIMAL(10, 2),
    StockQuantity INT
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Password VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Populate Products table
INSERT INTO Products (ProductID, Name, Description, Price, StockQuantity)
VALUES 
    (1, 'Laptop', 'High-performance laptop with SSD storage', 999.99, 50),
    (2, 'Smartphone', 'Latest smartphone model with dual-camera setup', 699.99, 100),
    (3, 'Tablet', '10-inch tablet with high-resolution display', 299.99, 75),
    (4, 'Headphones', 'Wireless headphones with noise-cancellation feature', 199.99, 200),
    (5, 'Smartwatch', 'Fitness tracker with heart rate monitor', 149.99, 150),
    (6, 'Camera', 'DSLR camera with 24MP sensor', 799.99, 50),
    (7, 'Speaker', 'Bluetooth speaker with 360-degree sound', 99.99, 100),
    (8, 'External Hard Drive', 'Portable hard drive with 1TB storage capacity', 79.99, 300),
    (9, 'Gaming Console', 'Latest gaming console with 4K support', 499.99, 50),
    (10, 'Printer', 'All-in-one printer with wireless connectivity', 149.99, 100);

-- Populate Customers table
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Password)
VALUES 
    (1, 'John', 'Doe', 'john.doe@example.com', 'password123'),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', 'qwerty456'),
    (3, 'Michael', 'Johnson', 'michael.johnson@example.com', 'letmein789'),
    (4, 'Emily', 'Brown', 'emily.brown@example.com', 'securepwd1'),
    (5, 'David', 'Martinez', 'david.martinez@example.com', 'strongpass123'),
    (6, 'Sarah', 'Jones', 'sarah.jones@example.com', 'mypassword'),
    (7, 'Christopher', 'Garcia', 'christopher.garcia@example.com', 'p@ssw0rd'),
    (8, 'Jennifer', 'Wilson', 'jennifer.wilson@example.com', 'password1234'),
    (9, 'James', 'Taylor', 'james.taylor@example.com', 'p@$$w0rd'),
    (10, 'Jessica', 'Anderson', 'jessica.anderson@example.com', 'letmein123');

-- Populate Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES 
    (1, 1, '2024-05-20', 999.99),
    (2, 2, '2024-05-21', 699.99),
    (3, 3, '2024-05-22', 299.99),
    (4, 4, '2024-05-23', 199.99),
    (5, 5, '2024-05-24', 149.99),
    (6, 6, '2024-05-25', 799.99),
    (7, 7, '2024-05-26', 99.99),
    (8, 8, '2024-05-27', 79.99),
    (9, 9, '2024-05-28', 499.99),
    (10, 10, '2024-05-29', 149.99);

-- Populate OrderItems table
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Price)
VALUES 
    (1, 1, 1, 1, 999.99),
    (2, 2, 2, 1, 699.99),
    (3, 3, 3, 2, 299.99),
    (4, 4, 4, 1, 199.99),
    (5, 5, 5, 1, 149.99),
    (6, 6, 6, 1, 799.99),
    (7, 7, 7, 1, 99.99),
    (8, 8, 8, 1, 79.99),
    (9, 9, 9, 1, 499.99),
    (10, 10, 10, 1, 149.99);

-- Populate Payments table
INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount, PaymentMethod)
VALUES 
    (1, 1, '2024-05-20', 999.99, 'Credit Card'),
    (2, 2, '2024-05-21', 699.99, 'PayPal'),
    (3, 3, '2024-05-22', 299.99, 'Debit Card'),
    (4, 4, '2024-05-23', 199.99, 'Credit Card'),
    (5, 5, '2024-05-24', 149.99, 'PayPal'),
    (6, 6, '2024-05-25', 799.99, 'Credit Card'),
    (7, 7, '2024-05-26', 99.99, 'Debit Card'),


Q1: How do you find the total number of products in the Products table?
    Ans- SELECT 
     COUNT(*) AS TotalProducts 
     FROM Products;
        
 Q2: What is the average price of all products?
   Ans-SELECT 
    round( AVG(Price),2) AS AveragePrice 
    FROM Products;

 Q3: How can you calculate the total revenue generated from orders?
   Ans- SELECT 
    SUM(TotalAmount) AS TotalRevenue 
    FROM Orders;

 Q4: Retrieve the minimum and maximum order amounts.
    Ans- SELECT MIN(TotalAmount) AS MinOrderAmount,
    MAX(TotalAmount) AS MaxOrderAmount 
    FROM Orders;


 Q5: Find the number of orders placed by each customer.
    Ans- SELECT
     CustomerID,
     COUNT(*) AS TotalOrders 
     FROM Orders
     GROUP BY CustomerID;

 Q6: How do you retrieve order details along with customer information?
    Ans- SELECT
     O.*,
     C.FirstName,
     C.LastName,
     C.Email
     FROM Orders O
     INNER JOIN Customers C 
     ON O.CustomerID = C.CustomerID;

   Q7: Get the product details for each order item.
    Ans- SELECT
     O.*,
     P.Name AS ProductName, 
     P.Description, 
     P.Price
     FROM OrderItems OI
     INNER JOIN Orders O 
     ON OI.OrderID = O.OrderID
     INNER JOIN Products P 
     ON OI.ProductID = P.ProductID;

  Q8: Retrieve orders where a specific product was purchased.
   Ans- SELECT O.*
    FROM Orders O
    INNER JOIN OrderItems OI ON O.OrderID = OI.OrderID
    WHERE OI.ProductID = 1;

  Q9: List customers who have not placed any orders.
   Ans- SELECT 
    C.*
    FROM Customers C
    LEFT JOIN Orders O
    ON C.CustomerID = O.CustomerID
    WHERE O.OrderID IS NULL;

  Q10: Get the total amount spent by each customer.
   Ans- SELECT 
    O.CustomerID,
    SUM(O.TotalAmount) AS TotalSpent
    FROM Orders O
    GROUP BY O.CustomerID;

  Q11: How do you rank products based on their price in descending order?
   Ans- SELECT 
    *, RANK() OVER (ORDER BY Price DESC) AS PriceRank
    FROM Products;

   Q12: Retrieve the top 5 highest-priced products.
    Ans-  SELECT 
     *
     FROM Products
     ORDER BY Price DESC
     LIMIT 5;

   Q13: Find orders with total amounts greater than the average order amount.
     Ans- SELECT 
      *
      FROM Orders
      WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM Orders);

   Q14: Get the cumulative sum of order amounts using window functions.
    Ans- SELECT 
     OrderID,
     TotalAmount, 
     SUM(TotalAmount) OVER (ORDER BY OrderID) AS CumulativeAmount
     FROM Orders;


   Q15: Retrieve orders placed in the last quarter.
    Ans- SELECT 
     *
     FROM Orders
     WHERE EXTRACT(QUARTER FROM OrderDate) = EXTRACT(QUARTER FROM CURRENT_DATE);

   Q16: Extract the month and year from the OrderDate column.
    Ans- SELECT
    EXTRACT(MONTH FROM OrderDate) AS OrderMonth, 
    EXTRACT(YEAR FROM OrderDate) AS OrderYear
    FROM Orders;

  Q17: Format the OrderDate column in 'YYYY-MM-DD' format.
   Ans- SELECT 
   TO_CHAR(OrderDate, 'YYYY-MM-DD') AS FormattedOrderDate
   FROM Orders;

  Q18: Convert the Price column to text and append 'USD' to each price.
   Ans- SELECT 
   Price, Price::TEXT || ' USD' AS PriceWithCurrency
   FROM Products;

  Q19: Calculate the average price of products using a moving average window.
   Ans-SELECT 
   Price, AVG(Price) OVER (ORDER BY ProductID ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS MovingAveragePrice
   FROM Products;


  Q20: Rank customers based on their total order amounts using the RANK() function.
   Ans-SELECT 
    CustomerID, 
    TotalAmount,
    RANK() OVER (ORDER BY TotalAmount DESC) AS CustomerRank
    FROM (SELECT 
    CustomerID,
    SUM(TotalAmount) AS TotalAmount
     FROM Orders
      GROUP BY CustomerID) AS CustomerTotals;

  Q21: Get the row number for each order based on order date.
   Ans- SELECT 
   OrderID, 
   OrderDate,
       ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNumber
   FROM Orders;

  Q22: Calculate the running total of product stock quantities.
   Ans-SELECT
    ProductID,
    StockQuantity,
        SUM(StockQuantity) OVER (ORDER BY ProductID) AS RunningTotal
    FROM Products;

  Q23: Find the difference in price between consecutive products using the LAG() or LEAD() function.
   Ans- 
    SELECT
     ProductID,
     Price,
       Price - LAG(Price)
     OVER (ORDER BY ProductID) AS PriceDifferenceFromPrevious
      FROM Products;


   Q24: Categorize products into 'High', 'Medium', and 'Low' price ranges.
    Ans-SELECT *,
              CASE 
                WHEN Price >= 1000 THEN 'High'
                WHEN Price >= 500 THEN 'Medium'
                ELSE 'Low'
              END AS PriceCategory
       FROM Products;

   Q25: Assign a loyalty level ('Gold', 'Silver', 'Bronze') to customers based on their total order amounts.
    Ans-SELECT 

    CustomerID, TotalAmount,
              CASE 
                WHEN TotalAmount >= 1000 THEN 'Gold'
                WHEN TotalAmount >= 500 THEN 'Silver'
                ELSE 'Bronze'
              END AS LoyaltyLevel
       FROM (SELECT CustomerID, SUM(TotalAmount) AS TotalAmount
             FROM Orders
             GROUP BY CustomerID) AS CustomerTotals;


    Q26: Classify orders as 'High', 'Medium', or 'Low' based on total order amounts.
     Ans- SELECT 
      OrderID, 
      TotalAmount,
              CASE 
                WHEN TotalAmount >= 1000 THEN 'High'
                WHEN TotalAmount >= 500 THEN 'Medium'
                ELSE 'Low'
              END AS OrderCategory
       FROM Orders;


 
   Q27: Determine if a customer is a 'New', 'Returning', or 'VIP' customer based on their order history.
    Ans- SELECT 
    CustomerID, 
    TotalOrders,
              CASE 
                WHEN TotalOrders = 1 THEN 'New'
                WHEN TotalOrders <= 5 THEN 'Returning'
                ELSE 'VIP'
              END AS CustomerType
       FROM (SELECT CustomerID, COUNT(*) AS TotalOrders
             FROM Orders
             GROUP BY CustomerID) AS CustomerOrders;

   Q28: Assign a discount percentage to orders based on order totals using a CASE statement.
    Ans-SELECT
    OrderID, 
    TotalAmount,
              CASE 
                WHEN TotalAmount >= 1000 THEN TotalAmount * 0.1
                WHEN TotalAmount >= 500 THEN TotalAmount * 0.05
                ELSE 0
              END AS DiscountAmount
       FROM Orders;


  Q29: Retrieve the Top 3 Products with the Highest Total Sales.
   Ans-SELECT P.Name AS ProductName, 
       SUM(OI.Quantity * OI.Price) AS TotalSalesAmount,
       SUM(OI.Quantity) AS TotalQuantitySold
   FROM OrderItems OI
   INNER JOIN Products P ON OI.ProductID = P.ProductID
   GROUP BY P.Name
   ORDER BY TotalSalesAmount DESC
   LIMIT 3;

  Q30: Calculate the Average Order Value Per Customer.

    Ans- SELECT C.FirstName, 
        C.LastName,
        AVG(O.TotalAmount) AS AverageOrderValue
   FROM Customers C
    INNER JOIN Orders O ON C.CustomerID = O.CustomerID
    GROUP BY C.CustomerID, C.FirstName, C.LastName
    ORDER BY AverageOrderValue DESC;

























