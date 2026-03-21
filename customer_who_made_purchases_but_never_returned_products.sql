-- Create Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

-- Create Orders/Purchases Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

-- Create Returns Table
CREATE TABLE Returns (
    return_id INT PRIMARY KEY,
    order_id INT,
    return_date DATE
);

-- Insert Sample Data into Customers
-- Alice & Charlie will be our target (purchased, no returns).
-- Bob returned an item. David never bought anything.
INSERT INTO Customers (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

-- Insert Sample Data into Orders
INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(101, 1, '2023-01-15'), -- Alice bought
(102, 2, '2023-01-20'), -- Bob bought
(103, 2, '2023-02-05'), -- Bob bought again
(104, 3, '2023-02-10'); -- Charlie bought

-- Insert Sample Data into Returns
INSERT INTO Returns (return_id, order_id, return_date) VALUES
(501, 102, '2023-01-25'); -- Bob returned his first order


select * from Customers;
select * from Orders;
select * from Returns;

with customers_orders as (
  select c.customer_id, c.customer_name, o.order_id
  from Customers c
  join Orders o on c.customer_id = o.customer_id
)
select co.customer_id, co.customer_name
from customers_orders co 
left join Returns r on co.order_id = r.order_id
where return_id is null;
