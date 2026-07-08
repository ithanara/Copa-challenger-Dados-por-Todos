-- ============================================
-- 01. view simplificada dos matches
-- ============================================
DROP VIEW IF EXISTS matches_simple;
CREATE VIEW matches_simple AS

-- perspectiva do time de casa
SELECT
    Year,
    home_team AS team,
    away_team AS opponent,
    home_score AS goals,
    away_score AS goals_against,
    home_score - away_score AS goal_difference,
    home_xg AS xg,
    away_xg AS xg_against,
    home_penalty AS penalty,
    away_penalty AS opponent_penalty,
    Round,
    1 AS is_home,

    CASE
        WHEN home_score > away_score THEN 'Win'
        WHEN home_score < away_score THEN 'Loss'
        ELSE 'Draw'
    END AS result,

    CASE
        WHEN home_yellow_card_long IS NULL OR home_yellow_card_long = '' THEN 0
        ELSE LENGTH(home_yellow_card_long)
             - LENGTH(REPLACE(home_yellow_card_long, ',', ''))
             + 1
    END AS yellow_cards,

    CASE
        WHEN home_yellow_red_card IS NULL OR home_yellow_red_card = '' THEN 0
        ELSE 1
    END AS yellow_red_cards,

    CASE
        WHEN home_red_card IS NULL OR home_red_card = '' THEN 0
        ELSE 1
    END AS red_cards,

    CASE
        WHEN away_yellow_card_long IS NULL OR away_yellow_card_long = '' THEN 0
        ELSE LENGTH(away_yellow_card_long)
             - LENGTH(REPLACE(away_yellow_card_long, ',', ''))
             + 1
    END AS opponent_yellow_cards,

    CASE
        WHEN away_yellow_red_card IS NULL OR away_yellow_red_card = '' THEN 0
        ELSE 1
    END AS opponent_yellow_red_cards,

    CASE
        WHEN away_red_card IS NULL OR away_red_card = '' THEN 0
        ELSE 1
    END AS opponent_red_cards

FROM matches
WHERE Year >= 2018

UNION ALL

-- perspectiva do oponente
SELECT
    Year,
    away_team AS team,
    home_team AS opponent,
    away_score AS goals,
    home_score AS goals_against,
    away_score - home_score AS goal_difference,
    away_xg AS xg,
    home_xg AS xg_against,
    away_penalty AS penalty,
    home_penalty AS opponent_penalty,
    Round,
    0 AS is_home,

    CASE
        WHEN away_score > home_score THEN 'Win'
        WHEN away_score < home_score THEN 'Loss'
        ELSE 'Draw'
    END AS result,

    CASE
        WHEN away_yellow_card_long IS NULL OR away_yellow_card_long = '' THEN 0
        ELSE LENGTH(away_yellow_card_long)
             - LENGTH(REPLACE(away_yellow_card_long, ',', ''))
             + 1
    END AS yellow_cards,

    CASE
        WHEN away_yellow_red_card IS NULL OR away_yellow_red_card = '' THEN 0
        ELSE 1
    END AS yellow_red_cards,

    CASE
        WHEN away_red_card IS NULL OR away_red_card = '' THEN 0
        ELSE 1
    END AS red_cards,

    CASE
        WHEN home_yellow_card_long IS NULL OR home_yellow_card_long = '' THEN 0
        ELSE LENGTH(home_yellow_card_long)
             - LENGTH(REPLACE(home_yellow_card_long, ',', ''))
             + 1
    END AS opponent_yellow_cards,

    CASE
        WHEN home_yellow_red_card IS NULL OR home_yellow_red_card = '' THEN 0
        ELSE 1
    END AS opponent_yellow_red_cards,

    CASE
        WHEN home_red_card IS NULL OR home_red_card = '' THEN 0
        ELSE 1
    END AS opponent_red_cards

FROM matches
WHERE Year >= 2018;

SELECT * 
FROM matches_simple;

-- ============================================
-- 02. view das prorrogações
-- ============================================
DROP VIEW IF EXISTS matches_shootout;
CREATE VIEW matches_shootout AS

-- perspectiva do time de casa
SELECT
    Year,
    home_team AS team,
    away_team AS opponent,
    home_score AS goals,
    away_score AS goals_against,
    home_score - away_score AS goal_difference,

    CASE
        WHEN home_penalty_shootout_goal_long IS NULL OR home_penalty_shootout_goal_long = '' THEN 0
        ELSE LENGTH(home_penalty_shootout_goal_long)
             - LENGTH(REPLACE(home_penalty_shootout_goal_long, ',', ''))
             + 1
    END AS penalty_goal,

    CASE
        WHEN away_penalty_shootout_goal_long IS NULL OR away_penalty_shootout_goal_long = '' THEN 0
        ELSE LENGTH(away_penalty_shootout_goal_long)
             - LENGTH(REPLACE(away_penalty_shootout_goal_long, ',', ''))
             + 1
    END AS opponent_penalty_goal,

    CASE
        WHEN home_penalty_shootout_miss_long IS NULL OR home_penalty_shootout_miss_long = '' THEN 0
        ELSE LENGTH(home_penalty_shootout_miss_long)
             - LENGTH(REPLACE(home_penalty_shootout_miss_long, ',', ''))
             + 1
    END AS penalty_miss,

    CASE
        WHEN away_penalty_shootout_miss_long IS NULL OR away_penalty_shootout_miss_long = '' THEN 0
        ELSE LENGTH(away_penalty_shootout_miss_long)
             - LENGTH(REPLACE(away_penalty_shootout_miss_long, ',', ''))
             + 1
    END AS opponent_penalty_miss,
    Score,
    Round,
    1 AS is_home

FROM matches
WHERE Year >= 2018 AND goal_difference = 0 AND round <> 'Group stage'

UNION ALL

-- Perspectiva do oponente
SELECT
    Year,
    home_team AS opponent,
    away_team AS team,
    home_score AS goals_against,
    away_score AS goals,
    home_score - away_score AS goal_difference,

    CASE
        WHEN home_penalty_shootout_goal_long IS NULL OR home_penalty_shootout_goal_long = '' THEN 0
        ELSE LENGTH(home_penalty_shootout_goal_long)
             - LENGTH(REPLACE(home_penalty_shootout_goal_long, ',', ''))
             + 1
    END AS opponent_penalty_goal,

    CASE
        WHEN away_penalty_shootout_goal_long IS NULL OR away_penalty_shootout_goal_long = '' THEN 0
        ELSE LENGTH(away_penalty_shootout_goal_long)
             - LENGTH(REPLACE(away_penalty_shootout_goal_long, ',', ''))
             + 1
    END AS penalty_goal,

    CASE
        WHEN home_penalty_shootout_miss_long IS NULL OR home_penalty_shootout_miss_long = '' THEN 0
        ELSE LENGTH(home_penalty_shootout_miss_long)
             - LENGTH(REPLACE(home_penalty_shootout_miss_long, ',', ''))
             + 1
    END AS opponent_penalty_miss,

    CASE
        WHEN away_penalty_shootout_miss_long IS NULL OR away_penalty_shootout_miss_long = '' THEN 0
        ELSE LENGTH(away_penalty_shootout_miss_long)
             - LENGTH(REPLACE(away_penalty_shootout_miss_long, ',', ''))
             + 1
    END AS penalty_miss,
    Score,
    Round,
    0 AS is_home

FROM matches
WHERE Year >= 2018 AND goal_difference = 0 AND round <> 'Group stage';

SELECT * 
FROM matches_shootout;