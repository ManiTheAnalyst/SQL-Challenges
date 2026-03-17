-- Create the table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Insert sample data (Notice the duplicates for Alice and Charlie)
INSERT INTO employees (emp_id, name, salary) VALUES
(1, 'Alice', 95000),
(2, 'Bob', 80000),
(3, 'Charlie', 95000), -- Duplicate high salary to test distinct logic
(4, 'David', 75000),
(5, 'Eve', 85000);

-- Option 1: nested subquery approach
select max(salary) as second_highest_salary
from employees
where salary < ( 
    -- filters out the top salary to retrieve the highest remaining value 
    select max(salary) -- identify the absolute maximum salary to use as a filter boundary
    from employees  
);

-- Option 2: using offset & limit
select distinct salary -- excludes duplicate values to find the distinct second-highest
from employees
order by salary desc
limit 1                -- restricts the output to a single record
offset 1;              -- bypasses the top salary to retrieve the second-highest


-- Option 3: using window function dense_rank in cte
with ranked_employees as (
    select 
        salary, 
        dense_rank() over(order by salary desc) as rnk 
    from employees
) 
select distinct salary -- excludes duplicate values to find the distinct
from ranked_employees
where rnk = 2;

-- Option 4: using the qualify clause which allows us to filter on the results of a window function directly
select distinct salary
from employees
qualify dense_rank() over(order by salary desc) = 2;
