create database Real_Estate_Listing_Management_System;
use Real_Estate_Listing_Management_System;

-- Yashaswini

CREATE TABLE CityLookup (
    CityID VARCHAR(2) PRIMARY KEY,
    CityName VARCHAR(100) UNIQUE NOT NULL,
    State VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL
);
-- Yuting

create table Property_Type (
PropertyTypeID INT AUTO_INCREMENT PRIMARY KEY,
PropertyType VARCHAR(10) 
) AUTO_INCREMENT = 1;

-- Sinmisola

CREATE TABLE Clients (
    ClientID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    PreferredContactMethod ENUM('Email', 'Phone') NOT NULL
) AUTO_INCREMENT = 2001;
 
 -- Yuting

CREATE TABLE Agents (
    AgentID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    LicenseNumber VARCHAR(20) UNIQUE NOT NULL
) AUTO_INCREMENT = 3001;
 
 -- Sinmisola

CREATE TABLE Properties (
    PropertyID INT AUTO_INCREMENT PRIMARY KEY,
    Address VARCHAR(255) NOT NULL,
    CityID VARCHAR(2) NOT NULL,  
    PropertyTypeID INT NOT NULL,
    Price DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (CityID) REFERENCES CityLookup(CityID), 
    FOREIGN KEY (PropertyTypeID) REFERENCES Property_Type(PropertyTypeID) 
) AUTO_INCREMENT = 1001;



 
 -- Yashaswini

CREATE TABLE Client_Agent_Relationship (
    RelationshipID INT AUTO_INCREMENT PRIMARY KEY,
    ClientID INT NOT NULL,
    AgentID INT NOT NULL,
    RelationshipStartDate DATE NOT NULL,
    LastInteractionDate DATE NULL,
    InteractionCount INT DEFAULT 0,
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
);
 -- Yashaswini

CREATE TABLE Transactions (
    TransactionID VARCHAR(10) PRIMARY KEY,
    PropertyID INT NOT NULL,
    ClientID INT NOT NULL,
    AgentID INT NOT NULL,
    TransactionDate DATE NOT NULL,
    Amount DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
);


 -- Sinmisola

CREATE TABLE Inquiries (
    InquiryID INT AUTO_INCREMENT PRIMARY KEY,
    ClientID INT NOT NULL,
    PropertyID INT NOT NULL,
    InquiryDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Message TEXT,
    Status ENUM('Pending', 'Resolved', 'Closed') DEFAULT 'Pending',
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID)
) AUTO_INCREMENT = 4001;
 
 -- Yashaswini

CREATE TABLE Client_Property_Viewing_Schedule (
    ScheduleID INT AUTO_INCREMENT PRIMARY KEY,
    ClientID INT NOT NULL,
    PropertyID INT NOT NULL,
    AgentID INT NOT NULL,
    ViewingDateTime DATETIME NOT NULL,
    Status ENUM('Scheduled', 'Completed', 'Canceled') DEFAULT 'Scheduled',
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
) AUTO_INCREMENT = 5001;
 
-- Mohammad Fadil

CREATE TABLE Maintenance (
    MaintenanceID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyID INT NOT NULL,
    AgentID INT NOT NULL,
    MaintenanceDate DATE NOT NULL,
    Description TEXT NOT NULL,
    Status ENUM('Pending', 'In Progress', 'Completed') DEFAULT 'Pending',
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
) AUTO_INCREMENT = 6001;

-- Mohammad Fadil

CREATE TABLE Mortgage (
    MortgageID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyID INT NOT NULL,
    ClientID INT NOT NULL,
    AgentID INT NOT NULL,
    LoanAmount DECIMAL(12,2) NOT NULL,
    InterestRate DECIMAL(5,2) NOT NULL,
    TermYears INT NOT NULL,
    StartDate DATE NOT NULL,
    Status ENUM('Approved', 'Pending', 'Rejected') DEFAULT 'Pending',
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
) AUTO_INCREMENT = 7001;

-- Mohammad Fadil

CREATE TABLE Lease (
    LeaseID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyID INT NOT NULL,
    ClientID INT NOT NULL,
    AgentID INT NOT NULL,
    LeaseStartDate DATE NOT NULL,
    LeaseEndDate DATE NOT NULL,
    MonthlyRent DECIMAL(10,2) NOT NULL,
    Status ENUM('Active', 'Pending', 'Expired', 'Terminated') DEFAULT 'Pending',
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
) AUTO_INCREMENT = 8001; 

-- Sinmisola

CREATE TABLE LeaseStatus (
    LeaseStID INT AUTO_INCREMENT PRIMARY KEY,
    LeaseID INT NOT NULL,
    PropertyID INT NOT NULL,
    ClientID INT NOT NULL,
    LeaseStartDate DATE NOT NULL,
    LeaseEndDate DATE NOT NULL,
    Status ENUM('Active', 'Expired', 'Terminated', 'Pending') NOT NULL,
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (LeaseID) REFERENCES Lease(LeaseID)
)AUTO_INCREMENT = 9001;

-- Yuting

create table Payments (
PaymentID INT  AUTO_INCREMENT PRIMARY KEY,
TransactionID VARCHAR(10) not null,
PaymentDate Date,
Amount DECIMAL(10,2),
Status ENUM( 'Pending', 'Expired', 'completed') NOT NULL,
FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID)
) AUTO_INCREMENT = 10001;

