-- Objective 1
-- lay of the land
SELECT
    *
FROM players;

SELECT
    *
FROM salaries;

SELECT
    *
FROM school_details;

SELECT
    *
FROM schools;

-- How many schools were there that produced MLB players in each decade?
SELECT
    ROUND(yearid, -1) AS decade,
    COUNT(DISTINCT schoolid) AS school_count
FROM schools
GROUP BY decade
ORDER BY decade DESC;

-- What are the names of the top 5 schools that produced the most players?
SELECT
    sd.name_full AS school_name,
    COUNT(DISTINCT playerid) AS players_count
FROM schools s
LEFT JOIN school_details sd
    ON s.schoolid = sd.schoolid
GROUP BY school_name
ORDER BY players_count DESC
LIMIT 5;

-- What were the names of the top 3 schools that produced the most players in each decade?


