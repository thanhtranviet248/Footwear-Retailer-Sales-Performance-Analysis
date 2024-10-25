-- Create distribution channel table
CREATE TABLE distributionchannel
(
	customercode		TEXT		NOT NULL,
	storecode		TEXT		NOT NULL,
	b2bb2c			TEXT		NOT NULL,
	channel			TEXT		NOT NULL,
	citylevel		TEXT		NOT NULL,
	storelevel		TEXT			,
	areagroup		TEXT			,
	urbanization		TEXT		NOT NULL,
	branch			TEXT		NOT NULL,
	showroomarea		DECIMAL			,
	warehousearea		DECIMAL			,
	openmonth		VARCHAR(2)		,
	openyear		VARCHAR(4)		,
	Active			INT		NOT NULL,
	PRIMARY KEY (customercode)
);

-- Create trigger function to clean distribution channel table
CREATE OR REPLACE FUNCTION clean_distributionchannel() RETURNS TRIGGER AS $$
BEGIN
	-- clean channel column
	IF 	NEW.channel = 'CHTT' 		THEN NEW.channel := 'Retail Store';
	ELSIF	NEW.channel = 'ONLINE' 		THEN NEW.channel := 'Online';
	ELSIF	NEW.channel = 'ST' 		THEN NEW.channel := 'Supermarket';
	ELSE	NEW.channel := 'Wholesales';
	END IF;
	-- clean citylevel column
	IF 	NEW.citylevel = 'C?p 1' 	THEN NEW.citylevel := 'Level 1';
	ELSIF	NEW.citylevel = 'C?p 2' 	THEN NEW.citylevel := 'Level 2';
	ELSIF	NEW.citylevel = 'C?p TW' 	THEN NEW.citylevel := 'Central Level';
	ELSE	NEW.citylevel := 'Others';
	END IF;
	-- clean storelevel column
	IF 	NEW.storelevel = 'TIÊU BI?U' 	THEN NEW.storelevel := 'Key store';
	ELSE	NEW.storelevel := NEW.storelevel;
	END IF;
	-- clean urbanization column
	IF 	NEW.urbanization = 'N?i thành'	THEN NEW.urbanization := 'Urban';
	ELSIF	NEW.urbanization = 'Nông thôn' 	THEN NEW.urbanization := 'Rural';
	ELSIF	NEW.urbanization = 'TT hành chính kinh t?' THEN NEW.urbanization := 'Key Location';
	ELSE	NEW.urbanization := 'Others';
	END IF;
	-- clean branch column
	IF 	NEW.branch = 'CNMN'		THEN NEW.branch := 'South Area';
	ELSIF	NEW.branch = 'CNMB' 		THEN NEW.branch := 'North Area';
	ELSIF	NEW.branch = 'CNMT'		THEN NEW.branch := 'West Area';
	ELSIF	NEW.branch = 'CNTR-TN'		THEN NEW.branch := 'Central-Highland Area';
	ELSIF	NEW.branch = 'CNCA'		THEN NEW.branch := 'Cambodia';
	ELSE	NEW.branch := 'Others';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to clean distribution channel table
CREATE TRIGGER clean_distributionchannel
BEFORE INSERT OR UPDATE ON distributionchannel
FOR EACH ROW
EXECUTE FUNCTION clean_distributionchannel();

-- Copy data from csv file to distribution channel table
COPY distributionchannel
FROM 'D:\personal_project\retail_dashboard\distribution.csv'
DELIMITER ','
CSV HEADER;

-- Recheck distribution channel data
SELECT * FROM distributionchannel LIMIT 10;