-- Sinmisola

create table Feedback (
FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
PaymentID INT not null,
Comments Text ,
Rating int CHECK (Rating BETWEEN 1 AND 5),
FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID),
UNIQUE (PaymentID)
)  AUTO_INCREMENT = 11001;

-- Yashaswini
INSERT INTO CityLookup (CityID, CityName, State, Country) VALUES
('NY', 'New York', 'New York', 'USA'),
('LA', 'Los Angeles', 'California', 'USA'),
('CH', 'Chicago', 'Illinois', 'USA'),
('HO', 'Houston', 'Texas', 'USA'),
('MI', 'Miami', 'Florida', 'USA');
select * from CityLookup;

-- Yuting
insert into Property_Type (PropertyType) values 
('Purchase'),
('Rental');

select * from Property_Type;

-- Sinmisola
 INSERT INTO Properties (Address, CityID, PropertyTypeID, Price) VALUES
('123 Maple St', 'NY', 1, 450000.00),
('456 Oak Ave', 'LA', 2, 1500.00),
('789 Pine Rd', 'CH', 1, 650000.00),
('321 Birch Ln', 'NY', 2, 1800.00),
('654 Cedar Ct', 'LA', 1, 520000.00),
('987 Elm St', 'CH', 2, 1400.00),
('741 Spruce Dr', 'NY', 1, 480000.00),
('852 Walnut Rd', 'LA', 2, 1600.00),
('369 Redwood Blvd', 'CH', 1, 600000.00),
('159 Cypress Ct', 'NY', 1, 530000.00);
/*delete from Properties where PropertyID between 1031 and 1040;
ALTER TABLE Properties AUTO_INCREMENT = 1001;*/
select * from Properties;
 
 -- Yashaswini
INSERT INTO Clients (FullName, Email, Phone, PreferredContactMethod) VALUES
('John Doe', 'john.doe@email.com', '555-1234', 'Email'),
('Jane Smith', 'jane.smith@email.com', '555-5678', 'Phone'),
('Bob Johnson', 'bob.johnson@email.com', '555-9101', 'Email'),
('Sarah Lee', 'sarah.lee@email.com', '555-4321', 'Email'),
('Mike Davis', 'mike.davis@email.com', '555-8765', 'Phone');
select * from Clients;

-- Yuting
INSERT INTO Agents (FullName, Email, Phone, LicenseNumber) VALUES
('Alice Brown', 'alice.brown@email.com', '555-1000', 'LIC12345'),
('Tom Clark', 'tom.clark@email.com', '555-2000', 'LIC67890'),
('Emma Davis', 'emma.davis@email.com', '555-3000', 'LIC54321'),
('Mark Allen', 'mark.allen@email.com', '555-4000', 'LIC98765'),
('Olivia Green', 'olivia.green@email.com', '555-5000', 'LIC13579');
select * from Agents;

 -- Sinmisola
INSERT INTO Transactions (TransactionID, PropertyID, ClientID, AgentID, TransactionDate, Amount) VALUES
('TX001', 1001, 2002, 3005, '2025-03-01', 450000.00),
('TX002', 1005, 2004, 3001, '2025-03-03', 520000.00),
('TX003', 1008, 2001, 3003, '2025-03-05', 1600.00),
('TX004', 1003, 2005, 3002, '2025-03-07', 650000.00),
('TX005', 1010, 2003, 3004, '2025-03-09', 530000.00);
select * from Transactions;

-- Mohammad Fadil
INSERT INTO Lease (PropertyID, ClientID, AgentID, LeaseStartDate, LeaseEndDate, MonthlyRent, Status) VALUES
(1002, 2001, 3001, '2024-06-01', '2025-06-01', 1500.00, 'Active'),
(1004, 2002, 3002, '2023-05-15', '2024-05-15', 1800.00, 'Expired'),
(1006, 2003, 3003, '2025-04-01', '2026-04-01', 1400.00, 'Pending'),
(1008, 2004, 3004, '2023-07-10', '2024-07-10', 1600.00, 'Terminated'),
(1010, 2005, 3005, '2024-09-01', '2025-09-01', 1700.00, 'Active');

select * from Lease;


-- Sinmisola
INSERT INTO LeaseStatus (LeaseID, PropertyID, ClientID, LeaseStartDate, LeaseEndDate, Status) VALUES
(8001, 1002, 2001, '2024-05-01', '2025-07-15', 'Active'),
(8003, 1006, 2005, '2024-02-20', '2025-08-01', 'Active'),
(8002, 1004, 2003, '2023-07-15', '2024-07-15', 'Expired'),
(8004, 1008, 2002, '2025-05-16', '2026-05-16', 'Pending'),
(8005, 1010, 2004, '2023-05-20', '2024-05-20', 'Terminated');
 select * from LeaseStatus;
 
 -- Sinmisola
INSERT INTO Client_Agent_Relationship (ClientID, AgentID, RelationshipStartDate, LastInteractionDate, InteractionCount) VALUES
(2002, 3005, '2024-01-15', '2025-02-20', 5),
(2004, 3001, '2024-02-10', '2025-03-05', 3),
(2001, 3003, '2024-03-05', '2025-01-28', 7),
(2005, 3002, '2024-04-20', '2025-02-15', 2),
(2003, 3004, '2024-05-08', '2025-03-01', 4);
 select * from Client_Agent_Relationship;
 
 -- Yashaswini
