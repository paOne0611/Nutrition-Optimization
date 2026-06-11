
# 🥗 Nutrition Optimization

This project focuses on optimizing dietary choices using data analysis and few inequality measures. It aims to help users make better nutrition decisions by analyzing food data and generating optimized diet plans.

---

## 📂 Project Structure
---

## Features

- Nutritional data analysis  
- Diet optimization  
- Data visualization  

---

## Tech Stack

- R libraries
  - ggplot
  - lattice
  - tidyr
  - moments
- Python libraries
  - pyreader
  - cvxpy
  - pandas
  - numpy
- RData files (contain the cleaned datasets)
  - cvx.RData : ...for optimization problems
  - clean.RData: ...for data analysis
- qmd file : contains the R code for the data analysis with proper comments
- others: code for cleaning the datasets and working on them

---

## Usage

- Explore data in the `data/` folder  
- Modify reports/ presentations in `reports_presentations/`  
- Update models in `src/`  
- Run scripts i.e., `unconstrained.R/` and `constrained.py/` to generate optimized nutrition plans  

---

### Practical Example

Consider a meal with the following energy distribution:

- **Protein:** 10%  
- **Fat:** 30%  
- **Carbohydrates:** 60%  

This distribution has a certain entropy value representing its nutritional balance.

If we modify the meal (for example, by replacing carbohydrates with protein), the entropy changes. Whether this change is desirable depends on the target nutritional profile.




------------------------------
