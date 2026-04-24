### Analysing the balance of multiple nutrients within a single food (entropy / diversity)

If for one food item you convert the amounts of different nutrients (e.g., grams of carbohydrates, fat, protein) into proportions \(p_i\) that sum to 1 (by mass or by energy), the Shannon entropy is

\[
H = -\sum_{i=1}^k p_i \log p_i.
\]

Here the basic element is \(p \log p\) – the same mathematical shape. Entropy is highest when all nutrients are equally represented (most “balanced” profile), and lowest when one nutrient dominates.

If you want to compare a food’s nutrient profile to a reference profile (say, an ideal diet), you can use the **Kullback–Leibler divergence**:

\[
D_{KL}(p \| r) = \sum_i p_i \log\frac{p_i}{r_i}
   = \sum_i p_i \log p_i - \sum_i p_i \log r_i,
\]

which also relies entirely on \(p \log p\) and \(p \log r\) terms. This tells you how much the actual nutrient distribution diverges from the target.

**Practical example**  
A meal with 10 % energy from protein, 30 % from fat, and 60 % from carbohydrates has a certain entropy. Replacing some carbs with protein would increase or decrease the balance depending on your goal. A dietitian can quantify “nutritional diversity” with these entropy measures, all of which are built on \(x \log x\).

---
