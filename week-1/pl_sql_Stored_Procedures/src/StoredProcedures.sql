----------------------------------------------------
-- Exercise 3 : Stored Procedures
----------------------------------------------------

-- Drop tables if they already exist
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Accounts';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE Employees';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

----------------------------------------------------
-- Create Accounts Table
----------------------------------------------------

CREATE TABLE Accounts (
                          AccountID NUMBER PRIMARY KEY,
                          CustomerName VARCHAR2(50),
                          AccountType VARCHAR2(20),
                          Balance NUMBER
);

----------------------------------------------------
-- Create Employees Table
----------------------------------------------------

CREATE TABLE Employees (
                           EmployeeID NUMBER PRIMARY KEY,
                           EmployeeName VARCHAR2(50),
                           Department VARCHAR2(30),
                           Salary NUMBER
);

----------------------------------------------------
-- Insert Sample Accounts
----------------------------------------------------

INSERT INTO Accounts VALUES (101,'John','Savings',10000);
INSERT INTO Accounts VALUES (102,'Alice','Savings',15000);
INSERT INTO Accounts VALUES (103,'David','Current',20000);
INSERT INTO Accounts VALUES (104,'Emma','Savings',8000);

----------------------------------------------------
-- Insert Sample Employees
----------------------------------------------------

INSERT INTO Employees VALUES (1,'Rahul','IT',50000);
INSERT INTO Employees VALUES (2,'Priya','HR',45000);
INSERT INTO Employees VALUES (3,'Amit','IT',60000);
INSERT INTO Employees VALUES (4,'Sneha','Finance',55000);

COMMIT;

----------------------------------------------------
-- Scenario 1
-- Process Monthly Interest
----------------------------------------------------

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
AS
BEGIN
UPDATE Accounts
SET Balance = Balance + (Balance * 0.01)
WHERE AccountType = 'Savings';

COMMIT;

DBMS_OUTPUT.PUT_LINE('Monthly interest applied successfully.');
END;
/
----------------------------------------------------
-- Scenario 2
-- Update Employee Bonus
----------------------------------------------------

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_department IN VARCHAR2,
    p_bonus IN NUMBER
)
AS
BEGIN
UPDATE Employees
SET Salary = Salary + (Salary * p_bonus / 100)
WHERE Department = p_department;

COMMIT;

DBMS_OUTPUT.PUT_LINE('Bonus updated successfully.');
END;
/
----------------------------------------------------
-- Scenario 3
-- Transfer Funds
----------------------------------------------------

CREATE OR REPLACE PROCEDURE TransferFunds(
    p_fromAccount IN NUMBER,
    p_toAccount IN NUMBER,
    p_amount IN NUMBER
)
AS
    v_balance NUMBER;
BEGIN

SELECT Balance
INTO v_balance
FROM Accounts
WHERE AccountID = p_fromAccount;

IF v_balance >= p_amount THEN

UPDATE Accounts
SET Balance = Balance - p_amount
WHERE AccountID = p_fromAccount;

UPDATE Accounts
SET Balance = Balance + p_amount
WHERE AccountID = p_toAccount;

COMMIT;

DBMS_OUTPUT.PUT_LINE('Fund transfer successful.');

ELSE

        DBMS_OUTPUT.PUT_LINE('Insufficient Balance.');

END IF;

END;
/
----------------------------------------------------
-- Execute Procedures
----------------------------------------------------

BEGIN
    ProcessMonthlyInterest;
END;
/

BEGIN
    UpdateEmployeeBonus('IT',10);
END;
/

BEGIN
    TransferFunds(101,102,2000);
END;
/

----------------------------------------------------
-- Display Updated Tables
----------------------------------------------------

SELECT * FROM Accounts;

SELECT * FROM Employees;