INSERT INTO Inquiries (ClientID, PropertyID, InquiryDate, Message, Status) VALUES
(2001, 1001, '2025-03-01 10:15:00', 'I am interested in this property. Can I schedule a viewing?', 'Pending'),
(2002, 1002, '2025-03-02 14:30:00', 'What are the payment options available?', 'Resolved'),
(2003, 1003, '2025-03-03 09:45:00', 'Is the price negotiable?', 'Pending'),
(2004, 1004, '2025-03-04 16:20:00', 'Does the property include furniture?', 'Closed'),
(2005, 1005, '2025-03-05 11:00:00', 'I need more details on the lease terms.', 'Pending');

 select * from Inquiries;
 
 -- Yashaswini
INSERT INTO Client_Property_Viewing_Schedule (ClientID, PropertyID, AgentID, ViewingDateTime, Status) VALUES
(2001, 1001, 3001, '2025-03-06 10:00:00', 'Scheduled'),
(2002, 1002, 3002, '2025-03-07 14:00:00', 'Completed'),
(2003, 1003, 3003, '2025-03-08 16:00:00', 'Canceled'),
(2004, 1004, 3001, '2025-03-09 11:30:00', 'Scheduled'),
(2005, 1005, 3002, '2025-03-10 09:00:00', 'Completed');
select * from Client_Property_Viewing_Schedule;


-- Mohammad Fadil
INSERT INTO Maintenance (PropertyID, AgentID, MaintenanceDate, Description, Status) VALUES
(1001, 3001, '2025-03-10', 'HVAC system repair', 'Completed'),
(1003, 3002, '2025-03-12', 'Plumbing issue in kitchen', 'Pending'),
(1005, 3003, '2025-03-15', 'Electrical wiring check-up', 'In Progress'),
(1007, 3004, '2025-03-18', 'Pest control treatment', 'Completed'),
(1009, 3005, '2025-03-20', 'Roof leakage repair', 'Pending');

select * from Maintenance;

-- Mohammad Fadil
INSERT INTO Mortgage (PropertyID, ClientID, AgentID, LoanAmount, InterestRate, TermYears, StartDate, Status) VALUES
(1001, 2001, 3001, 400000.00, 3.5, 30, '2025-03-10', 'Approved'),
(1003, 2002, 3002, 600000.00, 3.8, 25, '2025-03-12', 'Pending'),
(1005, 2003, 3003, 450000.00, 3.6, 20, '2025-03-15', 'Approved'),
(1007, 2004, 3004, 500000.00, 4.0, 15, '2025-03-18', 'Rejected'),
(1009, 2005, 3005, 550000.00, 3.9, 30, '2025-03-20', 'Pending');

select * from Mortgage;


-- Yuting
insert into Payments (TransactionID, PaymentDate, Amount, Status)values 
('TX001', '2025-02-16', 450000, 'completed'),
('TX002', '2025-03-02', 1500, 'completed'),
('TX003', '2025-03-21', 650000, 'completed'),
('TX004', '2025-04-06', 2200, 'pending'),
('TX005', '2025-04-16', 520000, 'completed');

select * from Payments;


-- Yuting
insert into Feedback(PaymentID,Comments,Rating) values 
('10001','Great service!',5),
('10002','Average experience.',3),
('10003','Could be better.',3),
('10004','Highly recommended!',5);
select * from Feedback;



-- YASHASWINI
-- client that are looking for properties in a specific city such as New york
 
SELECT 
    c.ClientID, 
    c.FullName AS ClientName, 
    c.Email, 
    c.Phone, 
    cl.CityName, 
    COUNT(i.InquiryID) AS TotalInquiries
FROM Clients c
JOIN Inquiries i ON c.ClientID = i.ClientID
JOIN Properties p ON i.PropertyID = p.PropertyID
JOIN CityLookup cl ON p.CityID = cl.CityID
WHERE cl.CityName = 'New York'
GROUP BY c.ClientID, c.FullName, c.Email, c.Phone, cl.CityName
ORDER BY TotalInquiries DESC;
 
-- listing all house leasestatus in Chicago
SELECT 
    p.PropertyID, 
    p.Address, 
    cl.CityName, 
    COALESCE(ls.LeaseStartDate, 'N/A') AS LeaseStartDate, 
    COALESCE(ls.LeaseEndDate, 'N/A') AS LeaseEndDate, 
    COALESCE(ls.Status, 'No Lease') AS LeaseStatus
FROM Properties p
JOIN CityLookup cl ON p.CityID = cl.CityID
LEFT JOIN LeaseStatus ls ON p.PropertyID = ls.PropertyID
WHERE cl.CityName = 'Chicago';

-- MOHAMMAD FADIL

-- Which agents handled the most maintenance requests in March 2025, and how many requests did each agent handle  
SELECT 
    a.AgentID, 
    a.FullName AS AgentName, 
    COUNT(m.MaintenanceID) AS TotalMaintenanceHandled
