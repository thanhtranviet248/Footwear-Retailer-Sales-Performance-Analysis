# Footwear Retailer Sales Performance Analysis #

## 1. Purpose
The aiming of this project is to visualize the sales data from January 2022 until July 2023 of a footwear retailer on their retail store channel to find out the sales trend as well as exploring new insights that help improve business results.

## 2. Tools used
There are 2 tools used: PostgreSQL and Power BI:
* PostgreSQL: create databases, import data from sources, clean and map the necessary data for Power BI inputs.
* Power BI: calculate metrics using DAX and visualize the data to find insights.

## 3. Process
### Start with PostgreSQL
* Create 4 tables, including 1 fact table (sales) and 3 dimensional tables (calendar, distributionchannel and product).
* Create trigger functions to clean the data.
* Import the data from csv files.
* Recheck the created tables if any errors still occur.
* Create the consolidated view includes sales transaction and necessary dimensions to perform the analysis.

### Continue with Power BI
* Import the consolidated view into Power BI
* Using DAX to calculate some necessary metrics e.,g growth rate, average store revenue, revenue per square meter, etc.
* Visualize the data and figure out the insights.

## 4. Key findings
### Page 1: General
* The peak seasons are in January, August and December --> New Year Eve, Lunar New Year and Back2School.
* The business result in 2023 is worse than 2022 in terms of revenue. Except March and July, the remaining months of 2023 have negative YoY growth rate. --> Further investigate.
* Average price fluctuate over the time, although August-September is peak season but average price is only 12$ --> High demand but low-value products.
### Page 2: Store
* All the stores experience the same sales pattern over the examined time.
* Level-B stores (69 stores) are the main contributors to total revenues at 28% share of business.
* With similar number of stores, the Level-C stores (67 stores) only contribute 15% to total revenue. --> Further investigate.
* Some outstanding stores with good revenue per sqm are 1203, 1123, 1208, 1114, 1109.
* Some key stores such as 1101, although having high revenue contribution but utilization on showroom sqm is still low.
* In a more aggregated view, North area is the best performer when having high utilization on showroom area while Cambodia is in contrary.
### Page 3: Product
* 

