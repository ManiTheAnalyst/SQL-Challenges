-- 1. Create the Departments table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- 2. Create the Employees table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    job_title VARCHAR(50),
    department_id INT
);

-- 3. Insert sample departments
INSERT INTO Departments (department_id, department_name) VALUES
(1, 'FinOps'),
(2, 'Analytics'),
(3, 'Retail');

-- 4. Insert sample employees
-- Notice Kabir has a NULL department, and Ananya has a department_id (99) that doesn't exist.
INSERT INTO Employees (employee_id, employee_name, job_title, department_id) VALUES
(101, 'Aarav', 'Financial Analyst I', 1),
(102, 'Meera', 'Data Analyst', 2),
(103, 'Kabir', 'Risk Expert', NULL), 
(104, 'Ananya', 'Business Analyst', 99), 
(105, 'Rahul', 'Operations Manager', 3);

-- Option 1: Using Left Join and Null

select e.employee_id,
    e.employee_name,
    e.job_title,
    d.department_id
from Employees e
left join Departments d on e.department_id = d.department_id
where d.department_id is NULL;


---- Option 2: NOT EXISTS Subquery
--Order of Execution from (Get all employees) ➡️ where (Filter them using the subquery) ➡️ select (Show only the requested columns for the remaining employees).

select 
    employee_id,
    employee_name,
    job_title
from Employees e
where not exists (
    select 1 
    from Departments d 
    where d.department_id = e.department_id
);