FROM Agents a
JOIN Maintenance m ON a.AgentID = m.AgentID
WHERE m.MaintenanceDate BETWEEN '2025-03-01' AND '2025-03-31'
GROUP BY a.AgentID, a.FullName
ORDER BY TotalMaintenanceHandled DESC
LIMIT 5;

-- Which clients have the longest mortgage terms, and what are their mortgage details 
SELECT 
    c.ClientID, 
    c.FullName AS ClientName, 
    m.TermYears, 
    m.LoanAmount, 
    m.InterestRate, 
    m.Status, 
    p.PropertyID, 
    p.Address AS PropertyAddress
FROM Mortgage m
JOIN Clients c ON m.ClientID = c.ClientID
JOIN Properties p ON m.PropertyID = p.PropertyID
ORDER BY m.TermYears DESC, m.LoanAmount DESC
LIMIT 5;

-- SINMISOLA
-- Retrieve Properties with Leases Ending Soonest
SELECT
    l.PropertyID,
    p.Address,
    l.ClientID,
    c.FullName AS ClientName,
    l.LeaseEndDate
FROM LeaseStatus l
JOIN Properties p ON l.PropertyID = p.PropertyID
JOIN Clients c ON l.ClientID = c.ClientID
WHERE l.Status = 'Active'
ORDER BY l.LeaseEndDate ASC
LIMIT 5;

-- Retrieve Total Payments Made by Each Client
SELECT
    t.ClientID,
    c.FullName AS ClientName,
    SUM(p.Amount) AS TotalPayments
FROM Payments p
JOIN Transactions t ON p.TransactionID = t.TransactionID
JOIN Clients c ON t.ClientID = c.ClientID
GROUP BY t.ClientID, c.FullName
ORDER BY TotalPayments DESC
LIMIT 1000;


-- YUTING
-- All Clients Who Have Made a Payment, Along with Their Feedback--
SELECT 
    c.ClientID,
    c.FullName AS ClientName,
    t.TransactionID,
    p.Amount,
    p.Status AS PaymentStatus,
    f.Comments AS FeedbackComment,
    f.Rating AS FeedbackRating
FROM Clients c
JOIN Transactions t ON c.ClientID = t.ClientID
JOIN Payments p ON t.TransactionID = p.TransactionID
LEFT JOIN Feedback f ON p.PaymentID = f.PaymentID
ORDER BY c.ClientID;
 
-- Clients with Inquiries but No Transactions--
SELECT 
    c.ClientID,
    c.FullName AS ClientName,
    i.InquiryDate,
    i.Message,
    p.Address AS InquiredProperty
FROM Clients c
JOIN Inquiries i ON c.ClientID = i.ClientID
JOIN Properties p ON i.PropertyID = p.PropertyID
WHERE c.ClientID NOT IN (
    SELECT DISTINCT ClientID FROM Transactions
)
ORDER BY i.InquiryDate DESC;

-- MOHAMMAD FADIL
-- What is the average number of interactions each agent has had with their clients?
SELECT
    c.ClientID,
    c.FullName AS ClientName,
    a.AgentID,
    a.FullName AS AgentName,
    car.RelationshipStartDate,
    car.LastInteractionDate,
    car.InteractionCount,
    DATEDIFF(CURDATE(), car.LastInteractionDate) AS DaysSinceLastInteraction,
    AVG(car.InteractionCount) OVER (PARTITION BY car.AgentID) AS AvgInteractionsPerAgent,
    COUNT(car.RelationshipID) OVER (PARTITION BY car.ClientID) AS TotalRelationshipsForClient
FROM Client_Agent_Relationship car
JOIN Clients c ON car.ClientID = c.ClientID
JOIN Agents a ON car.AgentID = a.AgentID
WHERE car.InteractionCount > 5
  AND car.RelationshipStartDate > '2020-01-01'
ORDER BY DaysSinceLastInteraction DESC, car.InteractionCount DESC;

-- SINMISOLA
-- What is the feedback ID, comments, and rating for payments with a rating of 4 or more
SELECT 
    f.FeedbackID,
    f.PaymentID,
    p.Amount AS PaymentAmount,
    f.Comments,
    f.Rating,
    f.Rating * 10 AS RatingPercentage,
    DATEDIFF(CURDATE(), p.PaymentDate) AS DaysSincePayment,
    COUNT(f.PaymentID) OVER (PARTITION BY f.PaymentID) AS FeedbackCountForPayment,
    AVG(f.Rating) OVER () AS AverageRating
FROM 
    Feedback f
JOIN 
    Payments p ON f.PaymentID = p.PaymentID
WHERE 
    f.Rating >= 4
    AND DATEDIFF(CURDATE(), p.PaymentDate) <= 30
ORDER BY 
    f.Rating DESC, DaysSincePayment ASC;
-- Midhulesh Sai
-- To get Maintenance History for Each Property, Including Upcoming Maintenance Tasks.
SELECT
    p.PropertyID,
    p.Address AS PropertyName,
    m.MaintenanceID,
    m.MaintenanceDate,
    m.Status,
    m.Description,
    m.AgentID
