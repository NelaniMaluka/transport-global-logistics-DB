/*********
Phase 2
*********/

-- Create the database
CREATE DATABASE TransGlobalLogisticsDB;
GO

-- Use the created database
USE TransGlobalLogisticsDB;
GO

-- Create the schemas
CREATE SCHEMA operations;
GO
CREATE SCHEMA logistics;
GO
CREATE SCHEMA administration;
GO


/* Table Creation */

-- Creating the Customers Table
CREATE TABLE operations.Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Address NVARCHAR(255),
    Email NVARCHAR(255),
    Phone NVARCHAR(50)
);

-- Creating the Warehouses Table
CREATE TABLE logistics.Warehouses (
    WarehouseID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Location NVARCHAR(255) NOT NULL,
    InventoryLevel DECIMAL(10, 2) NOT NULL DEFAULT 0
);


-- Creating the Employees Table
CREATE TABLE administration.Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Role NVARCHAR(50),
    Phone NVARCHAR(50),
    Email NVARCHAR(255),
    HireDate DATETIME
);

-- Creating the Drivers Table
CREATE TABLE administration.Drivers (
    DriverID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    LicenseNumber NVARCHAR(100) NOT NULL,
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES administration.Employees(EmployeeID)
);

-- Creating the Vehicles Table
CREATE TABLE logistics.Vehicles (
    VehicleID INT PRIMARY KEY IDENTITY(1,1),
    Type NVARCHAR(50) NOT NULL,
    Status NVARCHAR(50) NOT NULL, -- e.g., Available/In-Use
    DriverID INT,
    FOREIGN KEY (DriverID) REFERENCES administration.Drivers(DriverID)
);

-- Creating the Routes Table
CREATE TABLE logistics.Routes (
    RouteID INT PRIMARY KEY IDENTITY(1,1),
    OriginWarehouseID INT NOT NULL,
    DestinationWarehouseID INT NOT NULL,
    Distance DECIMAL(10,2), -- in kilometers
    FOREIGN KEY (OriginWarehouseID) REFERENCES logistics.Warehouses(WarehouseID),
    FOREIGN KEY (DestinationWarehouseID) REFERENCES logistics.Warehouses(WarehouseID)
);

-- Creating the Shipmets Table
CREATE TABLE operations.Shipments (
    ShipmentID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    OriginWarehouseID INT NOT NULL,
    DestinationWarehouseID INT NOT NULL,
    VehicleID INT,
    Status NVARCHAR(50) NOT NULL, -- e.g., In-Transit/Delivered
    DepartureTime DATETIME,
    EstimatedArrival DATETIME,
    ActualArrival DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES operations.Customers(CustomerID),
    FOREIGN KEY (OriginWarehouseID) REFERENCES logistics.Warehouses(WarehouseID),
    FOREIGN KEY (DestinationWarehouseID) REFERENCES logistics.Warehouses(WarehouseID),
    FOREIGN KEY (VehicleID) REFERENCES logistics.Vehicles(VehicleID)
);

-- Creating the Cargo Table
CREATE TABLE logistics.Cargo (
    CargoID INT PRIMARY KEY IDENTITY(1,1),
    ShipmentID INT NOT NULL,
    Description NVARCHAR(255),
    Weight DECIMAL(10,2),
    FOREIGN KEY (ShipmentID) REFERENCES operations.Shipments(ShipmentID)
);

-- Creating the AuditLogs Table
CREATE TABLE administration.AuditLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    ShipmentID INT NOT NULL,
    StatusChange NVARCHAR(255),
    Timestamp DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ShipmentID) REFERENCES operations.Shipments(ShipmentID)
);




/* Insert Statements */

