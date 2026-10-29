/* ============================================================
   HOTEL MANAGEMENT SYSTEM
   SECTION 1 - DDL (Data Definition Language)
   Database: Oracle 11g
   ============================================================ */


-- 1. HOTEL TABLE
CREATE TABLE Hotel (
    Hotel_id NUMBER(5) PRIMARY KEY,
    Name VARCHAR2(50) NOT NULL,
    Location VARCHAR2(50) NOT NULL
);


-- 2. ROOMS TABLE
CREATE TABLE Rooms (
    Room_no NUMBER(5) PRIMARY KEY,
    Room_category VARCHAR2(50) NOT NULL,
    Hotel_id NUMBER(5) NOT NULL,
    FOREIGN KEY (Hotel_id) REFERENCES Hotel(Hotel_id)
);


-- 3. CUSTOMER TABLE
CREATE TABLE Customer (
    Guest_id NUMBER(5) PRIMARY KEY,
    Name VARCHAR2(50) NOT NULL,
    Phone_number NUMBER(10) UNIQUE,
    Email VARCHAR2(100) UNIQUE,
    Country VARCHAR2(50),
    SSN VARCHAR2(20) UNIQUE,
    Room_no NUMBER(5),
    Check_in_date DATE,
    Check_out_date DATE,
    FOREIGN KEY (Room_no) REFERENCES Rooms(Room_no)
);


-- 4. RESERVATION TABLE
CREATE TABLE Reservation (
    Reservation_id NUMBER(5) PRIMARY KEY,
    Guest_id NUMBER(5) NOT NULL,
    Room_no NUMBER(5) NOT NULL,
    Start_date DATE NOT NULL,
    End_date DATE NOT NULL,
    FOREIGN KEY (Guest_id) REFERENCES Customer(Guest_id),
    FOREIGN KEY (Room_no) REFERENCES Rooms(Room_no)
);


-- 5. TODAY_PRICE TABLE
CREATE TABLE Today_Price (
    Hotel_id NUMBER(5),
    Price NUMBER(10,2) NOT NULL,
    Available_rooms NUMBER(5) NOT NULL,
    Price_Date DATE,
    PRIMARY KEY (Hotel_id, Price_Date),
    FOREIGN KEY (Hotel_id) REFERENCES Hotel(Hotel_id)
);


-- 6. INVOICE TABLE
CREATE TABLE Invoice (
    Invoice_id NUMBER(5) PRIMARY KEY,
    Guest_id NUMBER(5) NOT NULL,
    Status VARCHAR2(30) NOT NULL,
    Invoice_description VARCHAR2(250),
    FOREIGN KEY (Guest_id) REFERENCES Customer(Guest_id)
);


-- 7. BILL TABLE
CREATE TABLE Bill (
    Bill_id NUMBER(5) PRIMARY KEY,
    Invoice_id NUMBER(5) NOT NULL,
    First_name VARCHAR2(50) NOT NULL,
    Last_name VARCHAR2(50) NOT NULL,
    Amount NUMBER(10,2) NOT NULL,
    Bill_date DATE NOT NULL,
    Type VARCHAR2(50),
    FOREIGN KEY (Invoice_id) REFERENCES Invoice(Invoice_id)
);


-- 8. LOGIN TABLE
CREATE TABLE Login (
    Login_id NUMBER(5) PRIMARY KEY,
    Guest_id NUMBER(5) NOT NULL,
    Username VARCHAR2(50) UNIQUE NOT NULL,
    Password VARCHAR2(255) NOT NULL,
    FOREIGN KEY (Guest_id) REFERENCES Customer(Guest_id)
);

/* ============================================================
   SECTION 2 - DML (Data Manipulation Language)
   ============================================================ */


-- ------------------------------------------------------------
-- 2.1 INSERT
-- ------------------------------------------------------------


