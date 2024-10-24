# Load the testthat package and the script to be tested
library(testthat)
source("../data_processing.R")  # Corrected the path to point to data_processing.R in the root folder

# Unit Test 1: Testing the preprocess_data function
test_that("preprocess_data works correctly", {
  data <- data.frame(
    target = c(1, 2, 3, 4, 5, 6, NA, 8, 9, 10),
    feature1 = rnorm(10),
    feature2 = rnorm(10)
  )

  processed_data <- preprocess_data(data)

  # Check if the number of rows in train and test matches the original (minus NA)
  expect_equal(nrow(processed_data$train) + nrow(processed_data$test), nrow(na.omit(data)))

  # Check if the feature scaling worked
  expect_true(all(abs(mean(processed_data$train$feature1)) < 1e-10))
})

# Unit Test 2: Testing the train_model function
test_that("train_model works correctly", {
  data <- data.frame(
    target = rnorm(100),
    feature1 = rnorm(100),
    feature2 = rnorm(100)
  )

  processed_data <- preprocess_data(data)

  # Test linear regression model training
  model <- train_model(processed_data$train, "linear_regression")
  expect_s3_class(model, "train")  # Check if the model object is of class 'train'

  # Test SVM model training
  model <- train_model(processed_data$train, "svm")
  expect_s3_class(model, "train")  # Check if the model object is of class 'train'
})

# Unit Test 3: Testing the evaluate_model function
test_that("evaluate_model works correctly", {
  data <- data.frame(
    target = rnorm(100),
    feature1 = rnorm(100),
    feature2 = rnorm(100)
  )

  processed_data <- preprocess_data(data)

  # Train a model and evaluate it
  model <- train_model(processed_data$train, "linear_regression")
  metrics <- evaluate_model(model, processed_data$test)

  # Ensure the metrics list contains the expected names
  expect_named(metrics, c("RMSE", "Rsquared", "MAE"))
})

# Unit Test 4: Testing the plot_performance function
test_that("plot_performance works correctly", {
  metrics <- c(RMSE = 0.1, Rsquared = 0.9, MAE = 0.05)

  # Ensure the function doesn't throw an error
  expect_error(plot_performance(metrics), NA)
})

# Unit Test 5: Testing zero variance features
test_that("Zero variance feature test works correctly", {
  # Minimal dataset with a zero variance feature
  data <- data.frame(
    target = c(1, 0, 1, 0),
    feature1 = rep(1, 4),  # Zero variance
    feature2 = c(1, 2, 3, 4)
  )

  processed_data <- preprocess_data(data)

  # Check if the feature with zero variance is handled correctly (removed or ignored)
  expect_true(!"feature1" %in% colnames(processed_data$train))  # Example: feature1 should be removed

  # Train a simple model and check if it runs without errors
  model <- train_model(processed_data$train, "linear_regression")
  expect_s3_class(model, "train")
})

# Unit Test 6: Testing unbalanced classes
test_that("Unbalanced class test works correctly", {
  # Simplified unbalanced data set
  data <- data.frame(
    target = c(rep(1, 90), rep(0, 10)),  # 90% class 1, 10% class 0
    feature1 = rnorm(100),
    feature2 = rnorm(100)
  )

  processed_data <- preprocess_data(data)

  # Train a simple model and ensure it runs without errors
  model <- train_model(processed_data$train, "svm")
  expect_s3_class(model, "train")

  # Evaluate the model to ensure it returns correct metric names
  metrics <- evaluate_model(model, processed_data$test)
  expect_named(metrics, c("RMSE", "Rsquared", "MAE"))
})