-- Insert Into Customers Table
INSERT INTO operations.Customers (Name, Address, Email, Phone) VALUES
('Alice Johnson', '123 Maple Street', 'alice.johnson@example.com', '123-456-7890'),
('Bob Smith', '456 Oak Avenue', 'bob.smith@example.com', '234-567-8901'),
('Charlie Brown', '789 Pine Road', 'charlie.brown@example.com', '345-678-9012'),
('David Lee', '321 Birch Lane', 'david.lee@example.com', '456-789-0123'),
('Eve Adams', '654 Cedar Avenue', 'eve.adams@example.com', '567-890-1234'),
('Frank Green', '987 Elm Street', 'frank.green@example.com', '678-901-2345'),
('Grace Hall', '147 Spruce Lane', 'grace.hall@example.com', '789-012-3456'),
('Holly Fox', '258 Willow Court', 'holly.fox@example.com', '890-123-4567'),
('Ian White', '369 Palm Road', 'ian.white@example.com', '901-234-5678'),
('Julia Black', '741 Chestnut Blvd', 'julia.black@example.com', '012-345-6789');

-- Insert Into Warehouses Table
INSERT INTO logistics.Warehouses (Name, Location, InventoryLevel) VALUES
('Warehouse A', 'Johannesburg, South Africa', 0),
('Warehouse B', 'Cape Town, South Africa', 0),
('Warehouse C', 'Durban, South Africa', 0),
('Warehouse D', 'Pretoria, South Africa', 0),
('Warehouse E', 'Bloemfontein, South Africa', 0);

-- Insert Into Employees Table
INSERT INTO administration.Employees (Name, Role, Phone, Email, HireDate) VALUES
('John Doe', 'Driver', '123-456-7890', 'john.doe@example.com', '2020-01-15'),
('Sarah Evans', 'Fleet Manager', '234-567-8901', 'sarah.evans@example.com', '2019-05-12'),
('Michael Carter', 'Warehouse Staff', '345-678-9012', 'michael.carter@example.com', '2021-07-18'),
('Emily Rogers', 'Customer Support', '456-789-0123', 'emily.rogers@example.com', '2022-03-05'),
('David Clark', 'Driver', '567-890-1234', 'david.clark@example.com', '2020-06-22'),
('Sophia Martin', 'Logistics Coordinator', '678-901-2345', 'sophia.martin@example.com', '2018-09-09'),
('Ryan Moore', 'Driver', '789-012-3456', 'ryan.moore@example.com', '2020-11-30'),
('Lily Collins', 'Warehouse Manager', '890-123-4567', 'lily.collins@example.com', '2021-08-17'),
('Jake Harris', 'Driver', '901-234-5678', 'jake.harris@example.com', '2020-02-04'),
('Olivia Wright', 'Warehouse Staff', '012-345-6789', 'olivia.wright@example.com', '2021-11-12'),
('Ethan Walker', 'Driver', '123-456-7800', 'ethan.walker@example.com', '2019-07-19'),
('Ava Turner', 'Administrative Assistant', '234-567-8902', 'ava.turner@example.com', '2022-01-10'),
('Noah Bennett', 'Driver', '345-678-9013', 'noah.bennett@example.com', '2020-04-03'),
('Emma Brooks', 'Logistics Analyst', '456-789-0124', 'emma.brooks@example.com', '2021-09-15'),
('Lucas Hill', 'Driver', '567-890-1235', 'lucas.hill@example.com', '2020-06-25'),
('Mia Scott', 'Fleet Coordinator', '678-901-2346', 'mia.scott@example.com', '2018-10-14'),
('Liam Green', 'Driver', '789-012-3457', 'liam.green@example.com', '2020-01-20'),
('Charlotte Kelly', 'Warehouse Staff', '890-123-4568', 'charlotte.kelly@example.com', '2021-06-11'),
('Benjamin Wood', 'Driver', '901-234-5679', 'benjamin.wood@example.com', '2019-02-27'),
('Amelia Cooper', 'Customer Relations Manager', '012-345-6780', 'amelia.cooper@example.com', '2022-07-23');

