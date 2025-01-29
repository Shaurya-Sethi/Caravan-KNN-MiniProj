# Predicting whether a person purchases a insurance policy or not (Using KNN)
# Working on the Caravan dataset of the ISLR package
# install.packages("ISLR")
# library(ISLR)

df <- Caravan
print(sum(is.na(df))) # returns 0 indicating no missing values

df$Purchase <- ifelse(df$Purchase == "Yes", 1, 0) # Encode categorical variable for classification
purch <- df$Purchase # Store the Purchase (indicates whether individual purchased or not) as a separate Column


# Calling summary() on our data tells us that the data needs to be standardised
# Check in console : var(df[,1]) ; this returns 165 approx
# Check in console : var(df[,2]) ; this returns 0.164 approx 

df[,-86] <- scale(df[,-86]) # standardise all features excluding Purchase
cat(sprintf("Variance of col 1 is : %.7f and Variance of col 2 is : %.7f",var(df[,1]),var(df[,2]))) # Check if it worked 
# Returns 1 for both , looks like it worked.

library(caTools)
library(class)

set.seed(42)
split <- sample.split(purch, SplitRatio = 0.7)

trainset <- subset(df, split == TRUE)
testset <- subset(df, split == FALSE)

train_X <- trainset[, -86]  # Exclude Purchase column
test_X <- testset[, -86]    # Exclude Purchase column
train_Y <- trainset[, 86]   # Target variable (Purchase)
test_Y <- testset[, 86]     # Target variable (Purchase)

##################
# KNN Model

pred_purch <- knn(train_X, test_X, train_Y, k = 5)

# Evaluate Performance
conf_matrix_5 <- table(Predicted = pred_purch, Actual = test_Y)

library(knitr)
library(dplyr)

conf_matrix_df <- as.data.frame.matrix(conf_matrix_5)  # Convert table to dataframe

# Add row names as a column
conf_matrix_df <- conf_matrix_df %>%
  tibble::rownames_to_column(var = "Predicted / Actual")

# Display the confusion matrix using kable()
print(kable(conf_matrix_df, caption = "Confusion Matrix for KNN Model", align = 'c'))

# Calculate Accuracy
accuracy_5 <- sum(diag(conf_matrix_5)) / sum(conf_matrix_5)
cat(sprintf("\nKNN Model Accuracy: %.4f\n", accuracy_5))

# Optimise model by choosing a better k value
# Elbow method

pred_purch2 <- NULL
error_rate <- NULL

for(i in 1:20){
  set.seed(42)
  pred_purch2 <- knn(train_X, test_X, train_Y, k = i)
  error_rate[i] <- mean(test_Y != pred_purch2)
}

k.values <- 1:20
ER_df <- data.frame(k.values , error_rate)

least.error <- min(ER_df$error_rate) # 0.05956472
optimal.k <- ER_df$k.values[which.min(ER_df$error_rate)] # 11


# Visualising elbow method
library(ggplot2)
pl <- ggplot(ER_df , aes(x = k.values , y = error_rate)) + geom_point() + geom_line(lty='dotted',color='red') +
  ggtitle("Elbow Method for Optimal k")
print(pl)

##################
# KNN Model (Optimal k = 11)
set.seed(42)
pred_purch_11 <- knn(train_X, test_X, train_Y, k = optimal.k)

# Evaluate Performance
conf_matrix_11 <- table(Predicted = pred_purch_11, Actual = test_Y)
accuracy_11 <- sum(diag(conf_matrix_11)) / sum(conf_matrix_11)

##################
# Comparison Table

comparison_df <- data.frame(
  `Metric` = c("Accuracy", "False Positives", "False Negatives"),
  `KNN (k=5)` = c(accuracy_5, conf_matrix_5[2,1], conf_matrix_5[1,2]),
  `KNN (k=11)` = c(accuracy_11, conf_matrix_11[2,1], conf_matrix_11[1,2])
)

# Display the comparison table
print(kable(comparison_df, caption = "Comparison of KNN Models (k=5 vs. k=11)", align = 'c'))






