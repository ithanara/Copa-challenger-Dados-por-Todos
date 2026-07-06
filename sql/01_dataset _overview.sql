-- ============================================
-- 01. Ranking
-- ============================================
--Qual association tem mais pontos

SELECT association,
        SUM(points)
FROM ranking_2022
GROUP BY association
ORDER BY SUM(points) DESC;

--Quais times fizeram mais pontos em relação ao previous

--Quais associations fizeram mais pontos em relação ao previous

-- ============================================
-- 02. World_cup
-- ============================================




-- ============================================
-- 03. Matches
-- ============================================

-- Top scorers playing as home team
SELECT home_team,
       SUM(home_score)
FROM matches
GROUP BY home_team
ORDER BY SUM(home_score) DESC
LIMIT 10;

-- top scorers playng as away team
SELECT away_team,
       SUM(away_score)
FROM matches
GROUP BY away_team
ORDER BY SUM(away_score) DESC
LIMIT 10;