-- Insert Into Drivers Table
INSERT INTO administration.Drivers (Name, LicenseNumber, EmployeeID) VALUES
('John Doe', 'DL123456', 1),
('David Clark', 'DL234567', 5),
('Ryan Moore', 'DL345678', 7),
('Jake Harris', 'DL456789', 9),
('Ethan Walker', 'DL567890', 11),
('Noah Bennett', 'DL678901', 13),
('Lucas Hill', 'DL789012', 15),
('Liam Green', 'DL890123', 17),
('Benjamin Wood', 'DL901234', 19);

-- Insert Into Vehicles Table
INSERT INTO logistics.Vehicles (Type, Status, DriverID) VALUES
('Truck', 'Available', 1),
('Truck', 'In-Use', 2),
('Cargo Ship', 'Available', 3),
('Cargo Ship', 'In-Use', 4),
('Aircraft', 'Available', 5),
('Aircraft', 'In-Use', 6),
('Truck', 'Available', 7),
('Truck', 'In-Use', 8),
('Cargo Ship', 'Available', 9),
('Cargo Ship', 'In-Use', 1),
('Aircraft', 'Available', 2),
('Truck', 'Available', 6),
('Aircraft', 'In-Use', 3),
('Cargo Ship', 'Available', 4),
('Truck', 'In-Use', 5);

-- Insert Into Routes Table
INSERT INTO logistics.Routes (OriginWarehouseID, DestinationWarehouseID, Distance) VALUES
(1, 2, 250.5),
(2, 3, 350.2),
(3, 4, 400.1),
(4, 5, 600.0),
(5, 1, 200.3);

-- Insert Into Shipments Table
INSERT INTO operations.Shipments (CustomerID, OriginWarehouseID, DestinationWarehouseID, VehicleID, Status, DepartureTime, EstimatedArrival, ActualArrival) VALUES
(1, 1, 2, 1, 'In-Transit', '2025-03-23 10:00', '2025-03-24 15:00', NULL),
(2, 2, 3, 2, 'Delivered', '2025-03-22 08:30', '2025-03-22 18:00', '2025-03-22 17:45'),
(3, 3, 4, 3, 'In-Transit', '2025-03-24 09:15', '2025-03-25 16:00', NULL),
(4, 4, 5, 4, 'Pending', NULL, NULL, NULL),
(5, 1, 3, 5, 'In-Transit', '2025-03-21 11:00', '2025-03-22 20:00', NULL),
(6, 2, 4, 6, 'Delivered', '2025-03-20 07:00', '2025-03-20 17:30', '2025-03-20 17:10'),
(7, 3, 5, 7, 'Pending', NULL, NULL, NULL),
(8, 4, 1, 8, 'In-Transit', '2025-03-23 06:30', '2025-03-24 19:00', NULL),
(9, 5, 2, 9, 'Delivered', '2025-03-22 13:15', '2025-03-23 12:00', '2025-03-27 17:10');

-- Insert Into Cargo Table
INSERT INTO logistics.Cargo (ShipmentID, Description, Weight) VALUES
(2, 'Furniture', 2750.50),
(3, 'Clothing', 1250.75),
(4, 'Machinery', 3500.00),
(5, 'Food Supplies', 1800.40),
(6, 'Books', 950.30),
(7, 'Automobile Parts', 2500.00),
(8, 'Medical Equipment', 1200.20),
(9, 'Cosmetics', 800.10),
(1, 'Stationery', 500.15);

-- Insert Into Audit Table
INSERT INTO administration.AuditLogs (ShipmentID, StatusChange) VALUES
(2, 'Status updated to Delivered'),
(3, 'Status updated to In-Transit'),
(4, 'Status updated to Pending'),
(5, 'Status updated to In-Transit'),
(6, 'Status updated to Delivered'),
(7, 'Status updated to Pending'),
(8, 'Status updated to In-Transit'),
(9, 'Status updated to Delivered'),
(1, 'Status updated to Pending');




