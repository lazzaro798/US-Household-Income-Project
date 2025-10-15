USE us_project;

SELECT * 
FROM us_household_income;


SELECT * 
FROM us_householdincome_statistics;


#Identify States w largest area of land and water
SELECT State_name, SUM(Aland), SUM(AWater)
FROM us_household_income
GROUP BY State_name
ORDER BY 2 desc;

#Find top 10 largest states by land 
SELECT State_name, SUM(Aland)
FROM us_household_income
GROUP BY State_name
ORDER BY 2 desc
LIMIT 10;

#Find top 10 largest states by area of water 
SELECT State_name, SUM(AWater)
FROM us_household_income
GROUP BY State_name
ORDER BY 2 desc
LIMIT 10;

#Join the tables together
SELECT * 
FROM us_household_income ui
JOIN us_householdincome_statistics us
	ON ui.id = us.id
    WHERE MEAN <> 0
;


# Find 5 lowest average income states
SELECT ui.State_name, ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM us_household_income ui
JOIN us_householdincome_statistics us
	ON ui.id = us.id
    WHERE MEAN <> 0
GROUP BY ui.State_name
ORDER BY 2
LIMIT 5;

# Find 5 highest average income states
SELECT ui.State_name, ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM us_household_income ui
JOIN us_householdincome_statistics us
	ON ui.id = us.id
    WHERE MEAN <> 0
GROUP BY ui.State_name
ORDER BY 2 desc
LIMIT 5;


# Average Salary By Type
SELECT Type,  COUNT(Type), ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM us_household_income ui
JOIN us_householdincome_statistics us
	ON ui.id = us.id
    WHERE MEAN <> 0
GROUP BY  type
ORDER BY 2 desc
LIMIT 20;


#identifying where communities are located
SELECT * 
FROM us_household_income 
WHERE Type = 'community'
;


#filtering on types that contain more than 100 entries  as this is the miniumum sample
SELECT Type,  COUNT(Type), ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM us_household_income ui
JOIN us_householdincome_statistics us
	ON ui.id = us.id
    WHERE MEAN <> 0
GROUP BY  type
HAVING COUNT(type) > 100
ORDER BY 2 desc
LIMIT 20;


#Find Highest income cities by avg imcome
SELECT ui.State_name, City, ROUND(AVG(Mean),1)
FROM us_household_income ui
JOIN us_householdincome_statistics us
	ON ui.id = us.id
GROUP BY  ui.state_name, City
ORDER BY 3 desc;

