-- Create product table
CREATE TABLE product
(
	sku 			VARCHAR(14)	NOT NULL,
	stylecolor 		VARCHAR(12) 	NOT NULL,
	style 			VARCHAR(9) 	NOT NULL,
	color 			VARCHAR(3),
	colorgroup 		TEXT,
	retailprice 		NUMERIC 	NOT NULL,
	pricegroup 		TEXT,
	brand 			TEXT 		NOT NULL,
	gender 			VARCHAR(3) 	NOT NULL,
	productgroup 		VARCHAR(3) 	NOT NULL,
	detailproductgroup 	VARCHAR(6) 	NOT NULL,
	size 			VARCHAR(2),
	sizerange 		VARCHAR(5),
	agegroup 		TEXT,
	lifestyle 		TEXT,
	launchseason 		VARCHAR(4),
	PRIMARY KEY (sku)
)


-- Copy data to product table
COPY product
FROM 'D:\personal_project\retail_dashboard\product.csv'
DELIMITER ','
CSV HEADER;

-- Clean product table
UPDATE product
	SET colorgroup =
		CASE
			WHEN colorgroup = 'T?I' THEN 'Dark'
			WHEN colorgroup = 'SÁNG' THEN 'Bright'
			WHEN colorgroup = '?EN' THEN 'Black'
			WHEN colorgroup = 'TR?NG' THEN 'White'
			WHEN colorgroup = 'NHI?U MÀU' THEN 'Multicolor' 
			ELSE 'Others'
		END,
		agegroup = REPLACE(REPLACE(agegroup, '??n', 'to'), ' tu?i', '');