/* Query Statements */


/* uery to track all active shipments for a specific customer */
SELECT * FROM operations.Shipments
WHERE Status = 'In-Transit' AND CustomerID = 1;

/* Query to identify available vehicles at a particular warehouse  */
WITH LastShipment AS (
    SELECT 
        s.VehicleID,
        s.DestinationWarehouseID AS LastKnownWarehouse,
        s.Status,
        ROW_NUMBER() OVER (PARTITION BY s.VehicleID ORDER BY s.ActualArrival DESC) AS rn
    FROM operations.Shipments s
)
SELECT 
    v.VehicleID, 
    v.Type, 
    v.Status, 
    w.Name AS WarehouseName
FROM logistics.Vehicles v
JOIN LastShipment ls ON v.VehicleID = ls.VehicleID
JOIN logistics.Warehouses w ON ls.LastKnownWarehouse = w.WarehouseID
WHERE ls.rn = 1  
AND ls.LastKnownWarehouse = 2
AND v.Status = 'Available';


/* Query to generate a daily shipment schedule  */
DECLARE @SpecificDate DATETIME = '2025-03-23';

SELECT 
    s.ShipmentID, 
    c.Name AS CustomerName, 
    w1.Name AS OriginWarehouse, 
    w2.Name AS DestinationWarehouse, 
    s.DepartureTime, 
    s.EstimatedArrival, 
    v.Type AS VehicleType, 
    d.Name AS DriverName
FROM operations.Shipments s
JOIN operations.Customers c ON s.CustomerID = c.CustomerID
JOIN logistics.Warehouses w1 ON s.OriginWarehouseID = w1.WarehouseID
JOIN logistics.Warehouses w2 ON s.DestinationWarehouseID = w2.WarehouseID
LEFT JOIN logistics.Vehicles v ON s.VehicleID = v.VehicleID
LEFT JOIN administration.Drivers d ON v.DriverID = d.DriverID
WHERE CAST(s.DepartureTime AS DATE) = CAST(@SpecificDate AS DATE) 
ORDER BY s.DepartureTime;

/* Query to calculate average delivery times between specific locations */
SELECT OriginWarehouseID, DestinationWarehouseID, AVG(DATEDIFF(MINUTE, DepartureTime, ActualArrival)) AS AvgDeliveryTime_Minutes
FROM operations.Shipments
GROUP BY OriginWarehouseID, DestinationWarehouseID
ORDER BY OriginWarehouseID, DestinationWarehouseID;

/* Query to identify the most efficient drivers based on on-time delivery percentage  */
WITH DriverPerformance AS (
    SELECT 
        d.DriverID,
        d.Name AS DriverName,
        COUNT(s.ShipmentID) AS TotalShipments,
        SUM(CASE WHEN s.ActualArrival <= s.EstimatedArrival THEN 1 ELSE 0 END) AS OnTimeDeliveries
    FROM logistics.Vehicles v
    JOIN administration.Drivers d ON v.DriverID = d.DriverID
    LEFT JOIN operations.Shipments s ON v.VehicleID = s.VehicleID
    WHERE s.Status = 'Delivered'  
    GROUP BY d.DriverID, d.Name
)
SELECT 
    DriverID,
    DriverName,
    TotalShipments,
    OnTimeDeliveries,
    (CAST(OnTimeDeliveries AS DECIMAL) / TotalShipments) * 100 AS OnTimeDeliveryPercentage
FROM DriverPerformance
ORDER BY OnTimeDeliveryPercentage DESC;
GO




/*********
Phase 3
*********/



/* Stored Procedures */

/* sp_CreateNewShipment - Creates a new shipment record with comprehensive validation */
CREATE PROCEDURE sp_CreateNewShipment
    @CustomerID INT,
    @OriginWarehouseID INT,
    @DestinationWarehouseID INT,
    @VehicleID INT,
    @Status NVARCHAR(50),
    @DepartureTime DATETIME,
    @EstimatedArrival DATETIME
