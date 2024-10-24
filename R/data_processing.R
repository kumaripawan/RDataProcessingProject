# Load required libraries
library(tidyverse)
library(caret)
library(e1071)
library(shiny)

# Preprocess data function
preprocess_data <- function(data) {
  data <- na.omit(data)
  data <- data %>%
    mutate_if(is.numeric, scale) # Scaling numeric features
  trainIndex <- createDataPartition(data$target, p = 0.8, 
                                    list = FALSE, 
                                    times = 1)
  trainData <- data[trainIndex, ]
  testData  <- data[-trainIndex, ]
  list(train = trainData, test = testData)
}

# Train model function
train_model <- function(train_data, model_type) {
  if (model_type == "linear_regression") {
    model <- train(target ~ ., data = train_data, method = "lm")
  } else if (model_type == "svm") {
    model <- train(target ~ ., data = train_data, method = "svmRadial")
  } else {
    stop("Unknown model type")
  }
  return(model)
}

# Evaluate model function
evaluate_model <- function(model, test_data) {
  predictions <- predict(model, test_data)
  metrics <- postResample(pred = predictions, obs = test_data$target)
  return(metrics)
}

# Plot performance function
plot_performance <- function(metrics) {
  barplot(metrics, main = "Model Performance Metrics", beside = TRUE)
}

# Example usage
# data <- read.csv("data.csv")
# processed_data <- preprocess_data(data)
# model <- train_model(processed_data$train, "linear_regression")
# metrics <- evaluate_model(model, processed_data$test)
# print(metrics)
# plot_performance(metrics)


library(covr)
coverage <- package_coverage()
report(coverage)

