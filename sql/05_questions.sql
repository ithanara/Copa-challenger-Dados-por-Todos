-- ============================================
-- 01. A quantidade de cartões influencia os resultados?
-- ============================================
SELECT     
    result,
    SUM(yellow_cards) AS yellow_cards,
    SUM(red_cards) AS red_cards,
    SUM(yellow_cards + red_cards) AS total
FROM matches_simple
GROUP BY result
ORDER BY total DESC;

-- ============================================
-- 02. Quais confederações tem mais cartão?
-- ============================================
SELECT
    r.association,
    SUM(ms.yellow_cards) AS yellow_cards,
    SUM(ms.red_cards) AS red_cards,
    SUM(ms.yellow_cards + ms.red_cards) AS total
FROM matches_simple ms
JOIN ranking_2022 r
    ON ms.team = r.team
GROUP BY r.association
ORDER BY total DESC;

-- ============================================
-- 03. O momento do campeonato tem relação com os cartões?
-- ============================================
SELECT     
    Round,
    SUM(yellow_cards) AS yellow_cards,
    SUM(red_cards) AS red_cards,
    SUM(yellow_cards + red_cards) AS total
FROM matches_simple
GROUP BY Round
ORDER BY total DESC;

-- ============================================
-- 04. Qual era o ranking FIFA do campeão e do vice na Copa de 2022?
-- O campeão da Copa 22 estava entre os 5 primeiros?
-- ============================================
-- Primeiro do champion
SELECT 
    wc.Year,
    wc.Champion,
    r.rank,
    r.points
FROM world_cup wc
JOIN ranking_2022 r
    ON wc.champion = r.team
ORDER BY year DESC;

-- Vice
SELECT 
    wc.Year,
    wc."Runner-Up",
    r.rank,
    r.points
FROM world_cup wc
JOIN ranking_2022 r
    ON wc."Runner-Up" = r.team
ORDER BY year DESC;

-- ============================================
-- 05. A quantidade de cartões influencia no resultado de penalty dos acréscimos?
-- ============================================
SELECT   
    ps.penalty_goal,
    ps. opponent_penalty_goal,
    SUM(ms.yellow_cards) AS yellow_cards,
    SUM(ms.red_cards) AS red_cards,
    SUM(ms.yellow_cards + red_cards) AS total_cards,

    CASE
           WHEN penalty_goal > opponent_penalty_goal THEN 'Win'
           ELSE 'Loss'
    END AS shootout_result   
FROM matches_simple ms
JOIN matches_shootout ps
    ON ms.Year = ps.Year
   AND ms.team = ps.team
   AND ms.opponent = ps.opponent
   AND ms.is_home = ps.is_home
   AND ms.Round = ps.Round
GROUP BY shootout_result;