-- =========================
-- DROP OLD TABLES
-- =========================
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Salesman;

-- =========================
-- CREATE TABLES
-- =========================
CREATE TABLE Salesman(
  Salesman_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  city TEXT NOT NULL,
  commission REAL NOT NULL
);

CREATE TABLE Customer(
  customer_id TEXT PRIMARY KEY,
  cust_name TEXT NOT NULL,
  city TEXT NOT NULL,
  grade INTEGER,
  Salesman_id TEXT,
  FOREIGN KEY (Salesman_id) REFERENCES Salesman(Salesman_id)
);

CREATE TABLE Orders(
  ord_no TEXT PRIMARY KEY,
  purch_amt REAL NOT NULL,
  ord_date TEXT NOT NULL,
  customer_id TEXT,
  Salesman_id TEXT,
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
  FOREIGN KEY (Salesman_id) REFERENCES Salesman(Salesman_id)
);

-- =========================
-- INSERT DATA
-- =========================
INSERT INTO Salesman VALUES
("5001","James Hoog","new york",0.15),
("5002","Nail Knite","paris",0.13),
("5005","Pit Alex","london",0.11),
("5006","Mc Lyon","paris",0.14),
("5007","Paul Adam","rome",0.13),
("5003","Lauson Hen","san jose",0.12);

INSERT INTO Customer VALUES
("3002","nick rimando","new york",100,"5001"),
("3007","brad davis","new york",200,"5001"),
("3005","graham zusi","california",200,"5002"),
("3008","julian green","london",300,"5002"),
("3004","fabian johnson","paris",300,"5006"),
("3009","geoff cameron","berlin",100,"5003"),
("3003","jozy altidor","moscow",200,"5007"),
("3001","brad guzan","london",NULL,"5005");

INSERT INTO Orders VALUES
("70001",150.5,"2012-10-05","3005","5002"),
("70009",270.65,"2012-09-10","3001","5001"),
("70002",65.26,"2012-10-05","3002","5003"),
("70004",110.5,"2012-08-17","3009","5007"),
("70007",948.5,"2012-09-10","3005","5005"),
("70005",2400.6,"2012-07-27","3007","5006");

-- =========================
-- QUERIES
-- =========================

-- 1️⃣ Matching customers and salesmen by city
SELECT c.cust_name, s.name, s.city
FROM Customer c
JOIN Salesman s ON c.city = s.city;

-- 2️⃣ Linking customers to their assigned salesmen
SELECT c.cust_name, s.name
FROM Customer c
JOIN Salesman s ON c.Salesman_id = s.Salesman_id;

-- 3️⃣ Orders where customer city ≠ salesman city
SELECT o.ord_no, c.cust_name, c.city AS customer_city, s.city AS salesman_city
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Salesman s ON o.Salesman_id = s.Salesman_id
WHERE c.city <> s.city;

-- 4️⃣ All orders with customer names
SELECT o.ord_no, c.cust_name, o.purch_amt, o.ord_date
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id;

-- 5️⃣ Customers with valid grades
SELECT c.cust_name AS Customer, c.grade AS Grade
FROM Customer c
WHERE c.grade IS NOT NULL;

-- 6️⃣ Customers with salesmen commission between 0.12 and 0.14
SELECT c.cust_name AS Customer,
       c.city AS City,
       s.name AS Salesman,
       s.commission
FROM Customer c
JOIN Salesman s ON c.Salesman_id = s.Salesman_id
WHERE s.commission BETWEEN 0.12 AND 0.14;

-- 7️⃣ Commission earned on orders (grade ≥ 200)
SELECT o.ord_no,
       c.cust_name,
       s.commission AS "Commission%",
       ROUND(o.purch_amt * s.commission, 2) AS Commission
FROM Orders o
JOIN Salesman s ON o.Salesman_id = s.Salesman_id
JOIN Customer c ON o.customer_id = c.customer_id
WHERE c.grade >= 200;

-- 8️⃣ Orders on 2012-10-05
SELECT c.cust_name, o.ord_no, o.purch_amt, o.ord_date
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.ord_date = '2012-10-05';