-- 1. HOTEL TABLE
INSERT INTO Hotel VALUES (101, 'Grand Palace', 'Bangalore');
INSERT INTO Hotel VALUES (102, 'Royal Orchid', 'Mysore');
INSERT INTO Hotel VALUES (103, 'The Fern', 'Chennai');


-- 2. ROOMS TABLE
INSERT INTO Rooms VALUES (1001, 'Single', 101);
INSERT INTO Rooms VALUES (1002, 'Double', 101);
INSERT INTO Rooms VALUES (1003, 'Deluxe', 101);
INSERT INTO Rooms VALUES (1004, 'Suite', 101);
INSERT INTO Rooms VALUES (2001, 'Single', 102);
INSERT INTO Rooms VALUES (2002, 'Double', 102);
INSERT INTO Rooms VALUES (2003, 'Deluxe', 102);
INSERT INTO Rooms VALUES (2004, 'Suite', 102);
INSERT INTO Rooms VALUES (3001, 'Single', 103);
INSERT INTO Rooms VALUES (3002, 'Double', 103);
INSERT INTO Rooms VALUES (3003, 'Deluxe', 103);
INSERT INTO Rooms VALUES (3004, 'Suite', 103);


-- 3. CUSTOMER TABLE
INSERT INTO Customer VALUES (1, 'Arjun Sharma', 9876543210, 'arjun@gmail.com', 'India', 'SSN001', 1001, TO_DATE('05-09-2026','DD-MM-YYYY'), TO_DATE('08-09-2026','DD-MM-YYYY'));
INSERT INTO Customer VALUES (2, 'Priya Nair', 9876543211, 'priya@gmail.com', 'India', 'SSN002', 1002, TO_DATE('06-09-2026','DD-MM-YYYY'), TO_DATE('10-09-2026','DD-MM-YYYY'));
INSERT INTO Customer VALUES (3, 'Rahul Verma', 9876543212, 'rahul@gmail.com', 'India', 'SSN003', NULL, NULL, NULL);
INSERT INTO Customer VALUES (4, 'Emma Watson', 9876543213, 'emma@gmail.com', 'UK', 'SSN004', 2001, TO_DATE('04-09-2026','DD-MM-YYYY'), TO_DATE('07-09-2026','DD-MM-YYYY'));
INSERT INTO Customer VALUES (5, 'Daniel Lee', 9876543214, 'daniel@gmail.com', 'Singapore', 'SSN005', NULL, NULL, NULL);
INSERT INTO Customer VALUES (6, 'Sneha Reddy', 9876543215, 'sneha@gmail.com', 'India', 'SSN006', 3003, TO_DATE('05-09-2026','DD-MM-YYYY'), TO_DATE('09-09-2026','DD-MM-YYYY'));
INSERT INTO Customer VALUES (7, 'Michael Brown', 9876543216, 'michael@gmail.com', 'USA', 'SSN007', NULL, NULL, NULL);
INSERT INTO Customer VALUES (8, 'Ananya Iyer', 9876543217, 'ananya@gmail.com', 'India', 'SSN008', 2003, TO_DATE('06-09-2026','DD-MM-YYYY'), TO_DATE('11-09-2026','DD-MM-YYYY'));


-- 4. RESERVATION TABLE
INSERT INTO Reservation VALUES (501, 1, 1001, TO_DATE('05-09-2026','DD-MM-YYYY'), TO_DATE('08-09-2026','DD-MM-YYYY'));
INSERT INTO Reservation VALUES (502, 2, 1002, TO_DATE('06-09-2026','DD-MM-YYYY'), TO_DATE('10-09-2026','DD-MM-YYYY'));
INSERT INTO Reservation VALUES (503, 3, 2002, TO_DATE('12-09-2026','DD-MM-YYYY'), TO_DATE('15-09-2026','DD-MM-YYYY'));
INSERT INTO Reservation VALUES (504, 5, 3001, TO_DATE('15-09-2026','DD-MM-YYYY'), TO_DATE('18-09-2026','DD-MM-YYYY'));
INSERT INTO Reservation VALUES (505, 7, 1004, TO_DATE('20-09-2026','DD-MM-YYYY'), TO_DATE('25-09-2026','DD-MM-YYYY'));


