-- Create calendar table
CREATE TABLE calendar
(
    year        	VARCHAR(4) 	NOT NULL,
    month       	VARCHAR(3) 	NOT NULL,
    week        	VARCHAR(2) 	NOT NULL,
    lunarnewyear	VARCHAR(3)	NOT NULL,
    season      	VARCHAR(10),
    yearweek		VARCHAR(6),
    PRIMARY KEY (yearweek)
);

-- Create trigger function to clean calendar table
CREATE OR REPLACE FUNCTION clean_calendar() RETURNS TRIGGER AS $$
BEGIN
	-- clean month column
    IF LENGTH(NEW.month) = 1 THEN
        NEW.month := CONCAT('00', NEW.month);
    ELSE
        NEW.month := CONCAT('0', NEW.month);
    END IF;
	-- clean week column
	IF LENGTH(NEW.week) = 1 THEN
        NEW.week := CONCAT('0', NEW.week);
    ELSE
        NEW.week := NEW.week;
    END IF;
	-- clean yearweek column
	NEW.yearweek := CONCAT(NEW.year, NEW.week);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to clean calendar table
CREATE TRIGGER clean_calendar
BEFORE INSERT OR UPDATE ON calendar
FOR EACH ROW
EXECUTE FUNCTION clean_calendar();

-- Update data from csv file into calendar table
COPY calendar (year, month, week, lunarnewyear, season)
FROM 'D:\personal_project\retail_dashboard\calendar.csv'
DELIMITER ','
CSV HEADER;

-- Clean rows where season is null
DELETE FROM calendar
WHERE season IS NULL;

-- Recheck calendar table
SELECT * FROM calendar LIMIT 10;
