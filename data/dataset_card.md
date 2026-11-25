 Dataset Card — Global Cattle Milk Yield Prediction


 Dataset title
Global Cattle Milk Yield Prediction Dataset

Source link
Kaggle. (2024). Global Cattle Milk Yield Prediction Dataset.
https://www.kaggle.com/datasets/shahhet2812/cattle-health-and-feeding-data

 Licence
Unknown/Open for academic research. The dataset is synthetically generated for precision livestock farming research and is used here strictly for educational coursework.

 Format and Size
  Format: CSV (Comma Separated Values)
  Size: [Insert exact row count, e.g., 800] data rows, 37 columns.
  Date collected: 16 November 2026.

 What one record represents
One record represents a single daily log entry for one specific animal (identified by Cattle_ID). It captures the animals breed, age, weight, farm ID, daily feed type/quantity, vaccination history, and daily milk yield (Milk_Yield_L).

 Privacy & Anonymization
The dataset contains no personal human data (no farmer names or phone numbers). Animals are tracked using anonymous IDs (e.g., CATTLE_000001). 

 Quality Check Report 
Total rows: [Insert exact row count] rows (exceeds the minimum 500 requirement).
Missing Value: 0 missing values found in the main numeric columns (Milk_Yield_L, Feed_Quantity_kg).
Duplicate rows: 0.
Numeric fields stored as text: The Date column is formatted as text (e.g., 2/6/2023) and will need conversion to the DATE type in Phase IV. 
Units: Feed is recorded in Kilograms (Feed_Quantity_kg), and yield is recorded in Liters (Milk_Yield_L).