-- 5. TODAY_PRICE TABLE
INSERT INTO Today_Price VALUES (101, 2500.00, 15, TO_DATE('06-09-2026','DD-MM-YYYY'));
INSERT INTO Today_Price VALUES (101, 2700.00, 13, TO_DATE('07-09-2026','DD-MM-YYYY'));
INSERT INTO Today_Price VALUES (102, 2200.00, 18, TO_DATE('06-09-2026','DD-MM-YYYY'));
INSERT INTO Today_Price VALUES (102, 2400.00, 16, TO_DATE('07-09-2026','DD-MM-YYYY'));
INSERT INTO Today_Price VALUES (103, 3000.00, 12, TO_DATE('06-09-2026','DD-MM-YYYY'));
INSERT INTO Today_Price VALUES (103, 3200.00, 10, TO_DATE('07-09-2026','DD-MM-YYYY'));


-- 6. INVOICE TABLE
INSERT INTO Invoice VALUES (10001, 1, 'Paid', 'Room charges for stay');
INSERT INTO Invoice VALUES (10002, 2, 'Pending', 'Room and service charges');
INSERT INTO Invoice VALUES (10003, 4, 'Paid', 'Room charges for stay');
INSERT INTO Invoice VALUES (10004, 6, 'Pending', 'Room charges and food');
INSERT INTO Invoice VALUES (10005, 8, 'Paid', 'Room charges');
INSERT INTO Invoice VALUES (10006, 3, 'Pending', 'Reservation charges');


-- 7. BILL TABLE
INSERT INTO Bill VALUES (9001, 10001, 'Arjun', 'Sharma', 7500.00, TO_DATE('08-09-2026','DD-MM-YYYY'), 'Room');
INSERT INTO Bill VALUES (9002, 10002, 'Priya', 'Nair', 10000.00, TO_DATE('10-09-2026','DD-MM-YYYY'), 'Room + Service');
INSERT INTO Bill VALUES (9003, 10003, 'Emma', 'Watson', 6600.00, TO_DATE('07-09-2026','DD-MM-YYYY'), 'Room');
INSERT INTO Bill VALUES (9004, 10004, 'Sneha', 'Reddy', 12000.00, TO_DATE('09-09-2026','DD-MM-YYYY'), 'Room + Food');
INSERT INTO Bill VALUES (9005, 10005, 'Ananya', 'Iyer', 15000.00, TO_DATE('11-09-2026','DD-MM-YYYY'), 'Room');
INSERT INTO Bill VALUES (9006, 10006, 'Rahul', 'Verma', 5000.00, TO_DATE('15-09-2026','DD-MM-YYYY'), 'Reservation');


-- 8. LOGIN TABLE
INSERT INTO Login VALUES (1, 1, 'arjun', 'Arjun@123');
INSERT INTO Login VALUES (2, 2, 'priya', 'Priya@123');
INSERT INTO Login VALUES (3, 3, 'rahul', 'Rahul@123');
INSERT INTO Login VALUES (4, 4, 'emma', 'Emma@123');
INSERT INTO Login VALUES (5, 5, 'daniel', 'Daniel@123');
INSERT INTO Login VALUES (6, 6, 'sneha', 'Sneha@123');

COMMIT;


-- ------------------------------------------------------------
-- 2.4 SELECT
-- ------------------------------------------------------------


-- Display all hotels
SELECT * FROM Hotel;


-- Display all customers
SELECT * FROM Customer;


-- Display all rooms
SELECT * FROM Rooms;


-- Display all reservations
SELECT * FROM Reservation;


-- Display all invoices
SELECT * FROM Invoice;


