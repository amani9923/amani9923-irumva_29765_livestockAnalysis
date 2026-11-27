
Project: Livestock Production & Productivity Analysis System
Script: 07_load_tables

ALTER SESSION SET CONTAINER = tue_29765_irumva_livestock_db;

-- 1. PARENT TABLES
INSERT INTO farm_units (unit_id, unit_name, location)
SELECT DISTINCT Farm_ID, Farm_ID, Region 
FROM staging_cattle 
WHERE Farm_ID IS NOT NULL;

INSERT INTO breed (breed_name)
SELECT DISTINCT Breed 
FROM staging_cattle 
WHERE Breed IS NOT NULL;

-- 2. CHILD TABLES
-- Registry (Assuming all are Female for this dataset)
INSERT INTO livestock_registry (tag_id, breed_id, unit_id, birth_date, gender)
SELECT DISTINCT s.Cattle_ID, b.breed_id, s.Farm_ID, 
       ADD_MONTHS(SYSDATE, -TO_NUMBER(s.Age_Months)), 'Female' 
FROM staging_cattle s 
JOIN breed b ON s.Breed = b.breed_name;

-- Production Log
INSERT INTO production_log (tag_id, log_date, milk_yield)
SELECT Cattle_ID, TO_DATE("Date", 'MM/DD/YYYY'), TO_NUMBER(Milk_Yield_L)
FROM staging_cattle
WHERE Milk_Yield_L IS NOT NULL;

-- Feed Consumption
INSERT INTO feed_consumption (unit_id, feed_date, feed_type, amount_kg)
SELECT Farm_ID, TO_DATE("Date", 'MM/DD/YYYY'), Feed_Type, TO_NUMBER(Feed_Quantity_kg)
FROM staging_cattle
WHERE Feed_Quantity_kg IS NOT NULL;

COMMIT;
