SELECT *
FROM sqlite_master;

SELECT 
    team,
    team_code,
    rank,
    association,
    points
FROM ranking_2022;


SELECT 
    team,
    opponent,
    year,
    Round,
    yellow_cards,
    red_cards,
    opponent_yellow_cards,
    opponent_red_cards,
    goals,
    goals_against,
    goal_difference,
    result
FROM matches_simple
WHERE is_home =1;

-- ================================================
SELECT

    CAST(substr(m.year,-2) AS TEXT)
    || '_'
    ||
    CASE
        WHEN m.round = 'Group stage' THEN '1'
        WHEN m.round = 'Round of 16' THEN '2'
        WHEN m.round = 'Quarter-finals' THEN '3'
        WHEN m.round = 'Semi-finals' THEN '4'
        WHEN m.round = 'Third-place match' THEN '5'
        WHEN m.round = 'Final' THEN '6'
    END
    || '_'
    || rt.team_code
    || '_'
    || ro.team_code
    AS match_id,

    m.team,
    m.opponent,
    m.year,
    m.round,

    rt.rank      AS team_rank,
    ro.rank      AS opponent_rank,
    rt.rank - ro.rank  AS rank_difference,

    rt.points    AS team_points,
    ro.points    AS opponent_points,
    rt.points - ro.points AS points_difference,


    m.yellow_cards,
    m.yellow_red_cards,
    m.red_cards,
    m.opponent_yellow_cards,
    m.opponent_yellow_red_cards,
    m.opponent_red_cards,

    -- dados históricos


    -- esse vai ser o target
    (m.yellow_cards + m.yellow_red_cards + m.red_cards 
    + m.opponent_yellow_cards + m.opponent_yellow_red_cards 
    + m.opponent_red_cards) AS match_total_cards

FROM matches_simple m

LEFT JOIN ranking_2022 rt
    ON m.team = rt.team

LEFT JOIN ranking_2022 ro
    ON m.opponent = ro.team

WHERE is_home = 1;