AS
BEGIN
    -- Validation: Check if the customer exists
    IF NOT EXISTS (SELECT 1 FROM operations.Customers WHERE CustomerID = @CustomerID)
    BEGIN
        RAISERROR('Customer not found.', 16, 1);
        RETURN;
    END

    -- Validation: Check if the origin warehouse exists
    IF NOT EXISTS (SELECT 1 FROM logistics.Warehouses WHERE WarehouseID = @OriginWarehouseID)
    BEGIN
        RAISERROR('Origin warehouse not found.', 16, 1);
        RETURN;
    END

    -- Validation: Check if the destination warehouse exists
    IF NOT EXISTS (SELECT 1 FROM logistics.Warehouses WHERE WarehouseID = @DestinationWarehouseID)
    BEGIN
        RAISERROR('Destination warehouse not found.', 16, 1);
        RETURN;
    END

    -- Validation: Check if the vehicle exists and is available
    IF NOT EXISTS (SELECT 1 FROM logistics.Vehicles WHERE VehicleID = @VehicleID AND Status = 'Available')
    BEGIN
        RAISERROR('Vehicle not found or not available.', 16, 1);
        RETURN;
    END

    -- Insert new shipment record
    INSERT INTO operations.Shipments (CustomerID, OriginWarehouseID, DestinationWarehouseID, VehicleID, Status, DepartureTime, EstimatedArrival)
    VALUES (@CustomerID, @OriginWarehouseID, @DestinationWarehouseID, @VehicleID, @Status, @DepartureTime, @EstimatedArrival);
    
    SELECT 'Shipment created successfully.' AS Message;
END
GO

/* sp_AssignVehicleToShipment - Assigns available vehicles to pending shipments  */
CREATE PROCEDURE sp_AssignVehicleToShipment
    @ShipmentID INT,
    @VehicleID INT
AS
BEGIN
    -- Check if the shipment exists and is in 'Pending' status
    IF NOT EXISTS (SELECT 1 FROM operations.Shipments WHERE ShipmentID = @ShipmentID AND Status = 'Pending')
    BEGIN
        RAISERROR('Shipment not found or not in pending status.', 16, 1);
        RETURN;
    END

    -- Check if the vehicle exists and is available
    IF NOT EXISTS (SELECT 1 FROM logistics.Vehicles WHERE VehicleID = @VehicleID AND Status = 'Available')
    BEGIN
        RAISERROR('Vehicle not found or not available.', 16, 1);
        RETURN;
    END

    -- Update shipment to assign the vehicle
    UPDATE operations.Shipments
    SET VehicleID = @VehicleID, Status = 'In-Transit'
    WHERE ShipmentID = @ShipmentID;
    
    -- Update vehicle status to 'In-Transit'
    UPDATE logistics.Vehicles
    SET Status = 'In-Transit'
    WHERE VehicleID = @VehicleID;

    SELECT 'Vehicle assigned to shipment and status updated to In-Transit.' AS Message;
END
GO

/* sp_UpdateShipmentStatus - Updates shipment status with appropriate logging */
CREATE PROCEDURE sp_UpdateShipmentStatus
    @ShipmentID INT,
    @NewStatus NVARCHAR(50)
