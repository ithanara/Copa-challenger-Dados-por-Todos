-- ============================================
-- 1. view do teste
-- ============================================
DROP VIEW IF EXISTS ml_features;
CREATE VIEW ml_features AS

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

    -- dados históricos do time
    ts.games_last2wc,
    ts.total_cards AS team_total_cards,
    ts.avg_yellow AS team_avg_yellow,
    ts.avg_yellow_red AS team_avg_yellow_red,
    ts.avg_red AS team_avg_red,
    ts.avg_total_cards AS team_avg_total_cards,

    -- dados históricos do adversário
    os.games_last2wc AS opponent_games_last2wc,
    os.total_cards AS opponent_total_cards,
    os.avg_yellow AS opponent_avg_yellow,
    os.avg_yellow_red AS opponent_avg_yellow_red,
    os.avg_red AS opponent_avg_red,
    os.avg_total_cards AS opponent_avg_total_cards,

    -- esse vai ser o target
    (m.yellow_cards + m.yellow_red_cards + m.red_cards 
    + m.opponent_yellow_cards + m.opponent_yellow_red_cards 
    + m.opponent_red_cards) AS match_total_cards

FROM matches_simple m

LEFT JOIN ranking_2022 rt
    ON m.team = rt.team

LEFT JOIN ranking_2022 ro
    ON m.opponent = ro.team

LEFT JOIN team_stats ts
    ON m.team = ts.team

LEFT JOIN team_stats os
    ON m.opponent = os.team

WHERE is_home = 1;

SELECT * 
FROM ml_features;