-- ============================================
-- 01. Ranking
-- ============================================
-- Minimo, máximo e média de pontos
SELECT
    MIN(points) AS min_points,
    MAX(points) AS max_points,
    ROUND(AVG(points),2) AS avg_points
FROM ranking_2022;

-- Top 10
SELECT
    team,
    rank,
    points
FROM ranking_2022
ORDER BY rank
LIMIT 10;

-- Bottom 10
SELECT
    team,
    rank,
    points
FROM ranking_2022
ORDER BY rank DESC
LIMIT 10;

-- Ranking: Maiores evoluções
SELECT
    team,
    previous_rank,
    rank,
    previous_rank - rank AS positions_gained
FROM ranking_2022
WHERE positions_gained > 0
ORDER BY positions_gained DESC;

-- Ranking: Maiores prejuízos
SELECT
    team,
    previous_rank,
    rank,
    rank - previous_rank AS positions_lost
FROM ranking_2022
WHERE positions_lost > 0
ORDER BY positions_lost DESC;

-- Ranking: Visão unificada de quem subiu e quem desceu
SELECT
    team,
    previous_rank,
    rank,
    previous_rank - rank AS rank_change
FROM ranking_2022
ORDER BY rank_change DESC;

-- Pontos: quem ganhou mais e quem perdeu mais
SELECT
    team,
    previous_points,
    points,
    ROUND(points - previous_points,2) AS points_change
FROM ranking_2022
ORDER BY points_change DESC;

-- Quantidade de time por association
SELECT
    association,
    COUNT(*) AS teams
FROM ranking_2022
GROUP BY association
ORDER BY teams DESC;

-- Ranking médio das associations
SELECT
    association,
    ROUND(AVG(rank),2) AS avg_rank
FROM ranking_2022
GROUP BY association
ORDER BY avg_rank;

-- Pontuação por association
SELECT association,
        ROUND(AVG(points),2) AS avg_points
FROM ranking_2022
GROUP BY association
ORDER BY avg_points DESC;

-- Melhor de cada association
SELECT
    association,
    MIN(rank) AS best_rank
FROM ranking_2022
GROUP BY association;


-- Top 10 com association
SELECT
    association,
    team,
    rank,
    points
FROM ranking_2022
WHERE rank <= 10
ORDER BY rank;

--  As 3 melhores de cada association
SELECT
    association,
    team,
    rank,
    points
FROM (
    SELECT
        association,
        team,
        rank,
        points,
        ROW_NUMBER() OVER (
            PARTITION BY association
            ORDER BY rank
        ) AS position
    FROM ranking_2022
)
WHERE position <= 3
ORDER BY association, rank;

-- ============================================
-- 02. World_cup
-- ============================================
-- Geral
SELECT
    ROUND(AVG(Teams),2) AS avg_teams,
    ROUND(AVG(Matches),2) AS avg_matches,
    ROUND(AVG(AttendanceAvg),2) AS avg_attendance,
    MAX(Attendance) AS highest_attendance,
    MIN(Attendance) AS lowest_attendance
FROM world_cup;

-- Países com mais titulos
SELECT
    Champion,
    COUNT(*) AS titles
FROM world_cup
GROUP BY Champion
ORDER BY titles DESC;

-- Maiores vices (runner up)
SELECT
    "Runner-Up",
    COUNT(*) AS runner_up
FROM world_cup
GROUP BY "Runner-Up"
ORDER BY runner_up DESC;

-- Maiores hosts
SELECT
    Host,
    COUNT(*) AS editions
FROM world_cup
GROUP BY Host
ORDER BY editions DESC;

-- Campeões em casa
SELECT
    Year,
    Host,
    Champion
FROM world_cup
WHERE Host = Champion;

-- Qtd seleções ao longo dos anos
SELECT
    Year,
    Teams
FROM world_cup
ORDER BY Year;

-- Qtd de partidas ao longo dos anos
SELECT
    Year,
    Matches
FROM world_cup
ORDER BY Year;

-- Publico ao longo dos anos
SELECT
    Year,
    Attendance
FROM world_cup
ORDER BY Year;

-- Artilheiros
SELECT
    TopScorrer,
    COUNT(*) AS golden_boots
