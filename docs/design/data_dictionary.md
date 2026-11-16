
# Data Dictionary — Livestock Production System

### 1. Table: COUNTRY
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Country_ID | M49 numerical code for the country | Yes | Yes | Primary Key |
| Country_Name | Name of the country (e.g., Rwanda) | Yes | No | |

### 2. Table: SPECIES
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Species_ID | Unique ID for the animal species | Yes | Yes | Primary Key |
| Species_Name | Name of the species (e.g., Cattle) | Yes | Yes | |

### 3. Table: PRODUCT
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Product_ID | Unique ID for the product type | Yes | Yes | Primary Key |
| Product_Name | Type of product (e.g., Milk, Meat) | Yes | Yes | |

### 4. Table: ITEM
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Item_ID | FAOSTAT item code | Yes | Yes | Primary Key |
| Item_Name | Full FAOSTAT name (e.g., Raw milk of cattle) | Yes | No | |
| Species_ID | Links to the animal species | Yes | No | Foreign Key |
| Product_ID | Links to the product type | Yes | No | Foreign Key |

### 5. Table: UNIT
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Unit_ID | Unique ID for the measurement unit | Yes | Yes | Primary Key |
| Unit_Name | Unit abbreviation (e.g., t, kg/An) | Yes | Yes | |

### 6. Table: ELEMENT
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Element_ID | FAOSTAT element code | Yes | Yes | Primary Key |
| Element_Name | Measurement type (e.g., Production) | Yes | No | |
| Unit_ID | Links to the unit of measurement | Yes | No | Foreign Key |

### 7. Table: FLAG
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Flag_ID | Letter code for data quality | Yes | Yes | Primary Key |
| Flag_Description | Explanation of the code | Yes | No | |

### 8. Table: PRODUCTION_FACT
| Column Name | Meaning | Required? | Unique? | Key Type |
|---|---|---|---|---|
| Country_ID | Country of the record | Yes | No | PK, FK -> COUNTRY |
| Item_ID | Item measured | Yes | No | PK, FK -> ITEM |
| Element_ID | Measurement element | Yes | No | PK, FK -> ELEMENT |
| Year | Year of the measurement | Yes | No | Primary Key |
| Value | The actual numeric value measured | No | No | |
| Flag_ID | Data quality flag for this specific value | No | No | Foreign Key -> FLAG |
