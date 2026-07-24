#%%
from pathlib import Path
import joblib
import pandas as pd

#%%

BASE_DIR = Path(__file__).resolve().parent.parent.parent

MODEL_DIR = BASE_DIR / "models" / "classifier"

MODEL_PATH = MODEL_DIR / "random_forest_cards_classifier.pkl"


pipeline = joblib.load(MODEL_PATH)

print("Modelo carregado!")
# %%
from step_03_prepare_classification_data import prepare_classification_data

(
    X_train,
    y_train,
    X_validation,
    y_validation,
    categorical_features,
    numerical_features,
) = prepare_classification_data()

print(X_validation.head())
print(X_validation.shape)
# %%
probabilities = pipeline.predict_proba(X_validation)


proba_df = pd.DataFrame(
    probabilities,
    columns=pipeline.classes_
)

predictions = pipeline.predict(X_validation)

results = X_validation.copy()

results["prediction"] = predictions

results = pd.concat(
    [
        results,
        proba_df
    ],
    axis=1
)

results.head()
# %%
# adicionar nivel de confiança
results["confidence"] = proba_df.max(axis=1)

# deixar em %
results["confidence"] = (
    results["confidence"] * 100
).round(1)
# %%
# acrescentar o resultado real
results["actual"] = y_validation.values

results = X_validation.copy()

results["actual"] = y_validation.values
results["prediction"] = predictions

results = pd.concat(
    [
        results,
        proba_df
    ],
    axis=1
)

results["confidence"] = proba_df.max(axis=1)

results["correct"] = (
    results["actual"] == results["prediction"]
)

results["confidence"] = (
    results["confidence"] * 100
).round(1)

for col in ["High", "Low", "Medium"]:
    results[col] = (
        results[col] * 100
    ).round(1)

results.head()
#%%
results.groupby("correct")["confidence"].mean()
results["confidence"].describe()
#%%
# comparar partidas que ele estava confiante x resultado
results.sort_values(
    "confidence",
    ascending=False
)[
    [
        "team",
        "opponent",
        "actual",
        "prediction",
        "confidence"
    ]
].head(10)
# %%
# Salvar
results.to_csv(
    MODEL_DIR / "classifier_predictions_proba.csv",
    index=False
)
# %%
