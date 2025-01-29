# KNN-Based Prediction of Insurance Purchase

## 📌 Project Overview
This project implements a **K-Nearest Neighbors (KNN)** model to predict whether a person purchases an insurance policy based on demographic and socioeconomic features. The dataset used is the **Caravan dataset** from the `ISLR` package in R.

The project follows a **machine learning workflow**, including:
- Data preprocessing (handling categorical data, standardization)
- Splitting data into training and test sets
- Implementing a **KNN model with k = 5**
- Using the **Elbow Method** to find the optimal `k`
- Evaluating the best KNN model (`k = 11`) and comparing it with the original model

---

## 📂 Dataset: Caravan (ISLR Package)
The **Caravan dataset** consists of **5,822 rows and 86 features**, with a **binary target variable** (`Purchase`):
- `Purchase`: **1 (Yes)** if the person purchased insurance, **0 (No)** otherwise.
- 85 predictor variables representing demographic and socioeconomic factors.

---

## 🛠️ Steps Implemented
### 1️⃣ Data Preprocessing
- **Checked for missing values** (`sum(is.na(df))` → returns 0 ✅)
- **Converted categorical variable** `Purchase` into a numeric binary format (`1` for Yes, `0` for No)
- **Standardized all predictor variables** to normalize the scale using `scale()`
- **Split dataset (70-30)** into training and test sets using `caTools::sample.split()`

### 2️⃣ Initial KNN Model (`k = 5`)
- Trained a **KNN classifier with `k = 5`**.
- Computed a **confusion matrix and accuracy score**.

### 3️⃣ Finding the Optimal `k` (Elbow Method)
- Trained **20 different KNN models (k = 1 to 20)**.
- Stored and plotted the **error rate vs. k values**.
- **Optimal k = 11** (found using `which.min(error_rate)`).

### 4️⃣ Improved KNN Model (`k = 11`)
- Trained a new **KNN model using `k = 11`**.
- Evaluated its **accuracy and confusion matrix**.

### 5️⃣ Comparing KNN-5 vs. KNN-11
| Metric            | KNN (k=5) | KNN (k=11) |
|------------------|-----------|------------|
| **Accuracy**     | 0.932417  | 0.9404353  |
| **False Positives** | 15.000000  | 0.0000000  |
| **False Negatives** | 103.000000 | 104.0000000 |

📊 **Results:** The optimized KNN model (`k = 11`) outperformed the default KNN (`k = 5`), showing **better accuracy and lower false positives, though false negatives remained similar.**

---

## 📌 Technologies & Libraries Used
- **Programming Language**: R
- **Libraries**:
  - `ISLR` → Dataset
  - `caTools` → Train-test split
  - `class` → KNN implementation
  - `ggplot2` → Visualization (Elbow Method)
  - `knitr` → Nicely formatted tables
  - `dplyr` → Data manipulation

---

## 📊 Visualization: Elbow Method
![](elbow_method_plot.png)  
Graph showing the **error rate vs. k values**, indicating the best `k = 11`.

---

## 🚀 How to Run the Code
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/KNN-Insurance-Purchase.git
   cd KNN-Insurance-Purchase
   ```
2. Open **R** or **RStudio**.
3. Install required packages (if not already installed):
   ```r
   install.packages(c("ISLR", "caTools", "class", "ggplot2", "knitr", "dplyr"))
   ```
4. Run the script step by step or execute the entire file.

---

### 🏆 Conclusion
This project successfully **optimized a KNN model** to predict insurance purchases with better accuracy. The **Elbow Method** helped us select an optimal `k`, improving model performance. This approach can be extended to **other classification problems** in customer analytics and marketing!

🔥 **Feel free to fork, improve, or suggest enhancements!** 🚀

