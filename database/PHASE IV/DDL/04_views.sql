

ALTER SESSION SET CONTAINER = tue_29765_irumva_livestock_db;

-- 1. Reporting View (Joins multiple tables into one readable result)
CREATE OR REPLACE VIEW vw_cattle_production AS
SELECT r.tag_id, b.breed_name, f.unit_name, p.log_date, p.milk_yield
FROM livestock_registry r
JOIN breed b ON r.breed_id = b.breed_id
JOIN farm_units f ON r.unit_id = f.unit_id
JOIN production_log p ON r.tag_id = p.tag_id;

-- 2. Summary View (Uses GROUP BY for totals/averages)
CREATE OR REPLACE VIEW vw_breed_yield_summary AS
SELECT b.breed_name, COUNT(r.tag_id) AS total_cows, ROUND(AVG(p.milk_yield), 2) AS avg_milk_yield
FROM breed b
JOIN livestock_registry r ON b.breed_id = r.breed_id
JOIN production_log p ON r.tag_id = p.tag_id
GROUP BY b.breed_name;

-- 3. Protected View (WITH READ ONLY)
-- Why: We use WITH READ ONLY to ensure managers cannot accidentally update or delete 
-- data through this view. It is strictly for reading female cow records.
CREATE OR REPLACE VIEW vw_active_cows AS
SELECT tag_id, breed_id, gender 
FROM livestock_registry 
WHERE gender = 'Female'
WITH READ ONLY;
