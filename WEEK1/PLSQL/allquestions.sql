/* =====================================================
   DATABASE SCHEMA
===================================================== */

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    IsVIP VARCHAR2(5),
    LastModified DATE
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(20),
    FOREIGN KEY (AccountID)
    REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);

CREATE TABLE AuditLog (
    LogID NUMBER GENERATED ALWAYS AS IDENTITY,
    TransactionID NUMBER,
    LogDate DATE
);

/* =====================================================
   SAMPLE DATA
===================================================== */

INSERT INTO Customers VALUES
(1,'John Doe',DATE '1955-05-15',15000,'FALSE',SYSDATE);

INSERT INTO Customers VALUES
(2,'Jane Smith',DATE '1990-07-20',5000,'FALSE',SYSDATE);

INSERT INTO Accounts VALUES
(1,1,'Savings',15000,SYSDATE);

INSERT INTO Accounts VALUES
(2,2,'Checking',5000,SYSDATE);

INSERT INTO Loans VALUES
(1,1,5000,5,SYSDATE,ADD_MONTHS(SYSDATE,12));

INSERT INTO Employees VALUES
(1,'Alice Johnson','Manager',70000,'HR',DATE '2015-06-15');

INSERT INTO Employees VALUES
(2,'Bob Brown','Developer',60000,'IT',DATE '2017-03-20');

COMMIT;

/* =====================================================
   EXERCISE 1 : CONTROL STRUCTURES
===================================================== */

DECLARE
CURSOR c IS
SELECT CustomerID,DOB
FROM Customers;

v_age NUMBER;
BEGIN

FOR r IN c LOOP

v_age :=
TRUNC(MONTHS_BETWEEN(
SYSDATE,
r.DOB)/12);

IF v_age > 60 THEN

UPDATE Loans
SET InterestRate=
InterestRate-1
WHERE CustomerID=
r.CustomerID;

END IF;

END LOOP;

COMMIT;

END;
/


BEGIN

FOR r IN (
SELECT CustomerID,
Balance
FROM Customers
)
LOOP

IF r.Balance > 10000 THEN

UPDATE Customers
SET IsVIP='TRUE'
WHERE CustomerID=
r.CustomerID;

END IF;

END LOOP;

COMMIT;

END;
/

BEGIN

FOR r IN
(
SELECT c.Name,
l.EndDate
FROM Customers c
JOIN Loans l
ON c.CustomerID=
l.CustomerID
WHERE l.EndDate
<= SYSDATE+30
)
LOOP

DBMS_OUTPUT.PUT_LINE(
'Reminder for '
|| r.Name
);

END LOOP;

END;
/


/* =====================================================
   EXERCISE 2 : ERROR HANDLING
===================================================== */

CREATE OR REPLACE PROCEDURE
SafeTransferFunds(
p_from NUMBER,
p_to NUMBER,
p_amount NUMBER
)
IS
v_balance NUMBER;
BEGIN

SELECT Balance
INTO v_balance
FROM Accounts
WHERE AccountID=p_from;

IF v_balance < p_amount THEN
RAISE_APPLICATION_ERROR(
-20001,
'Insufficient Funds'
);
END IF;

UPDATE Accounts
SET Balance=
Balance-p_amount
WHERE AccountID=p_from;

UPDATE Accounts
SET Balance=
Balance+p_amount
WHERE AccountID=p_to;

COMMIT;

EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
DBMS_OUTPUT.PUT_LINE(SQLERRM);

END;
/



CREATE OR REPLACE PROCEDURE
UpdateSalary(
p_empid NUMBER,
p_percent NUMBER
)
IS
BEGIN

UPDATE Employees
SET Salary=
Salary+
(Salary*p_percent/100)
WHERE EmployeeID=
p_empid;

IF SQL%ROWCOUNT=0 THEN
RAISE NO_DATA_FOUND;
END IF;

EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE(
'Employee Not Found'
);

END;
/




CREATE OR REPLACE PROCEDURE
AddNewCustomer(
p_id NUMBER,
p_name VARCHAR2
)
IS
BEGIN

INSERT INTO Customers(
CustomerID,
Name
)
VALUES(
p_id,
p_name
);

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN

DBMS_OUTPUT.PUT_LINE(
'Customer Already Exists'
);

END;
/




/* =====================================================
   EXERCISE 3 : STORED PROCEDURES
===================================================== */


CREATE OR REPLACE PROCEDURE
ProcessMonthlyInterest
IS
BEGIN

UPDATE Accounts
SET Balance=
Balance+(Balance*0.01)
WHERE AccountType='Savings';

COMMIT;

END;
/



CREATE OR REPLACE PROCEDURE
UpdateEmployeeBonus(
p_dept VARCHAR2,
p_bonus NUMBER
)
IS
BEGIN

UPDATE Employees
SET Salary=
Salary+(Salary*p_bonus/100)
WHERE Department=p_dept;

COMMIT;

END;
/





