# TransGlobal Logistics Database  
**A Complete SQL Server Database Project for a Fictional Global Logistics Company**

![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![T-SQL](https://img.shields.io/badge/T--SQL-4479A1?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![Database Design](https://img.shields.io/badge/Database-Design-00684A?style=for-the-badge&logo=postgresql&logoColor=white)

This is a **full-featured SQL Server database project** I built from scratch to practice and showcase real-world database design, T-SQL scripting, relationships, constraints, stored procedures, and production-ready patterns.

The fictional company — **TransGlobal Logistics** — manages customers, warehouses, vehicles, drivers, routes, shipments, and cargo worldwide.

---

## Project Goals

- Master **database schema design** with proper normalization and relationships  
- Organize tables using **multiple schemas** (operations, logistics, administration)  
- Implement **data integrity** with constraints, foreign keys, defaults, and checks  
- Write clean, reusable, and **production-style T-SQL scripts**  
- Build **robust stored procedures** with validation and error handling  
- Practice advanced querying with **CTEs, window functions, joins, and aggregations**

---

## Database Schema Overview

The database is logically organized into **three schemas**:

| Schema          | Purpose                                      |
|-----------------|----------------------------------------------|
| `operations`    | Day-to-day shipment and cargo operations    |
| `logistics`     | Vehicles, drivers, routes, and warehouses    |
| `administration`| Customers, employees, and audit logging      |

### Key Tables

| Table                     | Description                                      |
|--------------------------|--------------------------------------------------|
| `administration.Customers`     | Company clients and contact info                |
| `logistics.Warehouses`          | Storage facilities with location and capacity   |
| `logistics.Drivers`             | Licensed drivers with status and license info   |
| `logistics.Vehicles`            | Trucks and vans with status (Available/In Use)  |
| `logistics.Routes`              | Predefined delivery routes                      |
| `operations.Shipments`          | Core shipments with status and timestamps      |
| `operations.Cargo`              | Items inside each shipment                      |
| `operations.ShipmentAuditLog`   | Full history of status changes (who/when/what)  |

---

## Features & What I Practiced

| Feature                        | Skills Applied                                      |
|--------------------------------|------------------------------------------------------|
| Multi-schema organization      | Logical grouping and naming conventions             |
| Strong referential integrity   | PK/FK, IDENTITY, DEFAULT, CHECK constraints        |
| Status-based workflows         | Active/In Transit/Delivered/Cancelled tracking      |
| Comprehensive sample data      | Realistic test scenarios                            |
| Advanced analytical queries    | CTEs, JOINs, GROUP BY, RANK(), AVG(), DATE functions|
| Production-grade stored procedures | Input validation, error handling (`TRY...CATCH`), transactions |

### Stored Procedures (Phase 3)

```sql
-- Creates a new shipment with full validation
EXEC operations.sp_CreateNewShipment 
    @CustomerID = 5,
    @OriginWarehouseID = 1,
    @DestinationWarehouseID = 3,
    @RouteID = 12;

-- Assigns an available vehicle and driver
EXEC operations.sp_AssignVehicleToShipment 
    @ShipmentID = 101,
    @VehicleID = 8;

-- Updates status and logs the change automatically
EXEC operations.sp_UpdateShipmentStatus 
    @ShipmentID = 101,
    @NewStatus = 'In Transit',
    @UpdatedBy = 'dispatcher_jane';
```

---

## Project Structure

```
/TransGlobalLogisticsDB
│
├── Phase 2 - Foundation
│   ├── 01_Create_Database_and_Schemas.sql
│   ├── 02_Create_Tables.sql
│   ├── 03_Insert_Sample_Data.sql
│   └── 04_Analysis_Queries.sql
│
└── Phase 3 - Advanced Features
    └── Stored_Procedures/
        ├── sp_CreateNewShipment.sql
        ├── sp_AssignVehicleToShipment.sql
        └── sp_UpdateShipmentStatus.sql
```

---

## Example Queries

```sql
-- Top 5 drivers by number of completed shipments this month
SELECT TOP 5 
    d.FirstName + ' ' + d.LastName AS Driver,
    COUNT(s.ShipmentID) AS Deliveries
FROM logistics.Drivers d
JOIN operations.Shipments s ON d.DriverID = s.DriverID
WHERE s.Status = 'Delivered'
  AND MONTH(s.ActualDeliveryDate) = MONTH(GETDATE())
GROUP BY d.DriverID, d.FirstName, d.LastName
ORDER BY Deliveries DESC;

-- Average delivery time per route
WITH DeliveryTimes AS (
    SELECT 
        r.RouteName,
        DATEDIFF(HOUR, s.ScheduledPickup, s.ActualDeliveryDate) AS HoursTaken
    FROM operations.Shipments s
    JOIN logistics.Routes r ON s.RouteID = r.RouteID
    WHERE s.Status = 'Delivered'
)
SELECT RouteName, AVG(HoursTaken) AS AvgHours
FROM DeliveryTimes
GROUP BY RouteName
ORDER BY AvgHours;
```

---

## Skills Strengthened

- Database Design & Normalization
- Schema Organization & Naming Conventions
- Writing Clean, Reusable T-SQL
- Advanced Querying (CTEs, Window Functions)
- Stored Procedures with Error Handling
- Transaction Management
- Audit Logging Patterns
- Real-World Business Logic Modeling

---

## Setup Instructions

1. Open **SQL Server Management Studio (SSMS)**
2. Run scripts in order:
   - Phase 2 → `01_Create_Database_and_Schemas.sql`
   - Phase 2 → `02_Create_Tables.sql`
   - Phase 2 → `03_Insert_Sample_Data.sql`
   - Phase 3 → All stored procedures
3. Explore with the provided analysis queries!

---

## License

This project is open source and available under the **MIT License**.

---

**Built with passion for SQL Server and clean database design**  
Feel free to use this as a learning resource, template, or portfolio project!