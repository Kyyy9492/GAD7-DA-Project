# GAD7-DA-Project

## Project Overview

This project explores anxiety severity based on GAD-7 survey data.  
The main goal is to understand how demographic and socioeconomic factors are related to anxiety level, and to use different data analysis methods to find meaningful patterns in the dataset.

The project includes:

- data cleaning
- demographic descriptive analysis
- bivariate analysis
- sensitivity analysis
- regression modeling
- clustering analysis

---

## Research Goal

The main research question of this project is:

**How are demographic and socioeconomic characteristics associated with GAD-7 anxiety severity?**

This project focuses on several factors, including:

- age
- gender
- marriage
- education
- income
- occupation

The analysis also examines how these characteristics are related to total GAD-7 score and anxiety severity categories.

---

## Dataset

The dataset is based on GAD-7 questionnaire responses.  
It contains:

- personal demographic information
- socioeconomic information
- GAD-7 item responses
- total anxiety score

The total GAD-7 score is used as the main outcome variable in later analysis.

---

## Project Structure

### 01_data_cleaning.sql
This file cleans and prepares the raw dataset in MySQL.  
Main work includes:

- creating the database and table
- importing survey data
- checking missing values
- handling variable formats
- preparing the dataset for analysis

### 02_demographics.sql
This file provides descriptive statistics for demographic variables.  
It includes:

- sample size
- gender distribution
- age distribution
- marriage distribution
- education distribution
- income distribution
- occupation distribution
- summary statistics for GAD-7 score

### 03_bivariate_analysis.sql
This file explores bivariate relationships between demographic variables and anxiety score using SQL summary tables.  
Main focus:

- comparing score across groups
- checking mean, median, min, max, and standard deviation
- identifying possible differences between demographic groups

### 04_bivariate_analysis_contiued.ipynb
This notebook continues the bivariate analysis in Python.  
It includes more formal statistical testing, such as:

- Mann-Whitney U test
- Kruskal-Wallis test
- continuous age vs. score analysis
- interpretation of group differences

### 05_sensitivity_analysis.ipynb
This notebook examines whether changing variable grouping methods affects the results.  
Main idea:

- test different category definitions
- check whether conclusions remain stable
- evaluate robustness of findings

Examples include:

- different age grouping strategies
- ordered trend analysis
- grouped demographic comparisons

### 06_regression_model.ipynb
This notebook builds regression models to study the relationship between demographic factors and anxiety score.

Main work includes:

- selecting candidate variables
- building regression models
- interpreting coefficients
- comparing model results
- identifying important predictors of anxiety severity

### 07_cluster_analysis.ipynb
This notebook performs clustering analysis to identify demographic subgroups in the sample.

Main process:

- test different encoding strategies
- compare clustering quality using silhouette score
- choose the final clustering model
- profile each cluster by demographic characteristics
- connect final clusters with GAD-7 score and severity level

The final clustering analysis shows that different demographic clusters have significantly different anxiety burdens.

---

## Main Analysis Flow

The project follows this general order:

1. Clean and prepare the dataset
2. Describe the sample characteristics
3. Explore demographic differences in anxiety score
4. Test robustness with sensitivity analysis
5. Build regression models
6. Use clustering to identify subgroup patterns
7. Compare anxiety severity across final clusters

---

## Clustering Analysis Summary

In the clustering section, several preprocessing and encoding strategies were compared.

Earlier clustering versions showed that results could be overly driven by single variables such as gender or education.  
To improve interpretability, the final model used an **ordinal-aware encoding strategy**:

- age, income, and education were treated as ordered/continuous variables
- gender was kept as a binary variable
- marriage was one-hot encoded

A **4-cluster solution** was selected based on:

- silhouette score
- cluster size balance
- interpretability

The final results showed that:

- different demographic clusters had significantly different GAD-7 scores
- the youngest and more socioeconomically disadvantaged cluster had the highest anxiety burden
- the higher-income and higher-education cluster had the lowest anxiety burden

---

## Methods Used

This project uses both SQL and Python.

### SQL
Used for:

- data cleaning
- descriptive statistics
- basic grouped summaries

### Python
Used for:

- statistical testing
- sensitivity analysis
- regression modeling
- clustering analysis
- result interpretation

Main Python libraries include:

- pandas
- numpy
- scipy
- scikit-learn
- matplotlib

---

## Key Findings

Some main findings from the project include:

- anxiety severity differs across demographic groups
- younger and more socioeconomically disadvantaged respondents tend to show higher anxiety burden
- higher education, higher income, and more stable marital status are generally associated with lower anxiety burden
- clustering analysis supports that demographic and socioeconomic patterns are meaningfully related to GAD-7 severity

---

## Limitations

This project also has some limitations:

- the analysis is based on observational survey data
- causal conclusions cannot be made
- clustering results may change depending on preprocessing strategy
- some variables may be simplified by grouping

Even with these limitations, the project still provides useful insight into the relationship between demographic structure and anxiety severity.

---

## Future Improvement

Possible future work includes:

- adding symptom-based clustering using GAD-7 item-level responses
- testing more advanced models
- improving visualization
- adding post-hoc comparison after overall significance tests
- comparing regression and clustering findings more directly

---

## Author Note

This project was built as a step-by-step data analysis practice project combining SQL, Python, statistics, and data interpretation.  
It is also a practice in organizing a full analysis workflow from raw data cleaning to final subgroup interpretation.
