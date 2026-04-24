
## 1. Shannon Entropy ($H$)
This measures the nutritional diversity or "evenness" of a food item. A higher entropy indicates a more balanced distribution of nutrients, while a lower entropy indicates a food dominated by a single macronutrient (like pure sugar or oil).
$$H = -\sum_{i=1}^k p_i \log(p_i)$$ 

* $k$: The number of nutrient categories (e.g., Protein, Carbs, Fat).
* $p_i$: The proportion of the $i$-th nutrient (where $\sum p_i = 1$).
* Interpretation: Entropy is maximized when $p_1 = p_2 = \dots = p_k$. [1, 2] 

------------------------------

## Kullback–Leibler Divergence ($D_{KL}$)
Also known as "Relative Entropy," this measures how much a specific food's nutrient profile ($p$) diverges from a target or "ideal" reference profile ($r$).
$$D_{KL}(p \parallel r) = \sum_{i=1}^k p_i \log\left(\frac{p_i}{r_i}\right)$$ 
Alternatively, it can be expanded as:
$$D_{KL}(p \parallel r) = \sum_i p_i \log(p_i) - \sum_i p_i \log(r_i)$$ 

* $p$: The actual nutrient distribution of the food.
* $r$: The reference distribution (e.g., RDA guidelines).
* Interpretation: A value of 0 means the food perfectly matches the ideal diet. Larger values indicate a greater "distance" from the nutritional goal.

------------------------------

## Key Mathematical Insights

* The Core Term: Both formulas rely on the $x \log x$ function.
* Units: If you use $\log_2$, the entropy is measured in bits. If you use the natural log ($\ln$), it is measured in nats.
* Sensitivity: KL Divergence is particularly sensitive to nutrients that are missing in the food ($p_i > 0$) but required in the diet ($r_i > 0$).

------------------------------
