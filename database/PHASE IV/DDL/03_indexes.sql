
ALTER SESSION SET CONTAINER = tue_29765_irumva_livestock_db;

-- 1. INDEX EVERY FOREIGN KEY COLUMN
-- Why: Without this, deleting a parent row (e.g., a Breed) locks the whole child table while Oracle searches for orphans.
CREATE INDEX idx_registry_breed ON livestock_registry(breed_id) TABLESPACE livestock_idx;
CREATE INDEX idx_registry_unit ON livestock_registry(unit_id) TABLESPACE livestock_idx;
CREATE INDEX idx_registry_sire ON livestock_registry(sire_id) TABLESPACE livestock_idx;
CREATE INDEX idx_registry_dam ON livestock_registry(dam_id) TABLESPACE livestock_idx;

CREATE INDEX idx_prod_registry ON production_log(tag_id) TABLESPACE livestock_idx;

CREATE INDEX idx_health_registry ON health_interventions(tag_id) TABLESPACE livestock_idx;
CREATE INDEX idx_health_vet ON health_interventions(vet_id) TABLESPACE livestock_idx;

CREATE INDEX idx_breed_dam ON breeding_log(dam_id) TABLESPACE livestock_idx;
CREATE INDEX idx_breed_sire ON breeding_log(sire_id) TABLESPACE livestock_idx;

CREATE INDEX idx_feed_unit ON feed_consumption(unit_id) TABLESPACE livestock_idx;

-- 2. COMPOSITE INDEX
-- Why: Managers frequently query production by date to get the average milk yield for that day.
CREATE INDEX idx_prod_date_yield ON production_log(log_date, milk_yield) TABLESPACE livestock_idx;

-- 3. FUNCTION-BASED INDEX
-- Why: Users often search for breeds using lowercase (e.g., 'holstein'), bypassing standard indexes. This fixes that.
CREATE INDEX idx_breed_lower_name ON breed(LOWER(breed_name)) TABLESPACE livestock_idx;
