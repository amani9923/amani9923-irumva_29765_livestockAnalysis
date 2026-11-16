# Phase II: Data Sourcing and Normalization (UNF to 3NF)



## 1. Unnormalized Form (UNF)
The raw data downloaded from FAOSTAT is a single wide table. It contains repeating descriptive information for every single fact row.



**Sample Raw Data:**


| Area Code | Area | Item Code | Item | Element Code | Element | Unit | Year | Value | Flag |
|---|---|---|---|---|---|---|---|---|---|
| 646 | Rwanda | 02211 | Raw milk of cattle | 5510 | Production | t | 2010 | 180000 | FC |
| 646 | Rwanda | 02953 | Raw hides and skins of sheep | 5510 | Production | t | 2010 | 1200 | FC |


## 2. First Normal Form (1NF)

**Rule:** Remove repeating groups, ensure every column holds a single atomic value.
The raw data is already in 1NF. The composite primary key is: `(Area Code, Item Code, Element Code, Year)`.
*No dependency removed yet.*


## 3. Second Normal Form (2NF)

**Rule:** Remove partial dependencies (columns that depend on only *part* of the composite primary key).

**Action taken:**

1. Area : depends only on `Area Code`. I moved this to a new **COUNTRY** table.
2. Item :depends only on `Item Code`. I moved this to a new **ITEM** table.
3. Element : and `Unit` depend only on `Element Code`. I moved these to a new **ELEMENT** table.
4. Flag: depends only on the flag code. I moved this to a new **FLAG** table.

**Remaining Fact Table (PRODUCTION_FACT):**
| Country_ID (FK) | Item_ID (FK) | Element_ID (FK) | Year (PK) | Value | Flag_ID (FK) |
|---|---|---|---|---|---|
| 646 | 02211 | 5510 | 2010 | 180000 | FC |

**Dependency Removed:** Partial dependencies were removed by extracting Country, Item, Element, and Flag into their own tables.

## 4. Third Normal Form (3NF)
**Rule:** Remove transitive dependencies (non-key columns depending on other non-key columns).

**Action taken:**
1. In the **ITEM** table, the item name `"Raw milk of cattle"` implies a species (Cattle) and a product (Milk). I created **SPECIES** and **PRODUCT** tables.
2. In the **ELEMENT** table, the Unit is directly tied to the element (e.g., Production is always in tonnes). I created a **UNIT** table to store unit names properly.

**Final Table Structure (8 Tables):**
*   **COUNTRY** (Country_ID, Country_Name)
*   **SPECIES** (Species_ID, Species_Name)
*   **PRODUCT** (Product_ID, Product_Name)
*   **ITEM** (Item_ID, Item_Name, Species_ID, Product_ID)
*   **UNIT** (Unit_ID, Unit_Name)
*   **ELEMENT** (Element_ID, Element_Name, Unit_ID)
*   **FLAG** (Flag_ID, Flag_Description)
*   **PRODUCTION_FACT** (Country_ID, Item_ID, Element_ID, Year, Value, Flag_ID)

**Dependency Removed:** Transitive dependencies were removed by extracting `Species` and `Product` from the Item name, and `Unit` from the Element.