AS
BEGIN
    -- Validate if the shipment exists
    IF NOT EXISTS (SELECT 1 FROM operations.Shipments WHERE ShipmentID = @ShipmentID)
    BEGIN
        RAISERROR('Shipment not found.', 16, 1);
        RETURN;
    END

    -- Validate if the new status is valid
    IF @NewStatus NOT IN ('Pending', 'In-Transit', 'Delivered', 'Cancelled')
    BEGIN
        RAISERROR('Invalid status.', 16, 1);
        RETURN;
    END

    -- Get current status
    DECLARE @CurrentStatus NVARCHAR(50);
    SELECT @CurrentStatus = Status FROM operations.Shipments WHERE ShipmentID = @ShipmentID;

    -- If the status has changed, log the status change
    IF @CurrentStatus <> @NewStatus
    BEGIN
        -- Insert a record into the AuditLogs table
        INSERT INTO administration.AuditLogs (ShipmentID, StatusChange)
        VALUES (@ShipmentID, CONCAT('Status changed from ', @CurrentStatus, ' to ', @NewStatus));

        -- Update the shipment status
        UPDATE operations.Shipments
        SET Status = @NewStatus
        WHERE ShipmentID = @ShipmentID;

        SELECT 'Shipment status updated successfully.' AS Message;
    END
    ELSE
    BEGIN
        SELECT 'No change in shipment status.' AS Message;
    END
END
GO




/* Triggers */

