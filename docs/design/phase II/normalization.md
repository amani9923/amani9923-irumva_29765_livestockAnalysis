 Phase II: Data Sourcing and Normalization (UNF to 3NF)

 1. Unnormalized Form (UNF)
The raw Kaggle dataset is a single wide table. It repeats animal profile information (Breed, Age) and Farm details for every single daily production and feed log.

Sample Raw Data (UNF):

| Cattle_ID | Breed | Age_Months | Farm_ID | Date | Feed_Type | Feed_Quantity_kg | Milk_Yield_L 

| CATTLE_000001 | Tharparkar | 32 | FARM_0825 | 2/6/2023 | Hay | 16.8 | 3.08 |
| CATTLE_000002 | Africander | 63 | FARM_0106 | 10/31/2022 | Dry_Fodder | 8.9 | 2.0 |

 2. First Normal Form (1NF)
Rule: Ensure every column holds a single atomic value and remove repeating groups.
The raw data is already in 1NF. Every cell contains one value. The composite primary key for this raw table is (Cattle_ID, Date).

 3. Second Normal Form (2NF)
Rule: Remove partial dependencies (columns that depend on only part of the primary key).
Action taken:
1. Breed and Age_Months depend ONLY on Cattle_ID. These are moved to the LIVESTOCK_REGISTRY table.
2. Farm_ID depends only on the farm, not the specific animal. It is moved to the FARM_UNITS table.
3. The daily metrics (Feed_Type, Feed_Quantity_kg) stay in the FEED_CONSUMPTION table.
4. The daily output (Milk_Yield_L) stays in the PRODUCTION_LOG table.

Dependency Removed: Partial dependencies were removed by extracting the animals permanent profile (Registry) and the farm location away from the daily logs.

4. Third Normal Form (3NF)
Rule: Remove transitive dependencies (non-key columns depending on other non-key columns).
Action taken:
1. In the LIVESTOCK_REGISTRY the Breed implies specific species characteristics. A separate BREED table is created.
2. To support the rest of the project proposal (health and breeding), we structure the database to allow managers to log interventions (HEALTH_INTERVENTIONS, VETERINARIAN) and breeding events (BREEDING_LOG), even though the raw Kaggle file mainly tracks feed/yield.

Dependency Removed: Transitive dependencies (like Breed Name depending on Breed ID) are resolved by creating dedicated lookup tables.

Final Table Structure (8 Tables):
  FARM_UNITS (Unit_ID, Unit_Name, Location)
  BREED (Breed_ID, Breed_Name, Species)
  VETERINARIAN (Vet_ID, Vet_Name, License_Number)
   LIVESTOCK_REGISTRY (Tag_ID, Breed_ID, Unit_ID, Birth_Date, Gender, Sire_ID, Dam_ID)
   PRODUCTION_LOG (Log_ID, Tag_ID, Log_Date, Milk_Yield, Meat_Yield)
   HEALTH_INTERVENTIONS (Intervention_ID, Tag_ID, Vet_ID, Intervention_Date, Treatment, Dosage)
   BREEDING_LOG (Breeding_ID, Dam_ID, Sire_ID, Insemination_Date, Pregnancy_Check_Date, Expected_Birth_Date)
   FEED_CONSUMPTION (Feed_Log_ID, Unit_ID, Feed_Date, Feed_Type, Amount_kg, Cost)








 Raw Field Mapping Checklist




    
| Raw CSV Column | Target Table.Column | Action |
|---|---|---|
| Cattle_ID | LIVESTOCK_REGISTRY.Tag_ID | Direct mapping (String to Varchar) |
| Breed | BREED.Breed_Name | Map to Breed_ID |
| Farm_ID | FARM_UNITS.Unit_ID | Direct mapping |
| Date | PRODUCTION_LOG.Log_Date | Convert Text (MM/DD/YYYY) to DATE |
| Feed_Type | FEED_CONSUMPTION.Feed_Type | Direct mapping |
| Feed_Quantity_kg | FEED_CONSUMPTION.Amount_kg | Convert to NUMBER |
| Milk_Yield_L | PRODUCTION_LOG.Milk_Yield | Convert to NUMBER |
