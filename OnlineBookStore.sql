CREATE DATABASE Online_Book_Store;

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100),
    Birthdate DATE,
    Nationality VARCHAR(50)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255),
    ISBN VARCHAR(20),
    Genre VARCHAR(50),
    Price DECIMAL(10, 2),
    AuthorID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Address VARCHAR(255),
    Phone VARCHAR(15)
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    BookID INT,
    Quantity INT,
    Subtotal DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);


-- Insert into tables

-- Authors
INSERT INTO Authors VALUES (1, 'J.K. Rowling', '1965-07-31', 'British');
INSERT INTO Authors VALUES (2, 'George R.R. Martin', '1948-09-20', 'American');

-- Books
INSERT INTO Books VALUES (1, "Harry Potter and the Sorcerer's Stone", '9780590353427', 'Fantasy', 24.99, 1);
INSERT INTO Books VALUES (2, 'A Game of Thrones', '9780553103540', 'Fantasy', 29.99, 2);

-- Customers
INSERT INTO Customers VALUES (1, 'John', 'Doe', 'john.doe@email.com', '123 Main St', '555-1234');

-- Orders
INSERT INTO Orders VALUES (1, 1, '2023-01-15', 54.98);

-- OrderDetails
INSERT INTO OrderDetails VALUES (1, 1, 1, 2, 49.98);



-- Queries

-- 1 Top-Selling Books:

SELECT Title, COUNT(BookID) AS SalesCount
FROM Books
JOIN OrderDetails ON Books.BookID = OrderDetails.BookID
GROUP BY Books.BookID
ORDER BY SalesCount DESC
LIMIT 10;

-- 2 Customer Purchase History
SELECT Customers.FirstName, Customers.LastName, Books.Title, OrderDetails.Quantity, OrderDetails.Subtotal, Orders.OrderDate
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Books ON OrderDetails.BookID = Books.BookID
WHERE Customers.CustomerID = [CustomerID];

-- 3 Total Sales By Genre

SELECT Books.Genre, SUM(OrderDetails.Subtotal) AS TotalSales
FROM Books
JOIN OrderDetails ON Books.BookID = OrderDetails.BookID
GROUP BY Books.Genre
ORDER BY TotalSales DESC;


-- 4
-- his advanced query provides insights into which authors
-- have generated the highest sales based on the sum of the
-- subtotals of their books across all orders.
SELECT
    Authors.AuthorID,
    Authors.AuthorName,
    SUM(OrderDetails.Subtotal) AS TotalSales
FROM
    Authors
JOIN
    Books ON Authors.AuthorID = Books.AuthorID
JOIN
    OrderDetails ON Books.BookID = OrderDetails.BookID
GROUP BY
    Authors.AuthorID, Authors.AuthorName
ORDER BY
    TotalSales DESC;





