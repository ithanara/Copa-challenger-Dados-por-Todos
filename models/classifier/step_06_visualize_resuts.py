#%%
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix
from sklearn.metrics import ConfusionMatrixDisplay
#%%
#feature importance
class_feature_importance = pd.read_csv("feature_importance.csv")

top10 = (
    class_feature_importance
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
# %%
class_predictions = pd.read_csv("predictions.csv")
class_predictions.head(10)

#%%
#confusion matrix
cm = confusion_matrix(
    class_predictions["real"],
    class_predictions["previsto"],
    labels=["Low", "Medium", "High"]
)

plt.figure(figsize=(6,5))

plt.imshow(cm, cmap="Blues")

plt.colorbar()

classes = ["Low", "Medium", "High"]

plt.xticks(
    range(len(classes)),
    classes
)

plt.yticks(
    range(len(classes)),
    classes
)

plt.xlabel("Nível de cartões previsto")
plt.ylabel("Nível de cartões real")
plt.title("Matriz de confusão")

# Escrever os números dentro das células
for i in range(cm.shape[0]):
    for j in range(cm.shape[1]):
        plt.text(
            j,
            i,
            cm[i, j],
            ha="center",
            va="center",
            color="white" if cm[i, j] > cm.max()/2 else "black"
        )

plt.tight_layout()
plt.show()
# %%
# matrix de confusão normalizada

cm_normalized = confusion_matrix(
    class_predictions["real"],
    class_predictions["previsto"],
    labels=["Low", "Medium", "High"],
    normalize="true"
)

plt.figure(figsize=(6,5))

plt.imshow(cm_normalized, cmap="Blues")

plt.colorbar()

classes = ["Low", "Medium", "High"]

plt.xticks(
    range(len(classes)),
    classes
)

plt.yticks(
    range(len(classes)),
    classes
)

plt.xlabel("Nível de cartões previsto")
plt.ylabel("Nível de cartões real")
plt.title("Matriz de confusão normalizada")

# Escrever os números dentro das células
for i in range(cm_normalized.shape[0]):
    for j in range(cm_normalized.shape[1]):
        plt.text(
            j,
            i,
            f"{cm_normalized[i, j]:.2%}",
            ha="center",
            va="center",
            color="white" if cm_normalized[i, j] > 0.5 else "black"

        )

plt.tight_layout()
plt.show()
# %%
# previsões por classe
real_counts = (
    class_predictions["real"]
    .value_counts()
    .reindex(["Low", "Medium", "High"])
)

pred_counts = (
    class_predictions["previsto"]
    .value_counts()
    .reindex(["Low", "Medium", "High"])
)

x = range(3)
width = 0.35

plt.figure(figsize=(7,4))

plt.bar(
    [i - width/2 for i in x],
    real_counts.values,
    width=width,
    label="Real"
)

plt.bar(
    [i + width/2 for i in x],
    pred_counts.values,
    width=width,
    label="Previsto"
)

plt.xticks(x, ["Low", "Medium", "High"])

plt.xlabel("Nível de cartões")
plt.ylabel("Partidas")
plt.title("Nível de cartões reais e previstos")

plt.legend()

plt.tight_layout()
plt.show()
# %%
# acertos x erros
class_predictions["acertou"] = (
    class_predictions["real"] ==
    class_predictions["previsto"]
)

counts = (
    class_predictions["acertou"]
    .value_counts()
    .rename(index={
        True: "Acertos",
        False: "Erros"
    })
)

plt.figure(figsize=(5,6))

plt.bar(
    counts.index,
    counts.values
)

plt.title("Acertos x Erros")
plt.ylabel("Quantidade de partidas")

# Escrever o valor acima de cada barra
total = counts.sum()
for i, value in enumerate(counts.values):
    plt.text(
        i,
        value + 1,
        f"{value}\n({value/total:.1%})",
        ha="center"
    )

ax = plt.gca()

ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

plt.tight_layout()
plt.show()
# %%
