

Project: Livestock Production & Productivity Analysis System
Script: 06_clean


SET SERVEROUTPUT ON;
ALTER SESSION SET CONTAINER = tue_29765_irumva_livestock_db;

-- 1. Trim spaces from text columns
UPDATE staging_cattle 
SET Breed = TRIM(Breed), 
    Farm_ID = TRIM(Farm_ID),
    Feed_Type = TRIM(Feed_Type);
DBMS_OUTPUT.PUT_LINE('Text columns trimmed: ' || SQL%ROWCOUNT || ' rows affected.');

-- 2. Check for exact duplicates and remove them
DELETE FROM staging_cattle 
WHERE ROWID NOT IN (
    SELECT MIN(ROWID) FROM staging_cattle GROUP BY Cattle_ID, "Date"
);
DBMS_OUTPUT.PUT_LINE('Duplicate rows removed: ' || SQL%ROWCOUNT || ' rows affected.');

COMMIT;
