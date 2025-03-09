# World Life Expectancy - Data Cleaning
# USE worldlifeexpectancy;

SELECT * 
FROM worldlifeexpectancy.world_life_expectancy;

SELECT * 
FROM world_life_expectancy;

SELECT Country, Year, CONCAT(Country, Year) 
FROM world_life_expectancy
;

SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year)) 
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1
;

SELECT *
FROM (
    SELECT Row_ID,
    CONCAT(Country, Year), ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) 
    ORDER BY CONCAT(Country, Year)) as Row_Num
    FROM world_life_expectancy
    ) AS Row_Table
WHERE Row_Num > 1
;

WITH Row_Table AS (
    SELECT 
        Row_ID,
        ROW_NUMBER() OVER (PARTITION BY Country, Year ORDER BY Row_ID) AS Row_Num
    FROM world_life_expectancy
)
DELETE FROM world_life_expectancy
WHERE Row_ID IN (
    SELECT Row_ID
    FROM Row_Table
    WHERE Row_Num > 1
);

SELECT * 
FROM world_life_expectancy
WHERE Status = '' #blank
; 

SELECT DISTINCT(Status) 
FROM world_life_expectancy
WHERE Status <> ''   # Not blank
; 

SELECT DISTINCT(Country) 
FROM world_life_expectancy
WHERE Status = 'Developing'
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing'   
;

# To verify
SELECT *
FROM world_life_expectancy
WHERE Status = ''   
; 

SELECT *
FROM world_life_expectancy
WHERE Country = 'United States of America'   
; 

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'   
;

SELECT *
FROM world_life_expectancy
WHERE Country = 'United States of America'   
;

# To verify
SELECT *
FROM world_life_expectancy
WHERE Status = ''   
;

# To verify
SELECT *
FROM world_life_expectancy
WHERE Status IS NULL  
;

SELECT *
FROM world_life_expectancy
;

SELECT *
FROM world_life_expectancy
WHERE 'Life expectancy' = ''
;

SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` = '';

SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` IS NULL;

SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy;

SELECT t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
    ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;

# To populate the calculated values to the blacks
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
    ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;

SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy;

