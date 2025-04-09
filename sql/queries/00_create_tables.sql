-- PGADMIN PSQL Tools
-- \copy people FROM 'C:\file\path\People.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'LATIN1');

-- PEOPLE

CREATE TABLE people (
	id				INTEGER PRIMARY KEY,
    player_id     	TEXT, 		  	
    birth_year    	INTEGER,          	
    birth_month   	INTEGER,          	
    birth_day     	INTEGER,          	
    birth_city    	TEXT,             	
    birth_country 	TEXT,             	
    birth_state   	TEXT,             	
    death_year    	INTEGER,          	
    death_month   	INTEGER,          	
    death_day     	INTEGER,          	
    death_country 	TEXT,             	
    death_state   	TEXT,             	
    death_city   	TEXT,             	
    name_first    	TEXT,             	
    name_last     	TEXT,             	
    name_given    	TEXT,             	
    weight       	INTEGER,          	
    height       	INTEGER,          	
    bats         	TEXT,             	
    throws       	TEXT,             	
    debut        	DATE,             	
    retro_id      	TEXT,             	
    final_game    	DATE,             	
    bbref_id      	TEXT              	
);

CREATE UNIQUE INDEX idx_people_player_id
ON people (player_id);

-- TEAMS

CREATE TABLE teams (
	year_id INTEGER,
	lg_id TEXT,
	team_id TEXT,
	franch_id TEXT,
	div_id TEXT,
	rank INTEGER,
	g INTEGER,
	g_home INTEGER,
	w INTEGER,
	l INTEGER,
	div_win TEXT,
	wc_win TEXT,
	lg_win TEXT,
	ws_win TEXT,
	r INTEGER,
	ab INTEGER,
	h INTEGER,
	second_b INTEGER,
	third_b INTEGER,
	hr INTEGER,
	bb INTEGER,
	so INTEGER,
	sb INTEGER,
	cs INTEGER,
	hbp INTEGER,
	sf INTEGER,
	ra INTEGER,
	er INTEGER,
	era DECIMAL,
	cg INTEGER,
	sho INTEGER,
	sv INTEGER,
	ip_outs INTEGER,
	ha INTEGER,
	hra INTEGER,
	bba INTEGER,
	soa INTEGER,
	e INTEGER,
	dp INTEGER,
	fp DECIMAL,
	name TEXT,
	park TEXT,
	attendance INTEGER,
	bpf INTEGER,
	ppf INTEGER,
	team_id_br TEXT,
	team_id_lahman45 TEXT,
	team_id_retro TEXT
);

CREATE INDEX idx_teams_team
ON teams (team_id);

ALTER TABLE teams
ADD CONSTRAINT fk_teams_franchises
FOREIGN key (franch_id)
REFERENCES teams_franchises (franch_id)
ON DELETE CASCADE;

ALTER TABLE teams
ADD CONSTRAINT fk_teams_years
FOREIGN key (year_id)
REFERENCES years (year_id);

-- Teams Franchise

CREATE TABLE teams_franchises (
	franch_id TEXT PRIMARY KEY,
	franch_name TEXT,
	active TEXT,
	na_assoc TEXT
);

-- Parks

CREATE TABLE parks (
	id INTEGER,
	park_alias TEXT,
	park_key TEXT PRIMARY KEY,
	park_name TEXT,
	city TEXT,
	state TEXT,
	country TEXT
);

-- Batting

CREATE TABLE batting (
	player_id TEXT,
	year_id INTEGER,
	stint INTEGER,
	team_id TEXT,
	lg_id TEXT,
	g INTEGER,
	g_batting INTEGER,
	ab INTEGER,
	r INTEGER,
	h INTEGER,
	second_b INTEGER,
	third_b INTEGER,
	hr INTEGER,
	rbi INTEGER,
	sb INTEGER,
	cs INTEGER,
	bb INTEGER,
	so INTEGER,
	ibb INTEGER,
	hbp INTEGER,
	sh INTEGER,
	sf INTEGER,
	gidp INTEGER,
	g_old INTEGER
);

ALTER TABLE batting
ADD CONSTRAINT fk_batting_people
FOREIGN key (player_id)
REFERENCES people (player_id)
ON DELETE CASCADE;

ALTER TABLE batting
ADD CONSTRAINT fk_batting_years
FOREIGN key (year_id)
REFERENCES years (year_id);

-- Pitching

CREATE TABLE pitching (
	player_id TEXT,
	year_id INTEGER,
	stint INTEGER,
	team_id TEXT,
	lg_id TEXT,
	w INTEGER,
	l INTEGER,
	g INTEGER,
	gs INTEGER,
	cg INTEGER,
	sho INTEGER,
	sv INTEGER,
	ip_outs INTEGER,
	h INTEGER,
	er INTEGER,
	hr INTEGER,
	bb INTEGER,
	so INTEGER,
	ba_opp DECIMAL,
	era DECIMAL,
	ibb INTEGER,
	wp INTEGER,
	hbp INTEGER,
	bk INTEGER,
	bfp INTEGER,
	gf INTEGER,
	r INTEGER,
	sh INTEGER,
	sf INTEGER,
	gidp INTEGER
);

