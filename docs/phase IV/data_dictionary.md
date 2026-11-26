 Phase IV — Data Dictionary and Table Justifications

 1. Table Design & Normalization Justifications

FARM_UNITS
Purpose: Stores the physical locations/barns where cattle are housed.
Normalization (3NF):Location details depend solely on the Unit_ID. Storing this separately prevents repeating the location for every single animal or feed log, removing transitive dependencies.Keys:Uses a Natural Primary Key (unit_id) because the Farm_ID from the raw data is already a unique, stable identifier.

BREED
Purpose: Lookup table for cattle breeds (e.g., Holstein, Jersey).
Normalization (3NF): In the raw data, the breed name was tied directly to the animal. By creating this table, breed_name depends only on breed_id, removing the transitive dependency (Breed Name -> Breed ID -> Animal).
Keys: Surrogate Primary Key (breed_id).breed_name must be UNIQUE to prevent duplicate breed entries.

VETERINARIAN
Purpose: Stores details of doctors who perform medical interventions.
Normalization (3NF): Vet details depend on vet_id, not on the animal receiving the treatment. This removes partial/transitive dependencies from the health log.
Keys: Surrogate Primary Key (vet_id). license_number is UNIQUE because no two vets can share a medical license.

LIVESTOCK_REGISTRY
Purpose: Master table storing the permanent profile of every individual animal.
Normalization (3NF): This table resolves repeating groups from daily logs. Animal-specific data (birth date, gender) is kept here, while daily metrics are pushed to child tables.
Keys: Natural Primary Key (tag_id), as the Cattle_ID from Kaggle is unique. sire_id and dam_id are self-referencing Foreign Keys pointing to this same table.

PRODUCTION_LOG
  Purpose: Records the daily milk and meat yield for each animal.
   Normalization (3NF): Resolves repeating groups. Each row represents a single days output for a single animal.
Keys: Surrogate Primary Key (log_id). Contains a Composite Unique Constraint UQ (tag_id, log_date) to prevent entering two production logs for the same cow on the same day.

HEALTH_INTERVENTIONS
Purpose: Tracks medical treatments, dates, and dosages.
  Normalization (3NF): Resolves repeating groups by logging each intervention as a separate row.
Keys: Surrogate Primary Key (intervention_id). vet_id is nullable to allow ON DELETE SET NULL if a vet leaves the system.

BREEDING_LOG
Purpose: Tracks insemination dates and pregnancies.
Normalization (3NF): Separates the breeding event from the permanent animal profile.
Keys: Surrogate Primary Key (breeding_id). dam_id is NOT NULL (every calf has a mother), while sire_id is optional.

FEED_CONSUMPTION
Purpose: Tracks daily feed types, amounts, and costs per barn.
Normalization (3NF): Separates feed logs from production logs.
Keys: Surrogate Primary Key (feed_log_id).



 2. Data Dictionary

### FARM_UNITS
| Column | Data type | Null? | Constraint | Why / description |
|---|---|---|---|---|
| unit_id | VARCHAR2(20) | No | PK (pk_farm_units) | Natural key. Uniquely identifies the barn. |
| unit_name | VARCHAR2(50) | No | NOT NULL | The readable name of the barn. |
| location | VARCHAR2(50) | No | NOT NULL | The geographic region of the farm. |

### BREED
| Column | Data type | Null? | Constraint | Why / description |
|---|---|---|---|---|
| breed_id | NUMBER | No | PK (pk_breed) | Surrogate identity key for the breed. |
| breed_name | VARCHAR2(50) | No | UQ, NOT NULL | Name of the breed. Must be unique. |
| species | VARCHAR2(30) | Yes | DEFAULT 'Cattle' | Defaults to Cattle to save data entry time. |

### VETERINARIAN
| Column | Data type | Null? | Constraint | Why / description |
|---|---|---|---|---|
| vet_id | NUMBER | No | PK (pk_vet) | Surrogate identity key for the vet. |
| vet_name | VARCHAR2(50) | No | NOT NULL | Full name of the veterinarian. |
| license_number | VARCHAR2(30) | Yes | UQ | Official medical license. Cannot be duplicated. |

### LIVESTOCK_REGISTRY
| Column | Data type | Null? | Constraint | Why / description |
|---|---|---|---|---|
| tag_id | VARCHAR2(20) | No | PK (pk_registry) | Natural key (Cattle_ID). Uniquely identifies the animal. |
| breed_id | NUMBER | No | FK -> BREED | Links to the breed lookup table. |
| unit_id | VARCHAR2(20) | No | FK -> FARM_UNITS | Links to the barn the animal is housed in. |
| birth_date | DATE | Yes | - | Calculated from the Age_Months in raw data. |
| gender | VARCHAR2(10) | Yes | CK (Male/Female) | Ensures only valid biological sexes are entered. |
| sire_id | VARCHAR2(20) | Yes | FK -> REGISTRY | Father's Tag_ID (Self-referencing). Optional. |
| dam_id | VARCHAR2(20) | Yes | FK -> REGISTRY | Mother's Tag_ID (Self-referencing). Optional. |