/* A trigger that maintains vehicle availability status when assigned to or released from 
shipments */
CREATE TRIGGER trg_MaintainVehicleAvailability
ON operations.Shipments
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ShipmentID INT, @NewStatus NVARCHAR(50), @VehicleID INT;
    
    -- Get the shipment ID, new status, and vehicle ID from the updated row
    SELECT @ShipmentID = ShipmentID, @NewStatus = Status, @VehicleID = VehicleID
    FROM inserted;

    -- Ensure there is a valid vehicle ID
    IF @VehicleID IS NOT NULL
    BEGIN
        -- Check if the vehicle status should be updated
        IF @NewStatus = 'In-Transit'
        BEGIN
            -- Set the vehicle status to 'In-Transit' when assigned to a shipment
            UPDATE logistics.Vehicles
            SET Status = 'In-Transit'
            WHERE VehicleID = @VehicleID;
        END
        ELSE IF @NewStatus IN ('Delivered', 'Cancelled')
        BEGIN
            -- Revert the vehicle status to 'Available' when shipment is completed or cancelled
            UPDATE logistics.Vehicles
            SET Status = 'Available'
            WHERE VehicleID = @VehicleID;
        END
    END
    ELSE
    BEGIN
        RAISERROR('Invalid vehicle ID or no vehicle assigned to the shipment.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

/* A trigger that logs all shipment status changes to an audit table  */
CREATE TRIGGER trg_LogShipmentStatusChange
ON operations.Shipments
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ShipmentID INT, @OldStatus NVARCHAR(50), @NewStatus NVARCHAR(50);

    -- Get the shipment ID, old status, and new status from the deleted and inserted rows
    SELECT @ShipmentID = ShipmentID FROM inserted;
    SELECT @OldStatus = Status FROM deleted;
    SELECT @NewStatus = Status FROM inserted;

    -- Log the status change if the status has changed
    IF @OldStatus <> @NewStatus
    BEGIN
        INSERT INTO administration.AuditLogs (ShipmentID, StatusChange)
        VALUES (@ShipmentID, CONCAT('Status changed from ', @OldStatus, ' to ', @NewStatus));

        -- Optionally, raise a custom message to track the status change
        PRINT CONCAT('Shipment ID ', @ShipmentID, ' status changed from ', @OldStatus, ' to ', @NewStatus);
    END
END
GO

/* A trigger that updates warehouse inventory levels when goods are shipped or received */
CREATE TRIGGER trg_UpdateWarehouseInventory
ON logistics.Cargo
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ShipmentID INT, @Weight DECIMAL(10, 2);
    DECLARE @OriginWarehouseID INT, @DestinationWarehouseID INT;

    -- Get the ShipmentID and weight from the inserted or deleted rows
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        SELECT @ShipmentID = ShipmentID, @Weight = Weight FROM inserted;
    END
    ELSE
    BEGIN
        SELECT @ShipmentID = ShipmentID, @Weight = Weight FROM deleted;
    END

    -- Get the origin and destination warehouses
    SELECT @OriginWarehouseID = OriginWarehouseID, @DestinationWarehouseID = DestinationWarehouseID
    FROM operations.Shipments
    WHERE ShipmentID = @ShipmentID;

    -- Update inventory for the origin warehouse (decrease stock)
    UPDATE logistics.Warehouses
    SET InventoryLevel = InventoryLevel - @Weight
    WHERE WarehouseID = @OriginWarehouseID;

    -- Update inventory for the destination warehouse (increase stock)
    UPDATE logistics.Warehouses
    SET InventoryLevel = InventoryLevel + @Weight
    WHERE WarehouseID = @DestinationWarehouseID;
    
    PRINT CONCAT('Warehouse inventory updated for ShipmentID: ', @ShipmentID);
END
GO

/* Functions */

/* A scalar function to calculate the estimated delivery time based on distance and vehicle type */
CREATE FUNCTION dbo.fn_CalculateDeliveryTime
(
    @Distance DECIMAL(10, 2),  -- Distance in kilometers
    @VehicleType NVARCHAR(50)  -- Vehicle type (e.g., 'Truck', 'Van', 'Bike')
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Speed DECIMAL(10, 2);  -- Speed of the vehicle (km/h)
    DECLARE @EstimatedTime DECIMAL(10, 2);  -- Estimated time (in hours)

    -- Set the speed based on the vehicle type
    IF @VehicleType = 'Truck'
    BEGIN
        SET @Speed = 60;  -- Truck speed in km/h
    END
    ELSE IF @VehicleType = 'Van'
    BEGIN
        SET @Speed = 80;  -- Van speed in km/h
    END
    ELSE IF @VehicleType = 'Bike'
    BEGIN
        SET @Speed = 40;  -- Bike speed in km/h
    END
    ELSE
    BEGIN
        SET @Speed = 50;  -- Default speed in km/h
    END

    -- Calculate the estimated delivery time (Distance / Speed)
    SET @EstimatedTime = @Distance / @Speed;

    RETURN @EstimatedTime;
END;
GO

/* A table-valued function that returns optimal route options between two warehouses  */
CREATE FUNCTION dbo.fn_GetOptimalRoutes
(
    @OriginWarehouseID INT,       -- Origin warehouse ID
    @DestinationWarehouseID INT   -- Destination warehouse ID
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        RouteID,
        OriginWarehouseID,
        DestinationWarehouseID,
        Distance
    FROM logistics.Routes
    WHERE OriginWarehouseID = @OriginWarehouseID
      AND DestinationWarehouseID = @DestinationWarehouseID
);
GO

/* A scalar function to calculate fuel consumption estimates based on distance and vehicle type */
CREATE FUNCTION dbo.fn_CalculateFuelConsumption
(
    @Distance DECIMAL(10, 2),  -- Distance in kilometers
    @VehicleType NVARCHAR(50)  -- Vehicle type (e.g., 'Truck', 'Van', 'Bike')
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @FuelRate DECIMAL(10, 2);  -- Fuel consumption rate (liters per 100 km)
    DECLARE @FuelConsumption DECIMAL(10, 2);  -- Total fuel consumption

    -- Set the fuel rate based on vehicle type
    IF @VehicleType = 'Truck'
    BEGIN
        SET @FuelRate = 15;  -- Truck fuel rate (liters per 100 km)
    END
    ELSE IF @VehicleType = 'Van'
    BEGIN
        SET @FuelRate = 8;  -- Van fuel rate (liters per 100 km)
    END
    ELSE IF @VehicleType = 'Bike'
    BEGIN
        SET @FuelRate = 5;  -- Bike fuel rate (liters per 100 km)
    END
    ELSE
    BEGIN
        SET @FuelRate = 10;  -- Default fuel rate for other vehicles (liters per 100 km)
    END

    -- Calculate fuel consumption: (Distance / 100) * FuelRate
    SET @FuelConsumption = (@Distance / 100) * @FuelRate;

    RETURN @FuelConsumption;
END;