FROM world_cup
GROUP BY TopScorrer
ORDER BY golden_boots DESC;

-- Evolução da copa do mundo ao longo dos anos
SELECT
    Year,
    Teams,
    Matches,
    Attendance
FROM world_cup
ORDER BY Year;

-- ============================================
-- 03. Matches
-- ============================================
-- De todos os anos
-- Top scorers como mandante
SELECT home_team,
       SUM(home_score) AS gols
FROM matches
GROUP BY home_team
ORDER BY SUM(home_score) DESC
LIMIT 10;

-- Top scorers como visitante
SELECT away_team,
       SUM(away_score) AS gols
FROM matches
GROUP BY away_team
ORDER BY SUM(away_score) DESC
LIMIT 10;

-- 2018 a 2022
-- Top scorers playing as mandante
SELECT home_team,
       SUM(home_score) AS 'gols 18 a 22'
FROM matches
WHERE Year >= 2018
GROUP BY home_team
ORDER BY SUM(home_score) DESC
LIMIT 10;

-- Top scorers como visitante
SELECT away_team,
       SUM(away_score) AS 'gols 18 a 22'
FROM matches
WHERE Year >= 2018
GROUP BY away_team
ORDER BY SUM(away_score) DESC
LIMIT 10;

-- Quais paises mais participaram
SELECT home_team,
        away_team,
        COUNT (DISTINCT (home_team)),
       COUNT  (DISTINCT(away_team))
FROM matches;

-- ============================================
-- 03. Matches_simple
-- ============================================
-- Comparação média de gols por visita e mandante
SELECT
    is_home,
    AVG(goals) AS avg_goals
FROM matches_simple
GROUP BY is_home;

-- Cartão x resultado
SELECT
    result,
    AVG(yellow_cards) AS avg_yellow_cards,
    AVG(yellow_red_cards) AS avg_yellow_cards,
    AVG(red_cards) AS avg_red_cards
FROM matches_simple
GROUP BY result;

SELECT
    result,
    SUM(yellow_cards) AS total_yellow_cards,
    SUM(yellow_red_cards) AS total_yellow_cards,
    SUM(red_cards) AS total_red_cards
FROM matches_simple
GROUP BY result;

-- Gols x cartão
SELECT
    yellow_cards,
    AVG(goal_difference) AS avg_goal_difference
FROM matches_simple
GROUP BY yellow_cards
ORDER BY yellow_cards;

SELECT
    yellow_red_cards,
    AVG(goal_difference) AS avg_goal_difference
FROM matches_simple
GROUP BY yellow_red_cards
ORDER BY yellow_red_cards;

SELECT
    red_cards,
    AVG(goal_difference) AS avg_goal_difference
FROM matches_simple
GROUP BY red_cards
ORDER BY red_cards;

--Resultado quando o mandante tem mais cartões do que o oponente
SELECT
    result,
    COUNT(*) AS matches
FROM matches_simple
WHERE yellow_cards > opponent_yellow_cards
GROUP BY result;

-- Chegando a conclusão de que em geral tomar cartão não ajuda a vencer

SELECT
    yellow_cards,
    COUNT(*) AS matches,
    AVG(goal_difference) AS avg_goal_difference
FROM matches_simple
GROUP BY yellow_cards
ORDER BY yellow_cards;

-- Cartão por seleção
SELECT
    team,
    SUM(yellow_cards) AS yellow_cards,
    SUM(red_cards) AS red_cards,
    SUM(yellow_cards) + SUM(red_cards) AS total_cards
FROM matches_simple
GROUP BY team
ORDER BY total_cards DESC;
-- Em geral tem poucos cartões vermelhos

-- Maiores aproveitamentos
SELECT
    team,
    COUNT(*) AS matches,
    SUM(CASE WHEN result = 'Win' THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN result = 'Draw' THEN 1 ELSE 0 END) AS draws,
    SUM(CASE WHEN result = 'Loss' THEN 1 ELSE 0 END) AS losses,
    ROUND(
        100.0 * SUM(CASE WHEN result = 'Win' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS win_rate
FROM matches_simple
GROUP BY team
ORDER BY win_rate DESC;