-- Display all bills
SELECT * FROM Bill;


-- Display today's prices
SELECT * FROM Today_Price;

/* ============================================================
   SECTION 3 - SQL CLAUSES
   ============================================================ */


-- ------------------------------------------------------------
-- 3.1 WHERE CLAUSE
-- ------------------------------------------------------------


SELECT * FROM Customer WHERE Country = 'India';


-- ------------------------------------------------------------
-- 3.2 AND CLAUSE
-- ------------------------------------------------------------


SELECT * FROM Customer WHERE Country = 'India' AND Room_no IS NOT NULL;


-- ------------------------------------------------------------
-- 3.3 OR CLAUSE
-- ------------------------------------------------------------


SELECT Guest_id, Name, Country FROM Customer WHERE Country = 'India' OR Country = 'UK';


-- ------------------------------------------------------------
-- 3.4 NOT CLAUSE
-- ------------------------------------------------------------


SELECT Guest_id, Name, Country FROM Customer WHERE NOT Country = 'India';


-- ------------------------------------------------------------
-- 3.5 DISTINCT CLAUSE
-- ------------------------------------------------------------


SELECT DISTINCT Country FROM Customer;


-- ------------------------------------------------------------
-- 3.6 ORDER BY CLAUSE
-- ------------------------------------------------------------


SELECT Bill_id, First_name, Last_name, Amount FROM Bill ORDER BY Amount DESC;


-- ------------------------------------------------------------
-- 3.7 BETWEEN CLAUSE
-- ------------------------------------------------------------


SELECT Bill_id, First_name, Last_name, Amount FROM Bill WHERE Amount BETWEEN 5000 AND 12000;


-- ------------------------------------------------------------
-- 3.8 IN CLAUSE
-- ------------------------------------------------------------


SELECT Guest_id, Name, Country FROM Customer WHERE Country IN ('India', 'UK', 'USA');


-- ------------------------------------------------------------
-- 3.9 LIKE CLAUSE
-- ------------------------------------------------------------


SELECT Guest_id, Name FROM Customer WHERE Name LIKE 'A%';


-- ------------------------------------------------------------
-- 3.10 IS NULL
-- ------------------------------------------------------------


SELECT Guest_id, Name, Room_no FROM Customer WHERE Room_no IS NULL;


-- ------------------------------------------------------------
-- 3.11 IS NOT NULL
-- ------------------------------------------------------------

SELECT Guest_id, Name, Room_no FROM Customer WHERE Room_no IS NOT NULL;


-- ------------------------------------------------------------
-- 3.12 GROUP BY CLAUSE
-- ------------------------------------------------------------


SELECT Country, COUNT(*) AS Number_of_Customers FROM Customer GROUP BY Country;


-- ------------------------------------------------------------
-- 3.13 HAVING CLAUSE
-- ------------------------------------------------------------


SELECT Country, COUNT(*) AS Number_of_Customers FROM Customer GROUP BY Country HAVING COUNT(*) > 1;


-- ------------------------------------------------------------
-- 3.14 CASE EXPRESSION
-- ------------------------------------------------------------


SELECT Bill_id, Amount, CASE WHEN Amount >= 10000 THEN 'High' WHEN Amount >= 7000 THEN 'Medium' ELSE 'Low' END AS Bill_Category FROM Bill;


-- ------------------------------------------------------------
-- 3.15 EXISTS
-- ------------------------------------------------------------


SELECT c.Guest_id, c.Name FROM Customer c WHERE EXISTS ( SELECT 1 FROM Invoice i WHERE i.Guest_id = c.Guest_id);


-- ------------------------------------------------------------
-- 3.16 ROWNUM
-- ------------------------------------------------------------


SELECT * FROM Customer WHERE ROWNUM <= 5;


-- ------------------------------------------------------------
-- 3.17 DECODE
-- ------------------------------------------------------------