FROM Properties p
LEFT JOIN Maintenance m ON p.PropertyID = m.PropertyID
WHERE m.MaintenanceDate >= CURDATE() OR m.Status = 'Completed'
ORDER BY p.PropertyID, m.MaintenanceDate
LIMIT 1000;
 -- Midhulesh Sai
 -- To get Active Lease Information with Rent History for Each Property.
 SELECT
    p.PropertyID,
    p.Address AS PropertyName,
    l.LeaseID,
    c.FullName AS TenantName,
    l.LeaseStartDate AS StartDate,
    l.LeaseEndDate AS EndDate,
    l.MonthlyRent AS RentAmount,
    DATEDIFF(CURDATE(), l.LeaseStartDate) AS DaysSinceLeaseStarted,
    (
        SELECT SUM(l2.MonthlyRent)
        FROM Lease l2
        WHERE l2.PropertyID = p.PropertyID
          AND l2.Status = 'Active'
          AND l2.LeaseEndDate <= CURDATE()
    ) AS TotalRentCollected
FROM Properties p
JOIN Lease l ON p.PropertyID = l.PropertyID
JOIN Clients c ON l.ClientID = c.ClientID
WHERE l.Status = 'Active'
  AND l.LeaseEndDate >= CURDATE()
ORDER BY p.PropertyID, l.LeaseStartDate
LIMIT 1000;


-- ADDITIONAL DATASET INSERTION

-- CityLookup (unchanged, ensuring at least 5 for city coverage)
INSERT INTO CityLookup (CityID, CityName, State, Country) VALUES
('SF', 'San Francisco', 'California', 'USA'),
('AT', 'Atlanta', 'Georgia', 'USA'),
('BO', 'Boston', 'Massachusetts', 'USA');

-- Clients

INSERT INTO Clients (FullName, Email, Phone, PreferredContactMethod) VALUES
('Diana Meadows', 'diana.meadows@mail.com', '555-5073', 'Email'),
('Caleb Mendez', 'caleb.mendez@mail.com', '555-8785', 'Email'),
('Naomi Sinclair', 'naomi.sinclair@mail.com', '555-9768', 'Phone'),
('Liam Bright', 'liam.bright@mail.com', '555-3450', 'Phone'),
('Jasper Lin', 'jasper.lin@mail.com', '555-8947', 'Email'),
('Talia Brooks', 'talia.brooks@mail.com', '555-9626', 'Phone'),
('Ezra Patel', 'ezra.patel@mail.com', '555-3557', 'Email'),
('Avery Monroe', 'avery.monroe@mail.com', '555-3321', 'Email'),
('Zoe Winters', 'zoe.winters@mail.com', '555-4048', 'Phone'),
('Micah Delgado', 'micah.delgado@mail.com', '555-1718', 'Phone');

-- Agents
INSERT INTO Agents (FullName, Email, Phone, LicenseNumber) VALUES
('Sienna Harper', 'sienna.harper@mail.com', '555-8771', 'LIC5657'),
('Miles Chen', 'miles.chen@mail.com', '555-3836', 'LIC1655'),
('Isabel Grant', 'isabel.grant@mail.com', '555-1247', 'LIC2645'),
('Noah Vargas', 'noah.vargas@mail.com', '555-8620', 'LIC2084'),
('Camila Rhodes', 'camila.rhodes@mail.com', '555-5690', 'LIC9562'),
('Ethan Navarro', 'ethan.navarro@mail.com', '555-1151', 'LIC5740'),
('Lena Duarte', 'lena.duarte@mail.com', '555-6902', 'LIC6973'),
('Griffin Tate', 'griffin.tate@mail.com', '555-8902', 'LIC3101'),
('Elena Russo', 'elena.russo@mail.com', '555-7870', 'LIC4379'),
('Jalen Foster', 'jalen.foster@mail.com', '555-1267', 'LIC6183');

select * from agents;

-- Properties
INSERT INTO Properties (Address, CityID, PropertyTypeID, Price) VALUES
('650 Ash Rd', 'CH', 1, 370202.00),
('434 Birch Ln', 'NY', 1, 533107.00),
('937 Pine Ave', 'LA', 2, 3274.00),
('166 Ash St', 'HO', 1, 428756.00),
('792 Chestnut Blvd', 'HO', 1, 329342.00),
('631 Cedar Ave', 'HO', 2, 3713.00),
('604 Maple Rd', 'MI', 2, 1770.00),
('981 Elm Blvd', 'HO', 1, 229316.00),
('921 Birch St', 'HO', 1, 777653.00),
('572 Oak Blvd', 'CH', 2, 1726.00);

select * from properties;

INSERT INTO Transactions (TransactionID, PropertyID, ClientID, AgentID, TransactionDate, Amount) VALUES
('TX006', 1011, 2013, 3005, '2025-03-01', 370202.00), -- Purchase
('TX007', 1012, 2008, 3001, '2025-03-03', 533107.00), -- Purchase
('TX008', 1013, 2010, 3003, '2025-03-05', 3274.00),   -- Rental
('TX009', 1014, 2009, 3002, '2025-03-07', 428756.00), -- Purchase
('TX010', 1016, 2015, 3004, '2025-03-09', 3713.00);   -- Rental

select * from transactions;

INSERT INTO Client_Property_Viewing_Schedule 
    (ClientID, PropertyID, AgentID, ViewingDateTime, Status)
