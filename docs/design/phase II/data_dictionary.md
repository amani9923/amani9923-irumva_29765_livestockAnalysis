# Data Dictionary — Livestock Production System

### 1. Table: FARM_UNITS
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Unit_ID | Unique ID for the barn/section (Farm_ID) | Yes | Yes | Primary Key |
| Unit_Name | Name of the barn (e.g., Barn A) | Yes | No | |
| Location | Physical location on the farm (Region) | Yes | No | |

### 2. Table: BREED
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Breed_ID | Unique ID for the breed | Yes | Yes | Primary Key |
| Breed_Name | Name of breed (e.g., Holstein) | Yes | Yes | |
| Species | Animal species (e.g., Cattle) | Yes | No | |

### 3. Table: VETERINARIAN
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Vet_ID | Unique ID for the vet | Yes | Yes | Primary Key |
| Vet_Name | Name of the doctor | Yes | No | |
| License_Number | Official medical license | Yes | Yes | |

### 4. Table: LIVESTOCK_REGISTRY
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Tag_ID | Ear tag identifier (Cattle_ID) | Yes | Yes | Primary Key |
| Breed_ID | Links to the animal's breed | Yes | No | Foreign Key |
| Unit_ID | Links to the animal's barn | Yes | No | Foreign Key |
| Birth_Date | Date the animal was born | Yes | No | |
| Gender | Male or Female | Yes | No | |
| Sire_ID | Father's Tag_ID | No | No | |
| Dam_ID | Mother's Tag_ID | No | No | |

### 5. Table: PRODUCTION_LOG
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Log_ID | Unique ID for the daily log | Yes | Yes | Primary Key |
| Tag_ID | Links to the animal | Yes | No | Foreign Key |
| Log_Date | Date of production | Yes | No | |
| Milk_Yield | Liters of milk produced | No | No | |
| Meat_Yield | Kg of meat produced | No | No | |

### 6. Table: HEALTH_INTERVENTIONS
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Intervention_ID | Unique ID for medical record | Yes | Yes | Primary Key |
| Tag_ID | Links to the animal | Yes | No | Foreign Key |
| Vet_ID | Links to the doctor | Yes | No | Foreign Key |
| Intervention_Date | Date of treatment | Yes | No | |
| Treatment | Type of medical action | Yes | No | |
| Dosage | Amount of drug given | No | No | |

### 7. Table: BREEDING_LOG
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Breeding_ID | Unique ID for breeding event | Yes | Yes | Primary Key |
| Dam_ID | Mother's Tag_ID | Yes | No | Foreign Key |
| Sire_ID | Father's Tag_ID | Yes | No | Foreign Key |
| Insemination_Date | Date of breeding | Yes | No | |
| Pregnancy_Check_Date | Date pregnancy confirmed | No | No | |
| Expected_Birth_Date | Calculated due date | No | No | |

### 8. Table: FEED_CONSUMPTION
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Feed_Log_ID | Unique ID for feed record | Yes | Yes | Primary Key |
| Unit_ID | Links to the barn/group fed | Yes | No | Foreign Key |
| Feed_Date | Date feed was given | Yes | No | |
| Feed_Type | Type of feed used | Yes | No | |
| Amount_kg | Weight of feed in kg | Yes | No | |
| Cost | Cost of the feed | No | No | |