SELECT Invoice_id, Status, DECODE(Status, 'Paid', 'Payment Completed', 'Pending', 'Payment Due', 'Other') AS Payment_Status FROM Invoice;


/* ============================================================
   SECTION 4 - AGGREGATE FUNCTIONS
   ============================================================ */


-- ------------------------------------------------------------
-- 4.1 COUNT()
-- ------------------------------------------------------------


SELECT COUNT(*) AS Total_Customers FROM Customer;


-- ------------------------------------------------------------
-- 4.2 COUNT() with condition
-- ------------------------------------------------------------


SELECT COUNT(Room_no) AS Customers_With_Room FROM Customer;


-- ------------------------------------------------------------
-- 4.3 SUM()
-- ------------------------------------------------------------


SELECT SUM(Amount) AS Total_Bill_Amount FROM Bill;


-- ------------------------------------------------------------
-- 4.4 AVG()
-- ------------------------------------------------------------


SELECT AVG(Amount) AS Average_Bill_Amount FROM Bill;


-- ------------------------------------------------------------
-- 4.5 MIN()
-- ------------------------------------------------------------


SELECT MIN(Amount) AS Minimum_Bill_Amount FROM Bill;


-- ------------------------------------------------------------
-- 4.6 MAX()
-- ------------------------------------------------------------


SELECT MAX(Amount) AS Maximum_Bill_Amount FROM Bill;


-- ------------------------------------------------------------
-- 4.7 Multiple aggregate functions
-- ------------------------------------------------------------


SELECT COUNT(*) AS Total_Bills, SUM(Amount) AS Total_Amount, AVG(Amount) AS Average_Amount, MIN(Amount) AS Minimum_Amount, MAX(Amount) AS Maximum_Amount FROM Bill;


-- ------------------------------------------------------------
-- 4.8 Aggregate function with GROUP BY
-- ------------------------------------------------------------


SELECT Type, COUNT(*) AS Number_of_Bills, SUM(Amount) AS Total_Amount FROM Bill GROUP BY Type;


-- ------------------------------------------------------------
-- 4.9 Aggregate function with GROUP BY and HAVING
-- ------------------------------------------------------------


SELECT Type, SUM(Amount) AS Total_Amount FROM Bill GROUP BY Type HAVING SUM(Amount) > 10000;


-- ------------------------------------------------------------
-- 4.10 Aggregate function on Today_Price
-- ------------------------------------------------------------


SELECT Hotel_id, AVG(Price) AS Average_Price FROM Today_Price GROUP BY Hotel_id;


/* ============================================================
   SECTION 5 - JOINS
   ============================================================ */


-- ------------------------------------------------------------
-- 5.1 INNER JOIN
-- ------------------------------------------------------------


SELECT h.Hotel_id, h.Name AS Hotel_Name, h.Location, r.Room_no, r.Room_category FROM Hotel h INNER JOIN Rooms r ON h.Hotel_id = r.Hotel_id;


-- ------------------------------------------------------------
-- 5.2 LEFT JOIN
-- ------------------------------------------------------------


SELECT h.Hotel_id, h.Name AS Hotel_Name, r.Room_no, r.Room_category FROM Hotel h LEFT JOIN Rooms r ON h.Hotel_id = r.Hotel_id;


-- ------------------------------------------------------------
-- 5.3 RIGHT JOIN
-- ------------------------------------------------------------


SELECT h.Hotel_id, h.Name AS Hotel_Name, r.Room_no, r.Room_category FROM Rooms r RIGHT JOIN Hotel h ON r.Hotel_id = h.Hotel_id;


-- ------------------------------------------------------------
-- 5.4 FULL OUTER JOIN
-- ------------------------------------------------------------


SELECT h.Hotel_id, h.Name AS Hotel_Name, r.Room_no, r.Room_category FROM Hotel h FULL OUTER JOIN Rooms r ON h.Hotel_id = r.Hotel_id;


