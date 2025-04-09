WITH t1 AS
(
    SELECT 
        *,
        COUNT(1) OVER (PARTITION BY year_id) AS total_players,
        ROW_NUMBER() OVER (PARTITION BY year_id ORDER BY salary DESC) AS rn 
    FROM 
        salaries
),

t2 AS 
(
	SELECT 
		year_id,
		ROUND(AVG(salary), 0) AS median_salary
	FROM 
		t1 
	WHERE
		rn IN ((total_players + 1) / 2, (total_players + 2) / 2)
	GROUP BY
		year_id
)

SELECT
    t1.year_id AS year,
    t.name AS team_name,
    CONCAT(p.name_first, ' ', p.name_last) AS highest_salary_player,
    t1.salary AS highest_salary,
    t2.median_salary,
    ROUND((t1.salary / t2.median_salary), 1) AS ratio
FROM
    t1
        JOIN
    t2 ON t1.year_id = t2.year_id
    	JOIN
    people p ON t1.player_id = p.player_id
    	JOIN
    teams t ON t1.team_id = t.team_id AND t1.year_id = t.year_id
WHERE
    t1.rn = 1
ORDER BY
    t1.year_id;