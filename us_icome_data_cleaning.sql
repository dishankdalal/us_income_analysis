# US Household Income Data Cleaning
SELECT * FROM ushouseholdincome;
SELECT * from us_household_income_statistics;

# Finding for Duplicate records -- US House Hold Income

SELECT id, COUNT(id)
FROM ushouseholdincome
GROUP BY id
HAVING COUNT(id) > 1;

DELETE FROM ushouseholdincome
WHERE row_id IN (
					SELECT row_id
					FROM (
							SELECT row_id,
							id,
							ROW_NUMBER() OVER(partition by id ORDER BY id) AS row_num
							FROM ushouseholdincome) as row_table
WHERE row_num > 1);

SELECT * 
FROM (
SELECT row_id, id,
ROW_NUMBER() OVER (partition by id ORDER BY id) row_num
FROM ushouseholdincome) AS duplicates
WHERE row_num > 1;

# Finding for Duplicate Records -- US HouseHold Statistics
SELECT * from us_household_income_statistics;



SELECT id, COUNT(id)
FROM us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1; -- No Duplicates

## State Name fixing 
 SELECT DISTINCT State_Name
 FROM ushouseholdincome
 GROUP BY state_name;
 
 UPDATE ushouseholdincome
 SET State_Name = 'Georgia'
 WHERE State_Name = 'georia';
 
UPDATE ushouseholdincome
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';

 SELECT DISTINCT State_ab
 FROM ushouseholdincome
 GROUP BY state_ab;
 
 SELECT *
 FROM ushouseholdincome
 WHERE County = 'Autauga County';
 
 UPDATE ushouseholdincome
 SET Place = 'Autaugaville'
 WHERE County = 'Autauga County'
 AND City = 'Vinemont';
 
 # Spelling Error in type column
 SELECT type, COUNT(type) from ushouseholdincome
 GROUP BY type;
 
 UPDATE ushouseholdincome
 SET type = 'Borough'
 WHERE type = 'Boroughs';
 
 # Checking for Nulls and 0's in ALand and AWater column
 SELECT ALand, AWater
 FROM ushouseholdincome
 WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
 AND (ALand = 0 OR ALand = '' OR ALand IS NULL); -- There were 0's in both AWater and ALand but it did not have 0 in both columns for the same row so either it was fully Water or Land
 
