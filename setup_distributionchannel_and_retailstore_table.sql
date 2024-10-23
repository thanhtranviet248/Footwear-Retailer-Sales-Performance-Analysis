-- Create distribution channel table
CREATE TABLE distributionchannel
(
	customercode	TEXT		NOT NULL,
	storecode		TEXT		NOT NULL,
	b2bb2c			TEXT		NOT NULL,
	channel			TEXT		NOT NULL,
	citylevel		TEXT		NOT NULL,
	storelevel		TEXT				,
	areagroup		TEXT				,
	urbanization	TEXT		NOT NULL,
	branch			TEXT		NOT NULL,
	showroomarea	DECIMAL				,
	warehousearea	DECIMAL				,
	openmonth		VARCHAR(2)			,
	openyear		VARCHAR(4)			,
	Active			INT			NOT NULL,
	PRIMARY KEY (customercode)
);

-- Copy data to distribution channel table
COPY distributionchannel
FROM 'D:\personal_project\retail_dashboard\distribution.csv'
DELIMITER ','
CSV HEADER;

-- Clean distribution channel table
UPDATE distributionchannel
SET 
    channel = CASE
                  WHEN channel = 'CHTT' THEN 'Retail Store'
                  WHEN channel = 'ONLINE' THEN 'Online'
                  WHEN channel = 'ST' THEN 'Supermarket'
                  ELSE 'Wholesales'
              END,
	citylevel = CASE
                  WHEN citylevel = 'C?p 1' THEN 'Level 1'
                  WHEN citylevel = 'C?p 2' THEN 'Level 2'
				  WHEN citylevel = 'C?p TW' THEN 'Central Level'
                  ELSE 'Others'
              END,
	storelevel = CASE
                  WHEN storelevel = 'TIÊU BI?U' THEN 'Key store'
                  ELSE storelevel
              END,
	urbanization = CASE
                 	WHEN urbanization = 'N?i thành' THEN 'Urban'
				  	WHEN urbanization = 'Nông thôn' THEN 'Rural'
				  	WHEN urbanization = 'TT hành chính kinh t?' THEN 'Key location'
                  	ELSE 'Others'
              	END,
	branch = CASE
                 	WHEN branch = 'CNMN' THEN 'South Area'
				  	WHEN branch = 'CNMB' THEN 'North Area'
				  	WHEN branch = 'CNMT' THEN 'West Area'
				  	WHEN branch = 'CNTR-TN' THEN 'Central-Highland Area'
					WHEN branch = 'CNCA' THEN 'Cambodia'
					ELSE 'Others'
              	END;
select * from distributionchannel;

-- Create retail store table
CREATE TABLE retailstore
(
	customercode	TEXT		NOT NULL,
	storecode		TEXT		NOT NULL,
	b2bb2c			TEXT		NOT NULL,
	channel			TEXT		NOT NULL,
	citylevel		TEXT		NOT NULL,
	storelevel		TEXT				,
	areagroup		TEXT				,
	urbanization	TEXT		NOT NULL,
	branch			TEXT		NOT NULL,
	showroomarea	DECIMAL				,
	warehousearea	DECIMAL				,
	openmonth		VARCHAR(2)			,
	openyear		VARCHAR(4)			,
	Active			INT			NOT NULL,
	PRIMARY KEY (customercode)
);

-- Get data into retail store table
INSERT INTO retailstore
SELECT * FROM distributionchannel WHERE channel = 'Retail Store';