-- ============================================
-- 01. estrutura
-- ============================================
SELECT *
FROM sqlite_master;

-- ============================================
-- 02. tipos
-- ============================================
PRAGMA table_info(ranking_2022);
PRAGMA table_info(world_cup);
PRAGMA table_info(matches);
PRAGMA table_info(matches_simple);
PRAGMA table_info(matches_shootout);

-- ============================================
-- 03. contagens
-- ============================================
--Qtd linhas
SELECT COUNT(*) AS qtd_linhas_ranking_2022 FROM ranking_2022;
SELECT COUNT(*) AS qtd_linhas_world_cup FROM world_cup;
SELECT COUNT(*) AS qtd_linhas_matches FROM matches;

--Verificando se há campos importantes vazios
SELECT 
  COUNT(*) - COUNT(team) AS null_count,
  (COUNT(*) - COUNT(team)) * 100.0 / COUNT(*) AS null_percentage
FROM ranking_2022;

SELECT 
  COUNT(*) - COUNT(Date) AS null_count,
  (COUNT(*) - COUNT(Date)) * 100.0 / COUNT(*) AS null_percentage
FROM matches;

SELECT 
  COUNT(*) - COUNT(Year) AS null_count,
  (COUNT(*) - COUNT(Year)) * 100.0 / COUNT(*) AS null_percentage
FROM matches;

SELECT 
  COUNT(*) - COUNT(Year) AS null_count,
  (COUNT(*) - COUNT(Year)) * 100.0 / COUNT(*) AS null_percentage
FROM world_cup;