-- Create calendar table
CREATE TABLE calendar
(
    year        	VARCHAR(4) 	NOT NULL, -- 2020
    month       	VARCHAR(3) 	NOT NULL, -- 1, 2, 3,..., 12
    week        	VARCHAR(2) 	NOT NULL, -- 1, 2, 3,..., 52
	lunarnewyear	VARCHAR(3)	NOT NULL, -- Yes/No
    season      	VARCHAR(10),          -- 2018T11-02
	pk_yearweek		VARCHAR(6),           -- 202001
	PRIMARY KEY (pk_yearweek)
);

-- Create trigger function to clean calendar table
CREATE OR REPLACE FUNCTION clean_calendar() RETURNS TRIGGER AS $$
BEGIN
	-- clean month
    IF LENGTH(NEW.month) = 1 THEN
        NEW.month := CONCAT('00', NEW.month);
    ELSE
        NEW.month := CONCAT('0', NEW.month);
    END IF;
	-- clean week_2char
	IF LENGTH(NEW.week) = 1 THEN
        NEW.week := CONCAT('0', NEW.week);
    ELSE
        NEW.week := NEW.week;
    END IF;
	-- clean pk_date
	NEW.pk_yearweek := CONCAT(NEW.year, NEW.week);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger
CREATE TRIGGER clean_calendar
BEFORE INSERT OR UPDATE ON calendar
FOR EACH ROW
EXECUTE FUNCTION clean_calendar();

-- Update data into calendar table
COPY calendar (year, month, week, lunarnewyear, season)
FROM 'D:\personal_project\retail_dashboard\calendar.csv'
DELIMITER ','
CSV HEADER;

-- Clean null value in season
DELETE FROM calendar
WHERE season IS NULL;

-- Recheck calendar table
select * from calendar limit 10;
