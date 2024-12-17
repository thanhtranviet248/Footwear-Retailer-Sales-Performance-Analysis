# Footwear Retailer Sales Performance Analysis #

## 1. Objective
This project aims to visualize and analyze the sales data from January 2022 to July 2023 for a footwear retailer's retail store channel. The objective is to identify sales trends and uncover actionable insights to enhance business performance.

## 2. Tools used
Two tools were used, PostgreSQL and Power BI:
* PostgreSQL: Used for database creation, data importation from various sources, data cleaning, and mapping to prepare the necessary inputs for Power BI.
* Power BI: Employed for calculating metrics using DAX and visualizing data to derive actionable insights.

## 3. Process
### Start with PostgreSQL
* Create 4 tables, including 1 fact table (sales) and 3 dimensional tables (calendar, distributionchannel and product).
* Create trigger functions to clean the data.
* Import the data from csv files.
* Recheck the created tables if any errors still occur.
* Create the consolidated view includes sales transaction and necessary dimensions to perform the analysis.

### Continue with Power BI
* Import the consolidated view into Power BI.
* Using DAX to calculate some necessary metrics e.,g growth rate, average store revenue, revenue per square meter, etc.
* Visualize the data and figure out the insights.

## 4. Key findings
### Page 1: General
* Sales peak in January, August, and December, aligning with key events such as New Year’s Eve, Lunar New Year, and the Back-to-School period.
* Business performance in 2023 is weaker compared to 2022, with negative year-over-year (YoY) growth rates in most months except March and July, warranting further investigation.
* Average prices fluctuate over time. Despite August-September being a peak sales season, the average price during this period is only $12, suggesting high demand for low-value products.

### Page 2: Store
* All stores exhibit similar sales trends throughout the analyzed period.
* Level-B stores (69 stores) are the primary revenue contributors, accounting for 28% of total business.
* Despite having a comparable number of stores, Level-C stores (67 stores) contribute only 15% to total revenue, indicating a need for further analysis.
* Notable performers with high revenue per square meter include stores 1203, 1123, 1208, 1114, and 1109.
* Some key stores, such as 1101, despite contributing significantly to revenue, show low utilization of showroom space, requiring further investigation.
* The North region demonstrates strong performance, with high showroom space utilization. In contrast, Cambodia lags behind, with low showroom utilization.

### Page 3: Product
* Men’s products and dark-colored items consistently rank as the top contributors to total revenue throughout the analyzed period.
* During the August-September and December-January periods, products for boys outperform those for girls, indicating a seasonal trend that requires further analysis.
* In August, SANTD products surpass GTTP products as the top revenue contributors, likely driven by the Back-to-School season.
* The retailer's primary customer base falls into three key age groups: 6–11 years old, 16–22 years old, and 23–28 years old.
