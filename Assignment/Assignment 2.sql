CREATE DATABASE office_work;
USE office_work;

CREATE TABLE Departments (
  Code INTEGER PRIMARY KEY,
  Name varchar(255) NOT NULL ,
  Budget decimal NOT NULL 
);

CREATE TABLE Employees (
  SSN INTEGER PRIMARY KEY,
  Name varchar(255) NOT NULL ,
  LastName varchar(255) NOT NULL ,
  Department INTEGER NOT NULL , 
  foreign key (department) references Departments(Code) 
);

INSERT INTO Departments(Code,Name,Budget) VALUES
(14,"IT",65000),
(37,"Accounting",15000),
(59,"Human Resources",240000),
(77,"Research",55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES
('123234877','Michael','Rogers',14),
('152934485','Anand','Manikutty',14),
('222364883','Carol','Smith',37),
('326587417','Joe','Stevens',37),
('332154719','Mary-Anne','Foster',14),
('332569843','George','ODonnell',77),
('546523478','John','Doe',59),
('631231482','David','Smith',77),
('654873219','Zacary','Efron',59),
('745685214','Eric','Goldsmith',59),
('845657245','Elizabeth','Doe',14),
('845657246','Kumar','Swamy',14);

-- 2.1 Select the last name of all employees.
SELECT Lastname from employees;

-- 2.2 Select the last name of all employees, without duplicates.
select distinct lastname from employees;

-- 2.3 Select all the data of employees whose last name is "Smith".
select * from employees
where lastname = "Smith";

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
select * from employees
where lastname in ("Smith", "doe");

-- 2.5 Select all the data of employees that work in department 14.
SELECT * FROM Employees 
where department = 14;

-- 2.6 Select all the data of employees that work in department 37 or department 77.
SELECT * FROM Employees 
where department = 37 or department = 77;

-- 2.7 Select all the data of employees whose last name begins with an "S".
SELECT * FROM Employees
WHERE lastname like "s%";

-- 2.8 Select the sum of all the departments' budgets.
SELECT SUM(Budget)
FROM Departments;

-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
SELECT department, count(*)
FROM Employees
GROUP BY department;

-- 2.10 Select all the data of employees, including each employee's department's data.
SELECT * from Employees left join Departments on Employees.Department = Departments.code;

-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
SELECT Employees.name, Employees.lastname, Departments.Name, Departments.Budget FROM Employees
INNER JOIN Departments on Employees.Department = Departments.code;

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
SELECT  Employees.name, Employees.lastname, Departments.Budget > 60000 FROM Employees
INNER JOIN Departments on Employees.Department = Departments.code;

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
SELECT * FROM Departments
  WHERE Budget >
  (SELECT AVG(Budget)
    FROM Departments);

-- 2.14 Select the names of departments with more than two employees.
SELECT D.Name FROM Departments D
  WHERE 2 < 
  (SELECT COUNT(*) FROM Employees
     WHERE Department = D.Code);

-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.
SELECT Employees.name, Employees.lastname from Employees
where Employees.Department = (SELECT sub.Code FROM   
(SELECT * FROM Departments d ORDER BY d.budget LIMIT 2) sub 
       ORDER BY budget DESC LIMIT 1);

-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
INSERT INTO Departments(Code,Name,Budget) 
VALUES
(11, "Quality Assurance", 40000);

-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
INSERT INTO Employees(SSN,Name,LastName,Department) 
VALUES
(847219811, "mary", "moore", 11);

-- 2.17 Reduce the budget of all departments by 10%.
set sql_safe_updates = 0;
update Departments 
set Budget = 0.9 * Budget;

-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
UPDATE Employees SET Department = 14 WHERE Department = 77;

-- 2.19 Delete from the table all employees in the IT department (code 14).
DELETE FROM Employees
  WHERE Department = 14;
  
-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
DELETE FROM Employees
  WHERE Department IN
  (SELECT Code FROM Departments
      WHERE Budget >= 60000);

-- 2.21 Delete from the table all employees.
DELETE FROM Employees;


