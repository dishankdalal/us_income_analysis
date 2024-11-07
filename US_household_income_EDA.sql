# US Household Income EDA
SELECT * from us_household_income_statistics;
SELECT * FROM ushouseholdincome;

## States with their total area in Land and Water
SELECT State_name, SUM(ALand), SUM(AWater)
FROM ushouseholdincome
GROUP BY state_name
ORDER BY 2 DESC
LIMIT 10;
#OR ORDER BY 3 DESC;

## Average Mean and Median income Grouped by State
SELECT inc.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
from ushouseholdincome inc
RIGHT JOIN us_household_income_statistics st 
ON inc.id = st.id
WHERE Mean != 0
GROUP BY inc.State_Name
ORDER BY 3 DESC
LIMIT 10;

## Locality the person lives in w.r.t their income -- Municipality only has 1 record hence the average is so high for municipality

SELECT inc.type, COUNT(inc.type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
from ushouseholdincome inc
INNER JOIN us_household_income_statistics st 
ON inc.id = st.id
WHERE Mean != 0
GROUP BY inc.type
HAVING COUNT(inc.type) > 100
ORDER BY 4 DESC;

## Cities with high salary

SELECT inc.State_Name, City ,ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
from ushouseholdincome inc
INNER JOIN us_household_income_statistics st 
ON inc.id = st.id
GROUP BY inc.State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC
LIMIT 20;