-- ------------------------------------------------------------
-- 5.5 JOIN using USING clause
-- ------------------------------------------------------------


SELECT Hotel_id, Name, Location, Room_no, Room_category FROM Hotel JOIN Rooms USING (Hotel_id);


-- ------------------------------------------------------------
-- 5.6 THREE-TABLE JOIN
-- ------------------------------------------------------------


SELECT c.Guest_id, c.Name AS Customer_Name, res.Reservation_id, res.Start_date, res.End_date, r.Room_no, r.Room_category FROM Customer c INNER JOIN Reservation res ON c.Guest_id = res.Guest_id INNER JOIN Rooms r ON res.Room_no = r.Room_no;


-- ------------------------------------------------------------
-- 5.7 CUSTOMER + INVOICE JOIN
-- ------------------------------------------------------------


SELECT c.Guest_id, c.Name AS Customer_Name, i.Invoice_id, i.Status, i.Invoice_description FROM Customer c INNER JOIN Invoice i ON c.Guest_id = i.Guest_id;


-- ------------------------------------------------------------
-- 5.8 INVOICE + BILL JOIN
-- ------------------------------------------------------------


SELECT i.Invoice_id, i.Status, b.Bill_id, b.First_name, b.Last_name, b.Amount, b.Type FROM Invoice i INNER JOIN Bill b ON i.Invoice_id = b.Invoice_id;


-- ------------------------------------------------------------
-- 5.9 THREE-TABLE JOIN
-- ------------------------------------------------------------


SELECT c.Guest_id, c.Name AS Customer_Name, i.Invoice_id, i.Status, b.Bill_id, b.Amount, b.Bill_date FROM Customer c INNER JOIN Invoice i ON c.Guest_id = i.Guest_id INNER JOIN Bill b ON i.Invoice_id = b.Invoice_id;


-- ------------------------------------------------------------
-- 5.10 HOTEL + TODAY_PRICE JOIN
-- ------------------------------------------------------------


SELECT h.Hotel_id,
       h.Name AS Hotel_Name,
       h.Location,
       t.Price_Date,
       t.Price,
       t.Available_rooms
FROM Hotel h
INNER JOIN Today_Price t
ON h.Hotel_id = t.Hotel_id;

/* ============================================================
   SECTION 6 - VIEWS
   ============================================================ */


-- ------------------------------------------------------------
-- 6.1 CUSTOMER ROOM VIEW
-- ------------------------------------------------------------


CREATE OR REPLACE VIEW Customer_Room_View AS
SELECT c.Guest_id,
       c.Name AS Customer_Name,
       c.Country,
       r.Room_no,
       r.Room_category,
       h.Name AS Hotel_Name,
       h.Location
FROM Customer c
LEFT JOIN Rooms r
ON c.Room_no = r.Room_no
LEFT JOIN Hotel h
ON r.Hotel_id = h.Hotel_id;


-- Display the view
SELECT *
FROM Customer_Room_View;


-- ------------------------------------------------------------
-- 6.2 CUSTOMER INVOICE BILL VIEW
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW Customer_Invoice_Bill_View AS
SELECT c.Guest_id,
       c.Name AS Customer_Name,
       i.Invoice_id,
       i.Status,
       b.Bill_id,
       b.Amount,
       b.Bill_date,
       b.Type
FROM Customer c
INNER JOIN Invoice i
ON c.Guest_id = i.Guest_id
LEFT JOIN Bill b
ON i.Invoice_id = b.Invoice_id;


-- Display the view
SELECT *
FROM Customer_Invoice_Bill_View;


-- ------------------------------------------------------------
-- 6.3 HOTEL ROOM VIEW
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW Hotel_Room_View AS
SELECT h.Hotel_id,
       h.Name AS Hotel_Name,
       h.Location,
       r.Room_no,
       r.Room_category
FROM Hotel h
LEFT JOIN Rooms r
ON h.Hotel_id = r.Hotel_id;


