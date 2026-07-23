#%%
import sqlite3
import pandas as pd

#%%
conn = sqlite3.connect("../data/database/copa_challenger.db")

train = pd.read_sql(
    "SELECT * FROM ml_features",
    conn
)

validation = pd.read_sql(
    "SELECT * FROM ml_features_2026_final",
    conn
)
print("Conectou!")
conn.close()
#%%
train = train.rename(columns={
    "Year": "year",
    "Round": "round"
})
# %%
# validar dados
print(train.shape)
print(validation.shape)

print(train.columns.tolist())
print(validation.columns.tolist())

train.dtypes

# última confirmação
train.describe()

# %%
#Separar X e y