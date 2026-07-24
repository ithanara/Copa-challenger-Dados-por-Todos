#%%
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.metrics import (
    mean_absolute_error,
    root_mean_squared_error,
    r2_score
)
# MAE RMSE R2

#%%
# Feature importance
reg_feature_importance = pd.read_csv("feature_importance.csv")

top10 = (
    reg_feature_importance
    .sort_values("importance", ascending=False)
    .head(10)
    .sort_values("importance")
)

plt.figure(figsize=(10, 6))

plt.barh(
    top10["feature"],
    top10["importance"]
)

plt.xlabel("importância")
plt.title("10 features mais importantes")

plt.tight_layout()
plt.show()

#%%
# Real x previsto - Linha
reg_predictions = pd.read_csv("predictions.csv")

plt.figure(figsize=(12,5))

plt.plot(
    reg_predictions["real"].values,
    label="Real",
    linewidth=2
)

plt.plot(
    reg_predictions["previsto"].values,
    label="Previsto",
    linewidth=2
)

plt.xlabel("Partidas")
plt.ylabel("Total de cartões")
plt.title("Real vs Predito")

plt.legend()

plt.show()

# %%
# Real x previsto - Scatter
# Modelo perfeito = todos os pontos exatamente sobre a reta y = x

plt.figure(figsize=(7, 7))

plt.scatter(
    reg_predictions["real"],
    reg_predictions["previsto"],
    alpha=0.7
)

# Linha ideal
min_value = min(
    reg_predictions["real"].min(),
    reg_predictions["previsto"].min()
)

max_value = max(
    reg_predictions["real"].max(),
    reg_predictions["previsto"].max()
)

plt.plot(
    [min_value, max_value],
    [min_value, max_value],
    "r--",
    label="Predição perfeita"
)

plt.xlabel("Valor Real")
plt.ylabel("Valor Previsto")
plt.title("Random Forest Regressor - Real vs Previsto")

plt.legend()

plt.show()
#%%
reg_predictions.head()
#%%
# histograma distribuição de erro
reg_predictions["erro"] = (
    reg_predictions["previsto"] - reg_predictions["real"]
)

plt.figure(figsize=(8, 5))

plt.hist(
    reg_predictions["erro"],
    bins=10,
    edgecolor="black"
)

plt.axvline(
    0,
    color="red",
    linestyle="--",
    label="Erro = 0"
)

plt.xlabel("Erro")
plt.ylabel("Quantidade de partidas")
plt.title("Distribuição dos erros")

plt.legend()

plt.show()
#%%
# resíduos (erro x valor previsto)
plt.figure(figsize=(8,5))

plt.scatter(
    reg_predictions["previsto"],
    reg_predictions["erro"],
    alpha=0.7
)

plt.axhline(
    0,
    color="red",
    linestyle="--",
    linewidth=2
)

plt.xlabel("Valor previsto")
plt.ylabel("Erro")
plt.title("Resíduos (Erro × Valor previsto)")

plt.show()
#%%
# mesma análise com numeros inteiros (pq cartões sempre vai ser int)
#%%
# deixar tudo inteiro

reg_predictions_int = reg_predictions.copy()

reg_predictions_int["previsto"] = (
    reg_predictions_int["previsto"]
    .round()
    .astype(int)
)

reg_predictions_int["erro"] = (
    reg_predictions_int["previsto"] -
    reg_predictions_int["real"]
)

# %%
# MAE RMSE R2

mae_int = mean_absolute_error(
    reg_predictions_int["real"],
    reg_predictions_int["previsto"]
)

rmse_int = root_mean_squared_error(
    reg_predictions_int["real"],
    reg_predictions_int["previsto"]
)

r2_int = r2_score(
    reg_predictions_int["real"],
    reg_predictions_int["previsto"]
)

print(f"MAE: {mae_int:.2f}")
print(f"RMSE: {rmse_int:.2f}")
print(f"R²: {r2_int:.2f}")
# %%
# resumo da taxa de acertos
reg_predictions_int["acertou"] = (
    reg_predictions_int["real"] ==
    reg_predictions_int["previsto"]
)

hits = reg_predictions_int["acertou"].sum()

total = len(reg_predictions_int)

print(f"Acertos: {hits}")
print(f"Erros: {total-hits}")
print(f"Taxa de acerto: {hits/total:.2%}")
# %%
# Real x previsto - Scatter
# Modelo perfeito = todos os pontos exatamente sobre a reta y = x

plt.figure(figsize=(7, 7))

plt.scatter(
    reg_predictions_int["real"],
    reg_predictions_int["previsto"],
    alpha=0.7
)

# Linha ideal
min_value = min(
    reg_predictions_int["real"].min(),
    reg_predictions_int["previsto"].min()
)

max_value = max(
    reg_predictions_int["real"].max(),
    reg_predictions_int["previsto"].max()
)

plt.plot(
    [min_value, max_value],
    [min_value, max_value],
    "r--",
    label="Predição perfeita"
)

plt.xlabel("Valor Real")
plt.ylabel("Valor Previsto")
plt.title("Random Forest Regressor - Real vs Previsto")

plt.legend()

plt.show()
#%%
reg_predictions_int.head()
#%%
# histograma distribuição de erro
reg_predictions_int["erro"] = (
    reg_predictions_int["previsto"] - reg_predictions_int["real"]
)

plt.figure(figsize=(8, 5))

plt.hist(
    reg_predictions_int["erro"],
    bins=10,
    edgecolor="black"
)

plt.axvline(
    0,
    color="red",
    linestyle="--",
    label="Erro = 0"
)

plt.xlabel("Erro")
plt.ylabel("Quantidade de partidas")
plt.title("Distribuição dos erros")

plt.legend()

plt.show()

print(f"Acertos exatos: {(reg_predictions_int['erro'] == 0).sum()}")

#%%
# resíduos (erro x valor previsto)
plt.figure(figsize=(8,5))

plt.scatter(
    reg_predictions_int["previsto"],
    reg_predictions_int["erro"],
    alpha=0.7
)

plt.axhline(
    0,
    color="red",
    linestyle="--",
    linewidth=2
)

plt.xlabel("Valor previsto")
plt.ylabel("Erro")
plt.title("Resíduos (Erro × Valor previsto)")

plt.show()