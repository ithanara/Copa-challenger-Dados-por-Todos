import sqlite3
import pandas as pd
from pathlib import Path

def classify_cards(cards):

    if cards <= 2:
        return "Low"

    elif cards <= 5:
        return "Medium"

    return "High"

BASE_DIR = Path(__file__).resolve().parent.parent.parent

def prepare_classification_data():

    conn = sqlite3.connect(
    BASE_DIR / "data/database/copa_challenger.db"
)

    train = pd.read_sql(
        "SELECT * FROM ml_features",
        conn
    )

    validation = pd.read_sql(
        "SELECT * FROM ml_features_2026_final",
        conn
    )

    conn.close()

    train["cards_class"] = train["match_total_cards"].apply(classify_cards)

    validation["cards_class"] = validation["match_total_cards"].apply(classify_cards)

    train = train.rename(columns={
        "Year": "year",
        "Round": "round"
    })

    TARGET = "cards_class"

    DROP_COLUMNS = [
    TARGET,
    "match_id",
    "yellow_cards",
    "yellow_red_cards",
    "red_cards",
    "opponent_yellow_cards",
    "opponent_yellow_red_cards",
    "opponent_red_cards",
    "match_total_cards"
]

    X_train = train.drop(columns=DROP_COLUMNS)
    y_train = train[TARGET]

    X_validation = validation.drop(columns=DROP_COLUMNS)
    y_validation = validation[TARGET]


    categorical_features = (
        X_train.select_dtypes(include="object")
        .columns
        .tolist()
    )

    numerical_features = (
        X_train.select_dtypes(exclude="object")
        .columns
        .tolist()
    )


    return (
        X_train,
        y_train,
        X_validation,
        y_validation,
        categorical_features,
        numerical_features
    )


if __name__ == "__main__":

    (
        X_train,
        y_train,
        X_validation,
        y_validation,
        categorical_features,
        numerical_features
    ) = prepare_classification_data()

    print(X_train.shape)
    print(X_validation.shape)
    print(categorical_features)
    print(y_train.value_counts(normalize=True))
    print(X_train.head())