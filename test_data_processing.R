# Load required libraries
library(testthat)
source("data_processing.R")

# Test preprocess_data function
test_that("preprocess_data works correctly", {
  data <- data.frame(target = c(1, 2, 3, 4, 5, 6, NA, 8, 9, 10), 
                     feature1 = rnorm(10), feature2 = rnorm(10))
  processed_data <- preprocess_data(data)
  expect_equal(nrow(processed_data$train) + nrow(processed_data$test), nrow(na.omit(data)))
  expect_true(all(abs(mean(processed_data$train$feature1)) < 1e-10))
})

# Test train_model function
test_that("train_model works correctly", {
  data <- data.frame(target = rnorm(100), 
                     feature1 = rnorm(100), feature2 = rnorm(100))
  processed_data <- preprocess_data(data)
  model <- train_model(processed_data$train, "linear_regression")
  expect_s3_class(model, "train")
  model <- train_model(processed_data$train, "svm")
  expect_s3_class(model, "train")
})

# Test evaluate_model function
test_that("evaluate_model works correctly", {
  data <- data.frame(target = rnorm(100), 
                     feature1 = rnorm(100), feature2 = rnorm(100))
  processed_data <- preprocess_data(data)
  model <- train_model(processed_data$train, "linear_regression")
  metrics <- evaluate_model(model, processed_data$test)
  expect_named(metrics, c("RMSE", "Rsquared", "MAE"))
})

# Test plot_performance function
test_that("plot_performance works correctly", {
  metrics <- c(RMSE = 0.1, Rsquared = 0.9, MAE = 0.05)
  expect_error(plot_performance(metrics), NA)
})
