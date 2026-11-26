
Script: 05_staging_load.sql


ALTER SESSION SET CONTAINER = tue_29765_irumva_livestock_db;

-- Drop the table if it exists so the script can be re-run
DROP TABLE staging_cattle;

-- Create the staging table (all columns as text to prevent load errors)
CREATE TABLE staging_cattle (
    Cattle_ID VARCHAR2(100),
    Breed VARCHAR2(100),
    Region VARCHAR2(100),
    Age_Months VARCHAR2(100),
    Farm_ID VARCHAR2(100),
    "Date" VARCHAR2(100),           -- Quoted because DATE is a reserved word in Oracle
    Feed_Type VARCHAR2(100),
    Feed_Quantity_kg VARCHAR2(100),
    Milk_Yield_L VARCHAR2(100)
);
