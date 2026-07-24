#%%
from pathlib import Path
import json
import joblib

import pandas as pd

from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import OneHotEncoder

from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split

from sklearn.metrics import (
    accuracy_score,
    classification_report,
    confusion_matrix,
)
#%%
# configurações
RANDOM_STATE = 42

BASE_DIR = Path(__file__).resolve().parent.parent.parent

MODEL_DIR = BASE_DIR / "models" / "classifier"
MODEL_DIR.mkdir(parents=True, exist_ok=True)
#%%
# carregar
from step_03_prepare_classification_data import prepare_classification_data

(
    X_train,
    y_train,
    X_validation,
    y_validation,
    categorical_features,
    numerical_features,
) = prepare_classification_data()
#%%
# preprocessador
preprocessor = ColumnTransformer(
    transformers=[
        (
            "cat",
            OneHotEncoder(handle_unknown="ignore"),
            categorical_features,
        ),
        (
            "num",
            "passthrough",
            numerical_features,
        ),
    ]
)
#%%
# pipeline
pipeline = Pipeline(
    steps=[
        ("preprocessor", preprocessor),
        (
            "classifier",
            RandomForestClassifier(
                n_estimators=300,
                random_state=42,
            ),
        ),
    ]
)
#%%
# treinar
pipeline.fit(X_train, y_train)
#%%
# feature importance
classifier = pipeline.named_steps["classifier"]

feature_importance = pd.DataFrame({
    "feature": pipeline.named_steps[
        "preprocessor"
    ].get_feature_names_out(),
    "importance": classifier.feature_importances_,
})

feature_importance
#%%
# predict
y_pred = pipeline.predict(X_validation)
print(y_pred[:10])

#%%
# avaliar
accuracy = accuracy_score(
    y_validation,
    y_pred
)

print(f"Accuracy: {accuracy:.2f}")

print(
    classification_report(
        y_validation,
        y_pred
    )
)

cm = confusion_matrix(
    y_validation,
    y_pred
)

print("Matriz de confusão:")
print(cm)
#%%
# comparar
comparison = pd.DataFrame({
    "real": y_validation,
    "previsto": y_pred
})

comparison["acertou"] = (
    comparison["real"] == comparison["previsto"]
)

comparison.head(10)
#%%
# score
total = len(comparison)
hits = comparison["acertou"].sum()
errors = total - hits

print(f"Total de partidas: {total}")
print(f"Acertos: {hits}")
print(f"Erros: {errors}")
print(f"Taxa de acerto: {hits/total:.2%}")
# %%
# salvar modelo
joblib.dump(
    pipeline,
    MODEL_DIR / "random_forest_cards_classifier.pkl"
)

# métricas
metrics = {
    "model": "RandomForestClassifier",
    "target": "cards_class",
    "accuracy": accuracy,
}

with open(
    MODEL_DIR / "metrics.json",
    "w"
) as f:
    json.dump(metrics, f, indent=4)

# feature importance
feature_importance.sort_values(
    "importance",
    ascending=False
).to_csv(
    MODEL_DIR / "feature_importance.csv",
    index=False
)

# comparação
comparison.to_csv(
    MODEL_DIR / "predictions.csv",
    index=False
)

# %%
