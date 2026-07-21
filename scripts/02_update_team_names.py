#%%
import sqlite3
import pandas as pd
import sys
from pathlib import Path

project_root = Path().resolve().parent
sys.path.append(str(project_root))

from scripts.team_mapping import TEAM_NAME_MAPPING

#%%
conn = sqlite3.connect("../data/database/copa_challenger.db")

matches = pd.read_sql(
    "SELECT * FROM matches",
    conn
)

matches["home_team"] = matches["home_team"].replace(TEAM_NAME_MAPPING)
matches["away_team"] = matches["away_team"].replace(TEAM_NAME_MAPPING)

matches.to_sql(
    "matches",
    conn,
    if_exists="replace",
    index=False
)

conn.close()
# %%
