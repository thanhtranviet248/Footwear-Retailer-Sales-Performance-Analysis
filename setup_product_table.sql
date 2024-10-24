-- Create product table
CREATE TABLE product
(
	sku VARCHAR(14)	NOT NULL,
	stylecolor VARCHAR(12) NOT NULL,
	style VARCHAR(9) NOT NULL,
	color VARCHAR(3),
	colorgroup TEXT,
	retailprice NUMERIC NOT NULL,
	pricegroup TEXT,
	brand TEXT NOT NULL,
	gender VARCHAR(3) NOT NULL,
	productgroup VARCHAR(3) NOT NULL,
	detailproductgroup VARCHAR(6) NOT NULL,
	size VARCHAR(2),
	sizerange VARCHAR(5),
	agegroup TEXT,
	lifestyle TEXT,
	launchseason VARCHAR(4),
	PRIMARY KEY (sku)
)

-- Create trigger function to clean product table
CREATE OR REPLACE FUNCTION clean_product() RETURNS TRIGGER AS $$
BEGIN
	-- clean colorgroup
	IF NEW.colorgroup = 'T?I' 	THEN NEW.colorgroup := 'Dark';
	ELSIF NEW.colorgroup = 'SÁNG' 	THEN NEW.colorgroup := 'Bright';
	ELSIF NEW.colorgroup = '?EN' 	THEN NEW.colorgroup := 'Black';
	ELSIF NEW.colorgroup = 'TR?NG' 	THEN NEW.colorgroup := 'White';
	ELSIF NEW.colorgroup = 'NHI?U MÀU' THEN NEW.colorgroup := 'Multicolor';
	ELSE NEW.colorgroup := 'Others';
	END IF;
	-- clean agegroup
	NEW.agegroup = REPLACE(REPLACE(NEW.agegroup, '??n', 'to'), ' tu?i', '');
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to clean product table
CREATE TRIGGER clean_product
BEFORE INSERT OR UPDATE ON product
FOR EACH ROW
EXECUTE FUNCTION clean_product();

-- Copy data to product table
COPY product
FROM 'D:\personal_project\retail_dashboard\product.csv'
DELIMITER ','
CSV HEADER;

-- Recheck product table data
SELECT * FROM product LIMIT 10;
