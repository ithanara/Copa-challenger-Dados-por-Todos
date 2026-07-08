-- ============================================
-- 01. Matches_simple x Ranking 2022
-- ============================================
-- Média de gols por confederação (18 A 22)
SELECT
    r.association,
    COUNT(DISTINCT r.team) AS teams,
    SUM(ms.goals) AS goals,
    COUNT(*) AS matches,
    ROUND(AVG(ms.goals), 2) AS avg_goals
FROM matches_simple ms
JOIN ranking_2022 r
    ON ms.team = r.team
GROUP BY r.association
ORDER BY goals DESC;

-- Quem tomou mais gol
SELECT
    r.association,
    COUNT(DISTINCT r.team) AS teams,
    SUM(ms.goals_against) AS goals_taken,
    COUNT(*) AS matches,
    ROUND(AVG(ms.goals_against), 2) AS avg_goals_taken
FROM matches_simple ms
JOIN ranking_2022 r
    ON ms.team = r.team
GROUP BY r.association
ORDER BY goals_taken DESC;

-- Cartões por confederação
SELECT
    r.association,
    SUM(ms.yellow_cards) AS yellow_cards,
    SUM(ms.red_cards) AS red_cards,
    SUM(ms.yellow_cards + ms.red_cards) AS total
FROM matches_simple ms
JOIN ranking_2022 r
    ON ms.team = r.team
GROUP BY r.association;

-- Confederações com jogo mais agressivo
SELECT 
    r.association,
    ROUND(1.0 * SUM(yellow_cards + red_cards) / COUNT(*),2) AS cards_vs_matches,
    COUNT(*) AS matches

FROM matches_simple ms
JOIN ranking_2022 r
    ON ms.team = r.team
GROUP BY r.association;

-- Aproveitamento por confederação - quanto mais se joga, mais se ganha?
SELECT 
    r.association,
    SUM(CASE WHEN result='Win' THEN 1 END) AS wins,
    COUNT(*) AS matches
FROM matches_simple ms
JOIN ranking_2022 r
    ON ms.team = r.team
GROUP BY r.association
ORDER BY wins DESC;

-- xG por confederação - tem medo da conmebol
SELECT 
    r.association,
    AVG(xg) AS avg_xg,
    ROUND(SUM(goals)/SUM(xg),2) AS 'goals/xg'
FROM matches_simple ms
JOIN ranking_2022 r
    ON ms.team = r.team
GROUP BY r.association
ORDER BY avg_xg DESC;

-- Ranking x desempenho
SELECT
    r.association,
    ms.team,
    r.rank,
    COUNT(*) AS matches,
    ROUND(AVG(ms.goals), 2) AS avg_goals,
    CASE
        WHEN r.rank <= 10 THEN 'Top 10'
        WHEN r.rank <= 20 THEN 'Top 20'
        ELSE '30+'
    END AS ranking_group
FROM matches_simple ms
JOIN ranking_2022 r
    ON ms.team = r.team
GROUP BY
    r.association,
    ms.team,
    r.rank
ORDER BY
    r.rank;

-- Cartões por rank
SELECT
    r.rank,
    r.association,
    ms.team,
    SUM(ms.yellow_cards) AS yellow_cards,
    SUM(ms.red_cards) AS red_cards,
    SUM(ms.yellow_cards + ms.red_cards) AS total,
    COUNT(*) AS matches
FROM matches_simple ms
JOIN ranking_2022 r
    ON ms.team = r.team
GROUP BY r.association,
        ms.team
ORDER BY rank;