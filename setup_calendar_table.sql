-- Create table calendar
CREATE TABLE calendar
(
    year        	VARCHAR(4) 	NOT NULL, -- 2020
    month       	VARCHAR(2) 	NOT NULL, -- 1, 2, 3,..., 12
    week        	VARCHAR(2) 	NOT NULL, -- 1, 2, 3,..., 52
    lunar_ny    	VARCHAR(3)	NOT NULL, -- Yes/No
    season      	VARCHAR(10), 		  -- 2018T11-02
    month_3char 	VARCHAR(3), 		  -- 001,..., 012
    week_2char		VARCHAR(2), 		  -- 01,...,52
    pk_date 		VARCHAR(9), 		  -- primary key as date (202000101)
    PRIMARY KEY (pk_date)
);

-- Create the trigger function to populate month_3char
CREATE OR REPLACE FUNCTION update_calendar() RETURNS TRIGGER AS $$
BEGIN
	-- update month_3char
    IF LENGTH(NEW.month) = 1 THEN
        NEW.month_3char := CONCAT('00', NEW.month);
    ELSE
        NEW.month_3char := CONCAT('0', NEW.month);
    END IF;
	-- update week_2char
	IF LENGTH(NEW.week) = 1 THEN
        NEW.week_2char := CONCAT('0', NEW.week);
    ELSE
        NEW.week_2char := NEW.week;
    END IF;
	-- update pk_date
	NEW.pk_date := CONCAT(NEW.year, NEW.month_3char, NEW.week_2char);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger
CREATE TRIGGER update_calendar
BEFORE INSERT OR UPDATE ON calendar
FOR EACH ROW
EXECUTE FUNCTION update_calendar();

-- Update data into calendar
COPY calendar (year, month, week, lunar_ny, season)
FROM 'D:\personal_project\retail_dashboard\calendar.csv'
DELIMITER ','
CSV HEADER;

-- Clear null value
DELETE FROM calendar
WHERE season IS NULL;

-- Update lunar_ny to binary
UPDATE calendar
SET lunar_ny =
	CASE
		WHEN lunar_ny = 'No' THEN 0
		ELSE 1
	END;
