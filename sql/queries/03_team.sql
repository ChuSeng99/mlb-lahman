WITH t1 AS
(
	SELECT 
		name, 
		SUM(CASE WHEN ws_win = 'Y' THEN 1 ELSE 0 END) AS world_series_won,
		SUM(w) AS regular_game_won,
		SUM(attendance) AS total_home_attendance
	FROM 
		teams 
	WHERE 
		attendance is NOT NULL
		AND year_id >= 2000
	GROUP BY
		name
)

SELECT 
	*,
	RANK() OVER (ORDER BY world_series_won DESC, regular_game_won DESC) AS rank_by_games,
	RANK() OVER (ORDER BY total_home_attendance DESC) AS rank_by_attendance
FROM 
	t1
ORDER BY
	rank_by_games, 
	rank_by_attendance;