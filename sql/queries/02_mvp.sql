SELECT 
	a.year_id,
	COALESCE(MAX(
		CASE WHEN a.lg_id = 'AL' THEN CONCAT(p.name_first, ' ', p.name_last) 
		ELSE NULL END)
	, 'NA') AS al_mvp,
	MAX(
		CASE WHEN a.lg_id = 'AL' THEN s.points_won 
		ELSE 0 END
	) AS al_mvp_points,
	ROUND(
		MAX(CASE WHEN a.lg_id = 'AL' THEN s.points_won ELSE 0 END)::NUMERIC / 
		MAX(CASE WHEN a.lg_id = 'AL' THEN s.points_max ELSE 1 END)
	, 3) AS al_mvp_pct,
	COALESCE(MAX(
		CASE WHEN a.lg_id = 'NL' THEN CONCAT(p.name_first, ' ', p.name_last) 
		ELSE NULL END)
	, 'NA') AS nl_mvp,
	MAX(
		CASE WHEN a.lg_id = 'NL' THEN s.points_won 
		ELSE 0 END
	) AS nl_mvp_points,
	ROUND(
		MAX(CASE WHEN a.lg_id = 'NL' THEN s.points_won ELSE 0 END)::NUMERIC / 
		MAX(CASE WHEN a.lg_id = 'NL' THEN s.points_max ELSE 1 END)
	, 3) AS nl_mvp_pct
FROM 
	awards_players a
		JOIN
	awards_share_players s ON a.player_id = s.player_id AND a.year_id = s.year_id
		JOIN
	people p ON a.player_id = p.player_id
WHERE
	a.award_id = 'Most Valuable Player'
GROUP BY 
	a.year_id
ORDER BY
	a.year_id;