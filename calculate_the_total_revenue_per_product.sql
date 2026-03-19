-- Create the Sales table
CREATE TABLE Sales (
    order_id INT,
    product_name VARCHAR(50),
    quantity_sold INT,
    unit_price DECIMAL(10, 2)
);

-- Insert sample data
INSERT INTO Sales (order_id, product_name, quantity_sold, unit_price) VALUES
(1, 'Laptop', 2, 1200.00),
(2, 'Smartphone', 5, 800.00),
(3, 'Headphones', 10, 150.00),
(4, 'Laptop', 1, 1200.00),
(5, 'Smartphone', 3, 800.00),
(6, 'Tablet', 4, 300.00),
(7, 'Headphones', 2, 150.00);


-- Option 1 : Using Sum as normal approach
select 
	product_name, 
    sum(quantity_sold * unit_price) as total_revenue
from Sales
group by product_name
order by product_name desc;

-- Option 2 : Using Window Function sum() over(partition by)
select distinct product_name, 
	sum(quantity_sold * unit_price) over(partition by product_name) as total_revenue
from Sales
order by total_revenue desc;
