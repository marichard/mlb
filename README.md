# Mlb
Using advanced querying techniques, track how player statistics have changed over time and across different teams in the league.  
Main objectives:  
1. What schools did players attend?
2. How much do teams spend on player salaries?
3. What does each player's career look like?
4. How do player attributes compare?

## Tools
IDE: PyCharm  
Language: SQL  
Database: PostgreSQL   


### Objective 1

1. How many schools produced MLB players in each decade?
```sql
SELECT
    ROUND(yearid, -1) AS decade,
    COUNT(DISTINCT schoolid) AS school_count
FROM schools
GROUP BY decade
ORDER BY decade DESC;
```
Results (sample)
| decade | school\_count |
| :--- | :--- |
| 2010 | 196 |
| 2000 | 467 |
| 1990 | 500 |
| 1980 | 441 |
| 1970 | 366 |
| 1960 | 230 |
| 1950 | 147 |
| 1940 | 159 |
| 1930 | 178 |
| 1920 | 193 |

2. What are the names of the top 5 schools that produced the most players?
```sql
SELECT
    sd.name_full AS school_name,
    COUNT(DISTINCT playerid) AS players_count
FROM schools s
LEFT JOIN school_details sd
    ON s.schoolid = sd.schoolid
GROUP BY school_name
ORDER BY players_count DESC
LIMIT 5;
```
Results  
| school\_name | players\_count |
| :--- | :--- |
| University of Texas at Austin | 107 |
| University of Southern California | 105 |
| Arizona State University | 101 |
| Stanford University | 86 |
| University of Michigan | 76 |

3. What were the names of the top 3 schools that produced the most players in each decade?
```sql
WITH ds AS (SELECT
            ROUND(s.yearid, -1) AS decade,
            sd.name_full AS school_name,
            COUNT(DISTINCT playerid) AS players_count
            FROM schools s
            LEFT JOIN school_details sd
                ON s.schoolid = sd.schoolid
            GROUP BY school_name, decade),

    rn AS (SELECT
        decade,
        school_name,
        players_count,
        ROW_NUMBER() OVER (PARTITION BY decade ORDER BY players_count DESC) AS row_num
    FROM ds)

SELECT
    decade,
    school_name,
    players_count
FROM rn
WHERE row_num <= 3
ORDER BY decade DESC,
         row_num;
```
Results (sample)
| decade | school\_name | players\_count |
| :--- | :--- | :--- |
| 2010 | University of Miami | 14 |
| 2010 | California State University Long Beach | 13 |
| 2010 | Arizona State University | 13 |
| 2000 | Stanford University | 26 |
| 2000 | California State University Fullerton | 24 |
| 2000 | Louisiana State University | 22 |
| 1990 | Stanford University | 26 |
| 1990 | Louisiana State University | 25 |
| 1990 | Florida State University | 22 |
| 1980 | Arizona State University | 34 |