CREATE OR REPLACE PROCEDURE
TransferFunds(
p_from NUMBER,
p_to NUMBER,
p_amt NUMBER
)
IS
v_bal NUMBER;
BEGIN

SELECT Balance
INTO v_bal
FROM Accounts
WHERE AccountID=p_from;

IF v_bal >= p_amt THEN

UPDATE Accounts
SET Balance=
Balance-p_amt
WHERE AccountID=p_from;

UPDATE Accounts
SET Balance=
Balance+p_amt
WHERE AccountID=p_to;

END IF;

COMMIT;

END;
/





/* =====================================================
   EXERCISE 4 : FUNCTIONS
===================================================== */




CREATE OR REPLACE FUNCTION
CalculateAge(
p_dob DATE
)
RETURN NUMBER
IS
BEGIN
RETURN TRUNC(
MONTHS_BETWEEN(
SYSDATE,
p_dob
)/12
);
END;
/





CREATE OR REPLACE FUNCTION
CalculateMonthlyInstallment(
p_amount NUMBER,
p_rate NUMBER,
p_years NUMBER
)
RETURN NUMBER
IS
BEGIN

RETURN
(p_amount+
(p_amount*p_rate/100))
/
(p_years*12);

END;
/



CREATE OR REPLACE FUNCTION
HasSufficientBalance(
p_acc NUMBER,
p_amt NUMBER
)
RETURN VARCHAR2
IS
v_bal NUMBER;
BEGIN

SELECT Balance
INTO v_bal
FROM Accounts
WHERE AccountID=p_acc;

IF v_bal >= p_amt THEN
RETURN 'TRUE';
ELSE
RETURN 'FALSE';
END IF;

END;
/




/* =====================================================
   EXERCISE 5 : TRIGGERS
===================================================== */


CREATE OR REPLACE TRIGGER
UpdateCustomerLastModified
BEFORE UPDATE
ON Customers
FOR EACH ROW
BEGIN
:NEW.LastModified:=SYSDATE;
END;
/



CREATE OR REPLACE TRIGGER
LogTransaction
AFTER INSERT
ON Transactions
FOR EACH ROW
BEGIN

INSERT INTO AuditLog(
TransactionID,
LogDate
)
VALUES(
:NEW.TransactionID,
SYSDATE
);

END;
/




CREATE OR REPLACE TRIGGER
CheckTransactionRules
BEFORE INSERT
ON Transactions
FOR EACH ROW
DECLARE
v_bal NUMBER;
BEGIN

SELECT Balance
INTO v_bal
FROM Accounts
WHERE AccountID=
:NEW.AccountID;

IF :NEW.TransactionType=
'Withdrawal'
AND
:NEW.Amount > v_bal
THEN

RAISE_APPLICATION_ERROR(
-20002,
'Insufficient Balance'
);

END IF;

END;
/




/* =====================================================
   EXERCISE 6 : CURSORS
===================================================== */





DECLARE
CURSOR c IS
SELECT *
FROM Transactions;

BEGIN

FOR r IN c LOOP

DBMS_OUTPUT.PUT_LINE(
r.TransactionID
||' '
||r.Amount
);

END LOOP;

END;
/




DECLARE
CURSOR c IS
SELECT AccountID
FROM Accounts;

BEGIN

FOR r IN c LOOP

UPDATE Accounts
SET Balance=
Balance-100
WHERE AccountID=
r.AccountID;

END LOOP;

COMMIT;

END;
/




DECLARE
CURSOR c IS
SELECT LoanID
FROM Loans;

BEGIN

FOR r IN c LOOP

UPDATE Loans
SET InterestRate=
InterestRate+0.5
WHERE LoanID=
r.LoanID;

END LOOP;

COMMIT;

END;
/






/* =====================================================
   EXERCISE 7 : PACKAGES
===================================================== */




CREATE OR REPLACE PACKAGE
CustomerManagement
AS

PROCEDURE AddCustomer(
p_id NUMBER,
p_name VARCHAR2
);

PROCEDURE UpdateCustomer(
p_id NUMBER,
p_name VARCHAR2
);

FUNCTION GetBalance(
p_id NUMBER
)
RETURN NUMBER;

END;
/



CREATE OR REPLACE PACKAGE BODY
CustomerManagement
AS

PROCEDURE AddCustomer(
p_id NUMBER,
p_name VARCHAR2
)
IS
BEGIN

INSERT INTO Customers(
CustomerID,
Name
)
VALUES(
p_id,
p_name
);

END;

PROCEDURE UpdateCustomer(
p_id NUMBER,
p_name VARCHAR2
)
IS
BEGIN

UPDATE Customers
SET Name=p_name
WHERE CustomerID=p_id;

END;

FUNCTION GetBalance(
p_id NUMBER
)
RETURN NUMBER
IS
v_bal NUMBER;
BEGIN

SELECT Balance
INTO v_bal
FROM Customers
WHERE CustomerID=p_id;

RETURN v_bal;

END;

END;
/






