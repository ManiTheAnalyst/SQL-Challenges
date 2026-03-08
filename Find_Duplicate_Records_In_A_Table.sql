-- Create the table
CREATE TABLE Employees (
    EmployeeID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100)
);

-- Insert sample data (Notice the duplicates for John Doe and Jane Smith)
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email)
VALUES 
    (1, 'John', 'Doe', 'johndoe@email.com'),
    (2, 'Jane', 'Smith', 'janesmith@email.com'),
    (3, 'Michael', 'Johnson', 'michaelj@email.com'),
    (4, 'John', 'Doe', 'johndoe@email.com'),     -- Duplicate!
    (5, 'Emily', 'Davis', 'emilyd@email.com'),
    (6, 'Jane', 'Smith', 'janesmith@email.com'),   -- Duplicate!
    (7, 'Sarah', 'Wilson', 'sarahw@email.com');
    
-- To Finding Duplicates Based on a Single Column
select Email, count(*) as duplicate_count
from Employees
group by 1
having count(*) > 1;
    
-- To Find Duplicates Based on Multiple Columns
select FirstName, LastName, count(*) as duplicate_count
from Employees
group by 1,2
having count(*) > 1;

-- To Viewthe Entire Duplicate Records using window function

-- Option 1:
-- using row_number Function using CTE
with duplicate_cte as (
select *, row_number() over(partition by email order by EmployeeID) as rn
from employees
  )
select * from duplicate_cte where rn >1;
    
-- Option 2 
-- using qualify function which is specifically designed to filter the results of Window Functions
select *
from employees
qualify  row_number() over(partition by email order by EmployeeID) >1;
    