VALUES
    -- For TX006 on 2025‑03‑01
    (2008, 1011, 3005, '2025-02-27 10:00:00', 'Scheduled'),
    -- For TX007 on 2025‑03‑03
    (2012, 1012, 3001, '2025-03-01 14:00:00', 'Completed'),
    -- For TX008 on 2025‑03‑05
    (2006, 1013, 3003, '2025-03-03 16:00:00', 'Canceled'),
    -- For TX009 on 2025‑03‑07
    (2015, 1014, 3001, '2025-03-05 11:30:00', 'Scheduled'),
    -- For TX010 on 2025‑03‑09
    (2009, 1016, 3005, '2025-03-07 09:00:00', 'Completed');
select * from Client_Property_Viewing_Schedule;


-- Mortgage
INSERT INTO Mortgage (PropertyID, ClientID, AgentID, LoanAmount, InterestRate, TermYears, StartDate, Status) VALUES
(1011, 2006, 3012, 436318.00, 3.90, 20, '202-03-01', 'Rejected'),
(1012, 2007, 3009, 379139.00, 3.99, 15, '2024-03-01', 'Approved'),
(1014, 2008, 3014, 350841.00, 3.85, 30, '2024-03-01', 'Approved'),
(1015, 2009, 3010, 582150.00, 5.20, 30, '2024-03-01', 'Rejected'),
(1018, 2010, 3007, 565726.00, 4.87, 30, '2024-03-01', 'Approved'),
(1019, 2011, 3015, 333623.00, 4.73, 20, '2024-03-01', 'Approved');


-- Lease
INSERT INTO Lease (LeaseID, PropertyID, ClientID, AgentID, LeaseStartDate, LeaseEndDate, MonthlyRent, Status) VALUES
(8006, 1013, 2007, 3012, '2024-06-01', '2025-05-31', 3274, 'Active'),
(8007, 1016, 2010, 3006, '2023-05-01', '2023-12-15', 3713, 'Terminated'),
(8009, 1020, 2014, 3011, '2023-04-01', '2024-03-31', 1726, 'Expired');


select * from lease;
select * from leasestatus;
-- LeaseStatus
INSERT INTO LeaseStatus (LeaseID, PropertyID, ClientID, LeaseStartDate, LeaseEndDate, Status) VALUES
(8006, 1013, 2007, '2024-06-01', '2025-05-31', 'Active'),
(8007, 1016, 2010, '2023-05-01', '2023-12-15', 'Terminated'),
(8009, 1020, 2014, '2023-04-01', '2024-03-31', 'Expired');

-- Payments
INSERT INTO Payments (TransactionID, PaymentDate, Amount, Status) VALUES
('TX006', '2025-03-02', 370202.00, 'completed'), -- Purchase (1011)
('TX007', '2025-03-04', 533107.00, 'completed'), -- Purchase (1012)
('TX008', '2025-03-06', 3274.00,   'completed'), -- Rental (1013)
('TX009', '2025-03-08', 428756.00, 'completed'), -- Purchase (1014)
('TX010', '2025-03-10', 3713.00,   'completed'); -- Rental (1016)

INSERT INTO Inquiries (ClientID, PropertyID, InquiryDate, Message, Status) VALUES
(2006, 1003, '2025-03-03 07:45:00', 'Interested in This, need details', 'Pending'),
(2007, 1002, '2025-04-02 12:30:00', 'Love this unit, can I tour soon?', 'Pending');

-- Feedback
INSERT INTO Feedback (PaymentID, Comments, Rating) VALUES
(10005, 'Smooth and professional transaction.', 5),
(10006, 'Quick process, very responsive agent.', 4),
(10007, 'The rent payment process was simple.', 4),
(10008, 'There were a few delays, but it worked out.', 3),
(10009, 'Everything was clear and easy.', 5);

select * from feedback;


-- STORED PROCEDURES

/*Sinmisola*/
-- stored procedure to automatically update lease statuses based on the current date.
-- UpdateLeaseStatuses
DELIMITER $$
 
CREATE PROCEDURE UpdateLeaseStatuses()
BEGIN
    -- Set expired leases where end date is in the past
    UPDATE Lease
    SET Status = 'Expired'
    WHERE LeaseEndDate < CURDATE()
      AND Status = 'Active';
 
    -- Optionally, activate leases that start today
    UPDATE Lease
    SET Status = 'Active'
    WHERE LeaseStartDate = CURDATE()
      AND Status = 'Pending';
      
      SELECT 'Lease statuses updated successfully.' AS Message;
END$$
 
DELIMITER ;
call UpdateLeaseStatuses();
/*Fadil*/
-- This procedure automatically assigns the least busy agent (one with the fewest properties listed) when a property is added.
DELIMITER //
 
DELIMITER //
CREATE PROCEDURE UpdatePropertyPrice(
    IN p_PropertyID INT,
    IN p_NewPrice   DECIMAL(12,2),
    OUT p_Message   VARCHAR(255)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Properties WHERE PropertyID = p_PropertyID) THEN
        SET p_Message = 'Error: Property not found.';
    ELSE
        UPDATE Properties
        SET Price = p_NewPrice
        WHERE PropertyID = p_PropertyID;
        SET p_Message = CONCAT('Price updated to $', FORMAT(p_NewPrice,2));
    END IF;
    SELECT @p_Message AS Message;
END;
//
DELIMITER ;

CALL UpdatePropertyPrice(
    1001,         
    378000.00,     
    @p_Message
);



