# US Household Income Exploratory Data Analysis

SELECT * 
FROM us_income.us_household_income;

SELECT * 
FROM us_income.us_householdincome_statistics;

SELECT State_Name, County, ALand, AWater
FROM us_income.us_household_income;
;

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_income.us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
;

# Identify the top 10 largest states by land
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_income.us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10
;

# Identify the top 10 largest states by water
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_income.us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10
;

# JOIN the 2 tables 
SELECT * 
FROM us_income.us_household_income u
JOIN us_income.us_householdincome_statistics
    ON u.id = us.id;

# RIGHT JOIN the 2 tables 
SELECT * 
FROM us_income.us_household_income u
RIGHT JOIN us_income.us_householdincome_statistics us
    ON u.id = us.id
WHERE u.id IS NULL;

# Use INNER JOIN the 2 tables so null values are still included data
SELECT * 
FROM us_income.us_household_income u
INNER JOIN us_income.us_householdincome_statistics us
    ON u.id = us.id;

#REMOVE any mean 0 values
SELECT * 
FROM us_income.us_household_income u
INNER JOIN us_income.us_householdincome_statistics us
    ON u.id = us.id
WHERE Mean <> 0;


SELECT u.State_Name, County, Type, `Primary`, Mean, Median 
FROM us_income.us_household_income u
INNER JOIN us_income.us_householdincome_statistics us
    ON u.id = us.id
WHERE Mean <> 0;

#States with lowest household income
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1) 
FROM us_income.us_household_income u
INNER JOIN us_income.us_householdincome_statistics us
    ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2
LIMIT 5;

#States with highest household income
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1) 
FROM us_income.us_household_income u
INNER JOIN us_income.us_householdincome_statistics us
    ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 10;

#States with highest median household income
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1) 
FROM us_income.us_household_income u
INNER JOIN us_income.us_householdincome_statistics us
    ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 3 DESC
LIMIT 10;

#States with highest median household income
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1) 
FROM us_income.us_household_income u
INNER JOIN us_income.us_householdincome_statistics us
    ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 3 ASC
LIMIT 10;


SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1) 
FROM us_income.us_household_income u
INNER JOIN us_income.us_householdincome_statistics us
    ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 2 DESC
LIMIT 20
;

SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1) 
FROM us_income.us_household_income u
INNER JOIN us_income.us_householdincome_statistics us
    ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 4 DESC
LIMIT 20
;

SELECT *
FROM us_household_income
WHERE Type = 'Community';

# Filter out some of the outliers - count lower than 100
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1) 
FROM us_income.us_household_income u
INNER JOIN us_income.us_householdincome_statistics us
    ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
HAVING COUNT(Type) > 100
ORDER BY 4 DESC
LIMIT 20;

SELECT u.State_Name, City, ROUND(AVG(Mean),1)
FROM us_income.us_household_income u
JOIN us_income.us_householdincome_statistics us
    ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY 3 DESC;

SELECT u.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_income.us_household_income u
JOIN us_income.us_householdincome_statistics us
    ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY 3 DESC;