### PRODUCTION_LOG
| Column | Data type | Null? | Constraint | Why / description |
|---|---|---|---|---|
| log_id | NUMBER | No | PK (pk_prod_log) | Surrogate identity key for the daily log. |
| tag_id | VARCHAR2(20) | No | FK -> REGISTRY | Links the yield to a specific cow. |
| log_date | DATE | No | NOT NULL | The date the production was recorded. |
| milk_yield | NUMBER(6,2) | Yes | CK (>= 0) | Cannot have negative milk. |
| meat_yield | NUMBER(6,2) | Yes | CK (>= 0) | Cannot have negative meat. |
| *(composite)* | - | - | UQ (tag_id, log_date) | Prevents double-logging the same cow on the same day. |

### HEALTH_INTERVENTIONS
| Column | Data type | Null? | Constraint | Why / description |
|---|---|---|---|---|
| intervention_id | NUMBER | No | PK (pk_health) | Surrogate identity key for the medical record. |
| tag_id | VARCHAR2(20) | No | FK -> REGISTRY | Which cow received treatment. |
| vet_id | NUMBER | Yes | FK -> VET | Which vet performed it. Optional to allow SET NULL. |
| intervention_date | DATE | No | NOT NULL | When the treatment happened. |
| treatment | VARCHAR2(100) | Yes | - | Description of the medical action. |
| dosage | VARCHAR2(50) | Yes | - | Amount of drug given. |

### BREEDING_LOG
| Column | Data type | Null? | Constraint | Why / description |
|---|---|---|---|---|
| breeding_id | NUMBER | No | PK (pk_breeding) | Surrogate identity key for the breeding event. |
| dam_id | VARCHAR2(20) | No | FK -> REGISTRY | Mother. Cannot be null (every calf has a mother). |
| sire_id | VARCHAR2(20) | Yes | FK -> REGISTRY | Father. Optional (may be unknown). |
| insemination_date | DATE | No | NOT NULL | Date of the breeding event. |
| pregnancy_check_date | DATE | Yes | - | Date pregnancy was confirmed. |
| expected_birth_date | DATE | Yes | - | Calculated due date. |

### FEED_CONSUMPTION
| Column | Data type | Null? | Constraint | Why / description |
|---|---|---|---|---|
| feed_log_id | NUMBER | No | PK (pk_feed) | Surrogate identity key. |
| unit_id | VARCHAR2(20) | No | FK -> FARM_UNITS | Which barn was fed. |
| feed_date | DATE | No | NOT NULL | When the feed was given. |
| feed_type | VARCHAR2(50) | Yes | - | Type of feed (e.g., Hay, Silage). |
| amount_kg | NUMBER(6,2) | Yes | CK (> 0) | Feed amount must be greater than zero. |
| cost | NUMBER(8,2) | Yes | - | Financial cost of the feed. |

---

 3. Foreign Key Decision Table

| Foreign key name | Child table | Parent table | Rule chosen | What happens when the parent changes | When and why to apply it |
|---|---|---|---|---|---|
| fk_reg_unit | LIVESTOCK_REGISTRY | FARM_UNITS | ON DELETE CASCADE | Child rows (animals) are automatically deleted. | If a barn is permanently closed and demolished, all animals in it are removed from the registry. |
| fk_feed_unit | FEED_CONSUMPTION | FARM_UNITS | ON DELETE CASCADE | Child feed logs are deleted. | If a barn is removed, its historical feed logs are no longer needed. |
| fk_prod_registry | PRODUCTION_LOG | LIVESTOCK_REGISTRY | ON DELETE CASCADE | Child production logs are deleted. | If a cow dies or is sold and removed from the registry, her production history should be deleted. |
| fk_health_registry | HEALTH_INTERVENTIONS | LIVESTOCK_REGISTRY | ON DELETE CASCADE | Child health records are deleted. | Medical history is useless without the animal. |
| fk_breed_dam | BREEDING_LOG | LIVESTOCK_REGISTRY | ON DELETE CASCADE | Child breeding logs are deleted. | If the mother is removed, the breeding record is deleted. |
| fk_health_vet | HEALTH_INTERVENTIONS | VETERINARIAN | ON DELETE SET NULL | The vet_id in the child table is set to NULL. | If a vet leaves the farm, we do not want to lose the animal's medical history. The record stays, but the vet link is nullified. |
| fk_breed_sire | BREEDING_LOG | LIVESTOCK_REGISTRY | ON DELETE SET NULL | The sire_id is set to NULL. | If the father's record is deleted, we keep the breeding log but mark the father as unknown (NULL). |
| fk_reg_breed | LIVESTOCK_REGISTRY | BREED | NO ACTION | Deletion is rejected with an error. | You should not be able to delete a breed (e.g., Holstein) if there are still cows registered under that breed. |

---

## 4. Handling Key Updates in Oracle
Because Oracle does not support ON UPDATE CASCADE like MySQL or SQL Server, we handle primary key updates by enforcing immutability. 
We chose surrogate keys (auto-generated identity numbers like breed_id, log_id) for our primary keys specifically so they never need to change. If a natural key (like breed_name or license_number) needs to be updated, we update that specific column directly, without affecting the relationships of the child tables. This prevents orphaned records and maintains referential integrity without needing cascade updates.
