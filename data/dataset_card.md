# Dataset Card — FAOSTAT Livestock Primary

## Dataset title
FAOSTAT Crops and Livestock Products — Livestock Primary Subset

## Source link
FAO. (2026). FAOSTAT: Crops and livestock products. 
https://www.fao.org/faostat/en/#data/QCL

## Licence
CC BY-NC-SA 3.0 IGO (FAO Open Data). Used for educational purposes with attribution.

## Format and Size
* **Format:** CSV (Comma Separated Values)
* **Size:** 591+ data rows, 14 columns.
* **Date collected:** 16 November 2026.

## What one record represents
One record represents a specific measurement (Value) for a single livestock item (e.g., Raw milk of cattle), in Rwanda, measured by a specific element (e.g., Production), in a specific year.

## Quality Check Report (Do not fix yet, just report)
* **Total rows:** 591+ rows (meets the minimum 500 requirement).
* **Missing Value:** [Open your CSV and check if any Value cells are blank. Type the number here].
* **Duplicate rows:** 0 (The combination of Area, Item, Element, and Year acts as a unique key).
* **Numeric fields stored as text:** The raw CSV stores Value, Year, and all `Codes` as text strings, which will need to be converted to `NUMBER` types during database loading.
* **Units:** The Unit column contains abbreviations (e.g., t for tonnes, kg/An for kg per animal, An for animals).
* **Flags:** The Flag column contains codes indicating data quality (e.g., FC = Calculated data, A = Official figure).
