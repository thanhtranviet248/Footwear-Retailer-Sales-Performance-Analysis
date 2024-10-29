-- Create inventory table
CREATE TABLE inventory
(
	storecode		VARCHAR(4)	NOT NULL,
	sku			VARCHAR(14)	NOT NULL,
	year			TEXT		NOT NULL,
	month			TEXT		NOT NULL,
	sloc			VARCHAR(4)	NOT NULL,
	inventoryqty		NUMERIC			,
	inventoryvalue		NUMERIC			,
	FOREIGN KEY (sku) REFERENCES product(sku)
);

-- Copy data to inventory table
COPY inventory (storecode, sku, year, month, sloc, inventoryqty, inventoryvalue)
FROM 'D:\personal_project\retail_dashboard\inventory.csv'
DELIMITER ','
CSV HEADER;

-- Recheck inventory table data
select * from inventory limit 10;
