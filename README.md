# FIFA World Cup Challenger
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![Python](https://img.shields.io/badge/Python-3.13-blue)
![SQL](https://img.shields.io/badge/SQL-SQLite-orange)
![Power BI](https://img.shields.io/badge/Power_BI-Dashboard-yellow)
![Machine Learning](https://img.shields.io/badge/Machine_Learning-Scikit--Learn-success)

## About

This is a data challenge hosted by Dados por Todos, you can learn more here:

https://www.kaggle.com/competitions/copa-challenger-dados-por-todos

The project combines **SQL**, **Python**, **Exploratory Data Analysis (EDA)**, **Power BI**, and **Machine Learning** to explore historical FIFA World Cup data and predict the disciplinary intensity (card level) of matches from the **2026 FIFA World Cup**.

## Missions

- ✅ Mission 1 — SQL & Database
- ✅ Mission 2 — Exploratory Data Analysis
- ✅ Mission 3 — Dashboard & Storytelling
- ✅ Mission 4 — Machine Learning

---

## Project Goals

- Explore historical FIFA World Cup data (2018 & 2022)
- Perform data quality assessment and exploratory analysis
- Build an interactive dashboard
- Engineer new predictive features
- Train Machine Learning models
- Predict the expected card intensity (Low / Medium / High) for FIFA World Cup 2026 matches

---

## Project Workflow

```
Data Collection
        │
        ▼
 SQLite Database
        │
        ▼
 Data Cleaning
        │
        ▼
 Exploratory Data Analysis
        │
        ▼
 Feature Engineering
        │
        ▼
 Power BI Dashboard
        │
        ▼
 Machine Learning
        │
        ▼
 2026 Match Predictions
```

---

## Technologies

- Python
- Pandas
- NumPy
- SQL (SQLite)
- Scikit-Learn
- Matplotlib
- Plotly
- Power BI

---

## Machine Learning

Two different approaches were evaluated during the project:

- **Random Forest Regressor** to predict the exact number of cards per match.
- **Random Forest Classifier** to classify matches into:
  - 🟢 Low
  - 🟡 Medium
  - 🔴 High

The classification approach produced more consistent results and was selected as the final solution. However, the model's predictive performance is still limited by the relatively small amount of historical World Cup data available for training.

---

## Dashboard

The Power BI dashboard summarizes the exploratory analysis through interactive visualizations, including:

- Team performance
- FIFA rankings
- Confederation analysis
- Goals
- Yellow and red cards
- Knockout stage statistics
- Penalty shootouts

---


## Repository Highlights

- SQL database modeling
- Feature engineering
- Reproducible Machine Learning pipeline
- Data visualization
- Power BI dashboard
- Kaggle Notebook
- Complete project documentation

## Results

- 📊 SQL database integrating multiple FIFA datasets
- 📈 Interactive Power BI dashboard
- 🤖 Random Forest classification model
- 🎯 Predictions generated for FIFA World Cup 2026 matches
- 📓 Public Kaggle Notebook documenting the complete workflow