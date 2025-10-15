USE us_project;


SELECT * 
FROM us_household_income;

SELECT * 
FROM us_householdincome_statistics;


#Rename Column
ALTER TABLE us_project.us_householdincome_statistics
RENAME COLUMN `ï»¿id` TO `ID`;

#Count records in each table to confirm whether or not all records were uploaded
SELECT COUNT(ID)
FROM us_householdincome_statistics;

SELECT COUNT(ID)
FROM us_household_income;

# Identifying duplicate IDs in us_household_income
SELECT ID, COUNT(ID)
FROM us_household_income
GROUP BY  ID
HAVING count(ID) > 1
;


# Delete duplicate IDs in us_household_income
DELETE FROM us_household_income
WHERE row_id IN
(SELECT row_id
FROM
	(SELECT row_id, 
	ID,
	ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) as row_num
	FROM us_household_income) as duplicates
	WHERE row_num > 1)
;


# Identifying duplicate IDs in us_householdincome_statistics - no duplicates in this one
SELECT ID, Count(ID)
FROM us_householdincome_statistics
GROUP BY ID
Having COUNT(ID) > 1
;

#Identify State Names that need to be corrected
Select DISTINCT(State_Name)
FROM us_household_income
ORDER BY State_name asc;

#Delete State Names that need to be corrected

UPDATE us_household_income
SET State_name = 'Georgia'
WHERE State_name = 'georia'
;


#Identify State Ab that need to be corrected - N/A
Select DISTINCT state_ab
FROM us_household_income
ORDER BY 1;
 
 
 UPDATE us_household_income
 SET place = 'Autaugaville'
 WHERE County = 'Autauga County'
 AND City = 'Vinemont'
 ;
 
 # Identify fields in Type that need to be corrected
 SELECT Type, COUNT(type)
 FROM us_household_income
 GROUP BY type
 ;
 
 # Update Type fields
 
 UPDATE us_household_income
 SET Type = 'Borough'
 WHERE Type = 'Boroughs'
 ;
 
 
 # Identify potential problems in Awater/Aland - no problems here
 
 SELECT DISTINCT AWater, ALand
 FROM us_household_income
 WHERE AWater = 0 OR AWater = '' OR AWater IS NULL
 ;