ALTER TABLE pitching
ADD CONSTRAINT fk_pitching_people
FOREIGN key (player_id)
REFERENCES people (player_id)
ON DELETE CASCADE;

ALTER TABLE pitching
ADD CONSTRAINT fk_pitching_years
FOREIGN key (year_id)
REFERENCES years (year_id);

-- Fielding

CREATE TABLE fielding (
	player_id TEXT,
	year_id INTEGER,
	stint INTEGER,
	team_id TEXT,
	lg_id TEXT,
	pos TEXT,
	g INTEGER,
	gs INTEGER,
	inn_outs INTEGER,
	po INTEGER,
	a INTEGER,
	e INTEGER,
	dp INTEGER,
	pb INTEGER,
	wp INTEGER,
	sb INTEGER,
	cs INTEGER,
	zr INTEGER
);

-- Fielding OF

CREATE TABLE fielding_of (
	player_id TEXT,
	year_id INTEGER,
	stint INTEGER,
	glf INTEGER,
	gcf INTEGER,
	grf INTEGER
);

-- Fielding OF Split

CREATE TABLE fielding_of_split (
	player_id TEXT,
	year_id INTEGER,
	stint INTEGER,
	team_id TEXT,
	lg_id TEXT,
	pos TEXT,
	g INTEGER,
	gs INTEGER,
	inn_outs INTEGER,
	po INTEGER,
	a INTEGER,
	e INTEGER,
	dp INTEGER,
	pb INTEGER,
	wp INTEGER,
	sb INTEGER,
	cs INTEGER,
	zr INTEGER
);

-- Appearances

CREATE TABLE appearances (
	year_id INTEGER,
	team_id TEXT,
	lg_id TEXT,
	player_id TEXT,
	g_all INTEGER,
	gs INTEGER,
	g_batting INTEGER,
	g_defense INTEGER,
	g_p INTEGER,
	g_c INTEGER,
	g_first_b INTEGER,
	g_second_b INTEGER,
	g_third_b INTEGER,
	g_ss INTEGER,
	g_lf INTEGER,
	g_cf INTEGER,
	g_rf INTEGER,
	g_of INTEGER,
	g_db INTEGER,
	g_ph INTEGER,
	g_pr INTEGER
);

ALTER TABLE appearances
ADD CONSTRAINT fk_appearances_people
FOREIGN key (player_id)
REFERENCES people (player_id)
ON DELETE CASCADE;

ALTER TABLE appearances
ADD CONSTRAINT fk_appearances_years
FOREIGN key (year_id)
REFERENCES years (year_id);

-- Managers

CREATE TABLE managers (
	player_id TEXT,
	year_id INTEGER,
	team_id TEXT,
	lg_id TEXT,
	in_season INTEGER,
	g INTEGER,
	w INTEGER,
	l INTEGER,
	rank INTEGER,
	plyr_mgr TEXT
);

ALTER TABLE managers
ADD CONSTRAINT fk_managers_people
FOREIGN key (player_id)
REFERENCES people (player_id)
ON DELETE CASCADE;

ALTER TABLE managers
ADD CONSTRAINT fk_managers_years
FOREIGN key (year_id)
REFERENCES years (year_id);

-- ALL STAR FULL

CREATE TABLE all_star_full (
	player_id TEXT,
	year_id INTEGER,
	game_num INTEGER,
	game_id TEXT,
	team_id TEXT,
	lg_id TEXT,
	gp INTEGER,
	starting_pos INTEGER
);

ALTER TABLE all_star_full
ADD CONSTRAINT fk_allstar_people
FOREIGN key (player_id)
REFERENCES people (player_id)
ON DELETE CASCADE;

-- Batting Post

CREATE TABLE batting_post (
	year_id INTEGER,
	round TEXT,
	player_id TEXT,
	team_id TEXT,
	lg_id TEXT,
	g INTEGER,
	ab INTEGER,
	r INTEGER,
	h INTEGER,
	second_b INTEGER,
	third_b INTEGER,
	hr INTEGER,
	rbi INTEGER,
	sb INTEGER,
	cs INTEGER,
	bb INTEGER,
	so INTEGER,
	ibb INTEGER,
	hbp INTEGER,
	sh INTEGER,
	sf INTEGER,
	gidp INTEGER
);

ALTER TABLE batting_post
ADD CONSTRAINT fk_batting_post_people
FOREIGN key (player_id)
REFERENCES people (player_id)
ON DELETE CASCADE;

-- Pitching Post

