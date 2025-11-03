-- Revising Aggregations - The Sum Function
SELECT SUM(POPULATION)
FROM CITY
WHERE DISTRICT = 'california';

-- Average Population

SELECT FLOOR (AVG(POPULATION))
FROM CITY;

-- African Cities

SELECT CITY.NAME
FROM CITY
JOIN COUNTRY ON CITY.CountryCode = COUNTRY.Code
WHERE COUNTRY.CONTINENT = 'Africa';

-- Average Population of Each Continent

SELECT COUNTRY.CONTINENT, FLOOR(AVG(CITY.POPULATION))
FROM CITY
JOIN COUNTRY ON CITY.CountryCode = COUNTRY.Code
GROUP BY COUNTRY.CONTINENT;


-- Placements

SELECT 
    s.Name
FROM Students s
JOIN Friends f ON s.ID = f.ID
JOIN Packages s_salary ON s.ID = s_salary.ID
JOIN Packages f_salary ON f.Friend_ID = f_salary.ID
WHERE f_salary.Salary > s_salary.Salary
ORDER BY f_salary.Salary;