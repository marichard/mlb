-- Objective 1
-- How many schools were there that produced MLB players in each decade?
-- What are the names of the top 5 schools that produced the most players?
-- What were the names of the top 3 schools that produced the most players in each decade?
-- lay of the land
SELECT
    *
FROM school_details;

SELECT
    *
FROM schools;

SELECT
    *
FROM players;

SELECT
    *
FROM salaries;

SELECT
    ROUND(yearid, -1) AS decade,
    COUNT(DISTINCT schoolid) AS school_count
FROM schools
GROUP BY decade
ORDER BY decade DESC;