select * from  Properties;
/*Yashaswini*/
-- stored procedure to get top inquired properties:
 
DELIMITER //
 
CREATE PROCEDURE GetTopInquiredProperties(
    IN p_TopN INT
)
BEGIN
    SELECT
        p.PropertyID,
        p.Address,
        c.CityName,
        pt.PropertyType,
        p.Price,
        COUNT(i.InquiryID) AS TotalInquiries
    FROM Properties p
    JOIN CityLookup    c  ON p.CityID         = c.CityID
    JOIN Property_Type pt ON p.PropertyTypeID = pt.PropertyTypeID
    JOIN Inquiries     i  ON p.PropertyID     = i.PropertyID
    GROUP BY
        p.PropertyID,
        p.Address,
        c.CityName,
        pt.PropertyType,
        p.Price
    ORDER BY TotalInquiries DESC
    LIMIT p_TopN;
END;
//
 
DELIMITER ;
call GetTopInquiredProperties(3);
/*Midhulesh Sai*/
-- getting the performance of agent like how many transactions and total sales in amount by agent.
DELIMITER //
CREATE PROCEDURE GetAgentPerformance (
    IN p_AgentID INT
)
BEGIN
    SELECT 
        A.FullName,
        COUNT(T.TransactionID) AS TotalTransactions,
        SUM(T.Amount) AS TotalSales
    FROM Agents A
    JOIN Transactions T ON A.AgentID = T.AgentID
    WHERE A.AgentID = p_AgentID
    GROUP BY A.AgentID;
END;
//
DELIMITER ;

call GetAgentPerformance(3001);
/*Yashaswini*/
-- Get available property listings

DELIMITER //


-- Create the new procedure
CREATE PROCEDURE GetAvailablePropertyListings()
BEGIN
    SELECT
        p.PropertyID,
        p.Address,
        p.Price,
        pt.PropertyType,
        c.CityName
    FROM Properties p
      JOIN Property_Type pt   ON p.PropertyTypeID = pt.PropertyTypeID
      JOIN CityLookup    c    ON p.CityID         = c.CityID
      -- join to see if it’s been sold
      LEFT JOIN Transactions t ON p.PropertyID     = t.PropertyID
    WHERE t.TransactionID IS NULL
    ;
END;
//

DELIMITER ;
CALL GetAvailablePropertyListings();

-- STORED FUNCTIONS

/*Fadil*/
DELIMITER // 
CREATE FUNCTION IsDuplicateAddress(p_address VARCHAR(255))
RETURNS BOOLEAN DETERMINISTIC 
BEGIN
DECLARE found INT;

    SELECT COUNT(*) INTO found FROM Properties WHERE Address = p_address;

    RETURN found > 0;
    END;
    //
    DELIMITER ;

-- Properties
INSERT INTO Properties (Address, CityID, PropertyTypeID, Price) VALUES
('650 Ash Rd', 'CH', 1, 370202.00);

SELECT IsDuplicateAddress('650 Ash Rd');
    
    /*Fadil*/
    -- checks if the transaction is valid e.g if property amount matches system
DELIMITER // 
CREATE FUNCTION IsValidTransaction(p_property_id INT, p_amount DECIMAL(12,2))
RETURNS BOOLEAN DETERMINISTIC 
BEGIN
DECLARE property_price DECIMAL(12,2);

    SELECT Price INTO property_price
    FROM Properties
    WHERE PropertyID = p_property_id;

    RETURN p_amount >= property_price;END;
    //
    
    DELIMITER ;

select * from Properties;

select IsValidTransaction(1008,1600);
    /*Yashaswini*/
    -- This function calculates the monthly mortgage payment based on loan amount, interest rate, and loan term (in years), using the standard amortization formula.
DELIMITER //

CREATE FUNCTION CalculateMortgage(
    LoanAmount DECIMAL(10,2),
    AnnualInterestRate DECIMAL(5,2),
    TermYears INT
) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE MonthlyInterestRate DECIMAL(10,6);
    DECLARE NumberOfPayments INT;
    DECLARE MonthlyPayment DECIMAL(10,2);
 
    SET MonthlyInterestRate = AnnualInterestRate / 12 / 100;
    SET NumberOfPayments = TermYears * 12;
 
    IF MonthlyInterestRate = 0 THEN
        SET MonthlyPayment = LoanAmount / NumberOfPayments;
    ELSE
        SET MonthlyPayment = LoanAmount * MonthlyInterestRate / 
            (1 - POWER(1 + MonthlyInterestRate, -NumberOfPayments));
    END IF;
 
    RETURN ROUND(MonthlyPayment, 2);
END //
 
DELIMITER ;


/*Fadil*/
-- Measures how many of an agent's deals turned into transactions.
DELIMITER //
 
