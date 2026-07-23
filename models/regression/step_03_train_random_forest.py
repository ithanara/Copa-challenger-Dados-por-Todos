#%%
import pandas as pd
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder, StandardScaler
from sklearn.pipeline import Pipeline
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error, root_mean_squared_error, r2_score
import joblib
import json
import sys
from pathlib import Path
#%%
ROOT_DIR = Path(__file__).resolve().parent.parent

sys.path.append(str(ROOT_DIR))
#%%
# importar os dados preparados
from step_02_prepare_ml_data import prepare_data
(
    X_train,
    y_train,
    X_validation,
    y_validation,
    categorical_features,
    numerical_features
) = prepare_data()
#%%
# criar o preprocessador
preprocessor = ColumnTransformer(
    transformers=[
        (
            "num",
            StandardScaler(),
            numerical_features
        ),
        (
            "cat",
            OneHotEncoder(handle_unknown="ignore"),
            categorical_features
        )
    ]
)
#%%
# criar o pipeline
model = Pipeline(
    steps=[
        (
            "preprocessor",
            preprocessor
        ),
        (
            "random_forest",
            RandomForestRegressor(
                n_estimators=200,
                random_state=42
            )
        )
    ]
)
#%%
# treinar
model.fit(
    X_train,
    y_train
)
#%%
# avaliar a importância das features
feature_importance = pd.DataFrame({
    "feature": model.named_steps["preprocessor"].get_feature_names_out(),
    "importance": model.named_steps["random_forest"].feature_importances_
})

feature_importance.sort_values(
    "importance",
    ascending=False
).head(15)
#%%
# prever
y_pred = model.predict(
    X_validation
)
print(y_pred[:10])
#%%
# avaliar
mae = mean_absolute_error(
    y_validation,
    y_pred
)

rmse = root_mean_squared_error(
    y_validation,
    y_pred
)

r2 = r2_score(
    y_validation,
    y_pred
)

print(f"MAE: {mae:.2f}")
print(f"RMSE: {rmse:.2f}")
print(f"R²: {r2:.2f}")

#%%
# comparar os valores reais e previstos
print(X_train.columns.tolist())
comparison = pd.DataFrame({
    "real": y_validation,
    "previsto": y_pred
})

comparison.head(10)

#%%
y_train.describe()
y_train.value_counts().sort_index()


# %%
# salvar o modelo
joblib.dump(
    model,
    "random_forest_cards_regression.pkl"
)

# salvar resultados
metrics = {
    "model": "RandomForestRegressor",
    "target": "match_total_cards",
    "MAE": mae,
    "RMSE": rmse,
    "R2": r2
}

with open(
    "metrics.json",
    "w"
) as f:
    json.dump(metrics, f, indent=4)

# salvar feature importance
feature_importance.sort_values(
    "importance",
    ascending=False
).to_csv(
    "feature_importance.csv",
    index=False
)
# salvar comparação
comparison.to_csv(
    "predictions.csv",
    index=False
)