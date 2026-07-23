#%%
import sqlite3
import pandas as pd
#%%
conn = sqlite3.connect("../data/database/copa_challenger.db")

conn.close()

#%%
conn = sqlite3.connect("../data/database/copa_challenger.db")

ranking_2022 = pd.read_csv("../data/raw/fifa_ranking_2022-10-06.csv")
matches = pd.read_csv("../data/raw/matches_1930_2022.csv")
world_cup = pd.read_csv("../data/raw/world_cup.csv")
ml_features_2026 = pd.read_csv("../data/validation/ml_features_2026.csv")

ranking_2022.to_sql(
    "ranking_2022",
    conn,
    if_exists="replace",
    index=False
)

matches.to_sql(
    "matches",
    conn,
    if_exists="replace",
    index=False
)

world_cup.to_sql(
    "world_cup",
    conn,
    if_exists="replace",
    index=False
)

ml_features_2026.to_sql(
    "ml_features_2026",
    conn,
    if_exists="replace",
    index=False
)

conn.close()

# %%