CREATE FUNCTION GetAgentSuccessRate(p_agentID INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE totalViewings INT DEFAULT 0;
    DECLARE totalSales INT DEFAULT 0;
 
    -- Count how many times the agent has been scheduled for viewings
    SELECT COUNT(*) INTO totalViewings
    FROM Client_Property_Viewing_Schedule
    WHERE AgentID = p_agentID;
 
    -- Count how many sales (transactions) the agent completed
    SELECT COUNT(*) INTO totalSales
    FROM Transactions
    WHERE AgentID = p_agentID;
 
    -- If there are no viewings, success rate is 0
    IF totalViewings = 0 THEN
        RETURN 0.00;
    END IF;
 
    -- Calculate success rate as a percentage
    RETURN ROUND((totalSales / totalViewings) * 100, 2);
END;
//
 
DELIMITER ;
 select GetAgentSuccessRate(3002);
select GetAgentSuccessRate(3001);
select * from transactions;
select * from client_property_viewing_schedule;
/*Yashaswini*/
-- Calculate average maintenance response time for an agent
DELIMITER //
CREATE FUNCTION CalculateAvgMaintenanceResponseTime(agent_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE avg_days INT;
    SELECT AVG(DATEDIFF(CURDATE(), MaintenanceDate)) INTO avg_days
    FROM Maintenance
    WHERE AgentID = agent_id AND Status = 'Completed';
    RETURN IFNULL(avg_days, 0);
END //
DELIMITER ;
select CalculateAvgMaintenanceResponseTime(3001); 
 /*Yashaswini*/
-- Check if property has pending maintenance
DELIMITER //
CREATE FUNCTION HasPendingMaintenance(property_id INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE has_pending BOOLEAN;
    SELECT COUNT(*) > 0 INTO has_pending
    FROM Maintenance
    WHERE PropertyID = property_id AND Status IN ('Pending', 'In Progress');
    RETURN has_pending;
END //
DELIMITER ;
select HasPendingMaintenance(1005);
select * from maintenance;
-- TRIGGERS

/*Yuting*/
-- Trigger for property UPDATE Logs
CREATE TABLE property_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    PropertyId INT,
    PropertyTypeID INT,
    Price DECIMAL(12,2),
    action VARCHAR(50),
    log_time DATETIME DEFAULT CURRENT_TIMESTAMP
);
 
-- Create trigger for logging updates
DELIMITER $$

CREATE TRIGGER after_property_update
AFTER UPDATE ON Properties
FOR EACH ROW
BEGIN
    INSERT INTO property_logs (
        PropertyId,
        PropertyTypeID,
        Price,
        action,
        log_time
    )
    VALUES (
        NEW.PropertyId,
        NEW.PropertyTypeID,
        NEW.Price,
        'UPDATE',
        NOW()
    );
END $$

DELIMITER ;

-- Example: update a property's price
UPDATE Properties
SET Price = Price + 10000
WHERE PropertyID = 1001;
select * from property_logs;

/*Sinmisola*/
-- Automatically log when an agent completes a transaction, for performance tracking.
CREATE TABLE AgentActivityLog(
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    AgentID INT,
    TransactionID VARCHAR(10),
    Activity VARCHAR(255),
    LoggedAt DATETIME DEFAULT CURRENT_TIMESTAMP);
 
DELIMITER //
CREATE TRIGGER trg_log_agent_activity_after_transaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    INSERT INTO AgentActivityLog (AgentID, TransactionID, Activity)
    VALUES (
        NEW.AgentID,
        NEW.TransactionID,
        CONCAT('Completed transaction on Property ', NEW.PropertyID)
    );
END;
//
DELIMITER ;
INSERT INTO Transactions (TransactionID, PropertyID, ClientID, AgentID, TransactionDate, Amount)
VALUES ('TX999', 1001, 2001, 3001, '2025-04-18', 460000.00);

SELECT * FROM AgentActivityLog;

/*Yashaswini*/
-- Prevent property deletion if it has active transactions
DELIMITER //
CREATE TRIGGER before_property_delete
BEFORE DELETE ON Properties
FOR EACH ROW
BEGIN
    DECLARE transaction_count INT;
    SELECT COUNT(*) INTO transaction_count
    FROM Transactions
    WHERE PropertyID = OLD.PropertyID;
    IF transaction_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete property with associated transactions';
    END IF;
END //
DELIMITER ;

DELETE FROM Properties
WHERE PropertyID = 1001;  -- Assuming this property is in Transactions

/*Midhulesh*/
-- Auto-resolve Inquiry if Message mentions "resolved" 

DELIMITER //

CREATE TRIGGER BeforeInsert_Inquiries_AutoResolve
BEFORE INSERT ON Inquiries
FOR EACH ROW
BEGIN
    IF LOWER(NEW.Message) LIKE '%resolved%' THEN
        SET NEW.Status = 'Resolved';
    END IF;
END;
//

DELIMITER ;

INSERT INTO Inquiries (ClientID, PropertyID, Message, Status)
VALUES (2001, 1001, 'This issue has been resolved already.', 'Pending');

SELECT InquiryID, Message, Status
FROM Inquiries
ORDER BY InquiryID DESC
LIMIT 1;

/*Midhulesh*/
-- Increment InteractionCount on Inquiry Insert 
DELIMITER //

CREATE TRIGGER AfterInsert_Inquiries_IncrementInteractionCount
AFTER INSERT ON Inquiries
FOR EACH ROW
BEGIN
    UPDATE Client_Agent_Relationship
    SET InteractionCount = InteractionCount + 1
    WHERE ClientID = NEW.ClientID;
END;
//

DELIMITER ;

INSERT INTO Inquiries (ClientID, PropertyID, Message, Status)
VALUES (2001, 1001, 'Another follow-up inquiry.', 'Pending');