CREATE TABLE pitching_post (
	player_id TEXT,
	year_id INTEGER,
	round TEXT,
	team_id TEXT,
	lg_id TEXT,
	w INTEGER,
	l INTEGER,
	g INTEGER,
	gs INTEGER,
	cg INTEGER,
	sho INTEGER,
	sv INTEGER,
	ip_outs INTEGER,
	h INTEGER,
	er INTEGER,
	hr INTEGER,
	bb INTEGER,
	so INTEGER,
	ba_opp DECIMAL,
	era DECIMAL,
	ibb INTEGER,
	wp INTEGER,
	hbp INTEGER,
	bk INTEGER,
	bfp INTEGER,
	gf INTEGER,
	r INTEGER,
	sh INTEGER,
	sf INTEGER,
	gidp INTEGER
);

ALTER TABLE pitching_post
ADD CONSTRAINT fk_pitching_post_people
FOREIGN key (player_id)
REFERENCES people (player_id)
ON DELETE CASCADE;

-- Fielding Post

CREATE TABLE fielding_post (
	player_id TEXT,
	year_id INTEGER,
	team_id TEXT,
	lg_id TEXT,
	round TEXT,
	pos TEXT,
	g INTEGER,
	gs INTEGER,
	inn_outs INTEGER,
	po INTEGER,
	a INTEGER,
	e INTEGER,
	dp INTEGER,
	tp INTEGER,
	pb INTEGER,
	sb INTEGER,
	cs INTEGER
);

ALTER TABLE fielding_post
ADD CONSTRAINT fk_fielding_post_people
FOREIGN key (player_id)
REFERENCES people (player_id)
ON DELETE CASCADE;

-- Series Post

CREATE TABLE series_post (
	year_id INTEGER,
	round TEXT,
	team_id_winner TEXT,
	lg_id_winner TEXT,
	team_id_loser TEXT,
	lg_id_loser TEXT,
	wins INTEGER,
	losses INTEGER,
	ties INTEGER
);

-- Home Games

CREATE TABLE home_games (
	year_key INTEGER,
	league_key TEXT,
	team_key TEXT,
	park_key TEXT,
	span_first DATE,
	span_last DATE,
	games INTEGER,
	openings INTEGER,
	attendance INTEGER
);

ALTER TABLE home_games
ADD CONSTRAINT fk_home_park
FOREIGN key (park_key)
REFERENCES parks (park_key)
ON DELETE CASCADE;

-- Salaries

CREATE TABLE salaries (
	year_id INTEGER,
	team_id TEXT,
	lg_id TEXT,
	player_id TEXT,
	salary INTEGER
);

ALTER TABLE salaries
ADD CONSTRAINT fk_salaries_people
FOREIGN key (player_id)
REFERENCES people (player_id)
ON DELETE CASCADE;

-- Awards Managers

CREATE TABLE awards_managers (
	player_id TEXT,
	award_id TEXT,
	year_id INTEGER,
	lg_id TEXT,
	tie TEXT,
	notes TEXT
);

ALTER TABLE awards_managers
ADD CONSTRAINT fk_awards_managers_people
FOREIGN key (player_id)
REFERENCES people (player_id)
ON DELETE CASCADE;

-- Awards Players

CREATE TABLE awards_players (
	player_id TEXT,
	award_id TEXT,
	year_id INTEGER,
	lg_id TEXT,
	tie TEXT,
	notes TEXT
);

ALTER TABLE awards_players
ADD CONSTRAINT fk_awards_players_people
FOREIGN key (player_id)
REFERENCES people (player_id)
ON DELETE CASCADE;

-- Awards Share Managers

CREATE TABLE awards_share_managers (
	award_id TEXT,
	year_id INTEGER,
	lg_id TEXT,
	player_id TEXT,
	points_won INTEGER,
	points_max INTEGER,
	votes_first INTEGER
);

ALTER TABLE awards_share_managers
ADD CONSTRAINT fk_awards_share_managers_people
FOREIGN key (player_id)
REFERENCES people (player_id)
ON DELETE CASCADE;

-- Awards Share Players

CREATE TABLE awards_share_players (
	award_id TEXT,
	year_id INTEGER,
	lg_id TEXT,
	player_id TEXT,
	points_won INTEGER,
	points_max INTEGER,
	votes_first INTEGER
);

ALTER TABLE awards_share_players
ADD CONSTRAINT fk_awards_share_players_people
FOREIGN key (player_id)
REFERENCES people (player_id)
ON DELETE CASCADE;

-- Hall of Fame

CREATE TABLE hall_of_fame (
	player_id TEXT,
	year_id INTEGER,
	voted_by TEXT,
	ballots INTEGER,
	needed INTEGER,
	votes INTEGER,
	inducted TEXT,
	category TEXT,
	needed_note TEXT
);

ALTER TABLE hall_of_fame
ADD CONSTRAINT fk_hall_of_fame_people
FOREIGN key (player_id)
REFERENCES people (player_id)
ON DELETE CASCADE;