-- Display the view
SELECT *
FROM Hotel_Room_View;

/* ============================================================
   SECTION 7 - TRIGGERS
   ============================================================ */


-- ------------------------------------------------------------
-- 7.1 CUSTOMER DATE VALIDATION TRIGGER
-- ------------------------------------------------------------

CREATE OR REPLACE TRIGGER check_customer_dates
BEFORE INSERT OR UPDATE ON Customer
FOR EACH ROW
BEGIN
    IF :NEW.Check_in_date IS NOT NULL
       AND :NEW.Check_out_date IS NOT NULL THEN

        IF :NEW.Check_out_date < :NEW.Check_in_date THEN
            RAISE_APPLICATION_ERROR(
                -20001,
                'Check-out date cannot be earlier than check-in date'
            );
        END IF;

    END IF;
END;
/

create or replace trigger reservation_dates
before insert or update on Reservation
for each row
begin
    if :new.End_date < :new.Start_date then
        raise_application_error(-200012, 'Reservation end date cannot be earlier than the start date');
    end if;
end;
/

create or replace trigger today_price_val
before insert or update on Today_Price
for each row
begin
    if :new.Price < 0 then
        raise_application_error(-20003, 'Hotel price cannot be negative');
    end if;
    if :new.Available_rooms < 0 then
        raise_application_error(-20004, 'Available rooms count cannot be negative');
    end if;
end;
/

create or replace trigger bill_amount_val
before insert or update on Bill
for each row
begin
    if :new.Amount < 0 then
        raise_application_error(-20005, 'Bill amount cannot be negative');
    end if;
end;
/

/* ============================================================
   SECTION 8 - CURSOR
   ============================================================ */


-- ------------------------------------------------------------
-- 8.1 EXPLICIT CURSOR
-- ------------------------------------------------------------

SET SERVEROUTPUT ON;

DECLARE

    CURSOR customer_cursor IS
        SELECT Guest_id, Name, Country
        FROM Customer
        ORDER BY Guest_id;

    v_guest_id Customer.Guest_id%TYPE;
    v_name     Customer.Name%TYPE;
    v_country  Customer.Country%TYPE;

BEGIN

    OPEN customer_cursor;

    LOOP

        FETCH customer_cursor
        INTO v_guest_id, v_name, v_country;

        EXIT WHEN customer_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Guest ID: ' || v_guest_id ||
            ' | Name: ' || v_name ||
            ' | Country: ' || v_country
        );

    END LOOP;

    CLOSE customer_cursor;

END;
/

/* ============================================================
   SECTION 9 - DCL (Data Control Language)
   ============================================================ */


-- ------------------------------------------------------------
-- 9.1 GRANT
-- ------------------------------------------------------------

GRANT SELECT
ON Hotel
TO hotel_management_system;


-- ------------------------------------------------------------
-- 9.2 REVOKE
-- ------------------------------------------------------------

REVOKE SELECT
ON Hotel
FROM hotel_management_system;


/* ============================================================
   SECTION 10 - TCL (Transaction Control Language)
   ============================================================ */


-- ------------------------------------------------------------
-- 10.1 SAVEPOINT
-- ------------------------------------------------------------

INSERT INTO Hotel
(Hotel_id, Name, Location)
VALUES
(999, 'TCL Test Hotel', 'Test Location');


-- Create a savepoint
SAVEPOINT hotel_insert;


-- Make a change after the savepoint
UPDATE Hotel
SET Location = 'Updated Test Location'
WHERE Hotel_id = 999;


-- Display the updated record
SELECT *
FROM Hotel
WHERE Hotel_id = 999;


-- ------------------------------------------------------------
-- 10.2 ROLLBACK TO SAVEPOINT
-- ------------------------------------------------------------

ROLLBACK TO hotel_insert;


-- ------------------------------------------------------------
-- 10.3 ROLLBACK
-- ------------------------------------------------------------

ROLLBACK;