# RDataProcessingProject

## Project Overview

This project demonstrates the use of R for data processing, including various functionalities such as model training and testing. The project is also integrated with GitHub Actions for Continuous Integration (CI) to automatically run unit tests and generate code coverage reports.

## Features

- Data processing using `caret`, `e1071`, `tidyverse`, and `kernlab`.
- Model training and evaluation with SVM.
- Unit testing using `testthat`.
- Continuous integration using GitHub Actions.
- Code coverage reporting using `covr`.

## Project Structure

The project is structured as follows:

```plaintext
RDataProcessingProject/
│
├── .github/             # Contains the GitHub Actions CI workflow files
│   └── workflows/
│       └── r-ci.yml     # GitHub Actions CI configuration
│
├── R/                   # Contains all R source files
│   └── data_processing.R # Main data processing script
│
├── tests/               # Contains unit test files
│   └── test_data_processing.R # Unit tests for the project
│
├── .gitignore           # Specifies files to ignore in git
├── README.md            # Project documentation (this file)
├── RDataProcessingProject.Rproj # RStudio project file
└── DESCRIPTION          # Metadata about the project

Installation
Prerequisites
R (version 4.3.2 or higher)
Install the following R packages:

install.packages(c("caret", "e1071", "tidyverse", "testthat", "shiny", "kernlab", "covr", "usethis"))

GitHub Actions Setup
This project includes a GitHub Actions workflow to automatically run tests and generate code coverage reports. The workflow file is located in .github/workflows/r-ci.yml.

Usage
Running the Data Processing Script
To run the data processing script, simply source the data_processing.R file:
source("R/data_processing.R")
This will execute the main data processing and model training steps.

Running Unit Tests
Unit tests are located in the tests/testthat/ folder. To run the tests manually, use:
library(testthat)
test_dir("tests/testthat")


Code Coverage
The project includes code coverage reporting using the covr package. To manually generate a coverage report:
library(covr)
coverage <- package_coverage()
report(coverage)
This will generate an HTML report of the code coverage for the project.

Continuous Integration
The project is set up with GitHub Actions for Continuous Integration (CI). Every push to the master branch triggers a workflow that:

Checks out the code.
Sets up the R environment.
Installs the necessary dependencies.
Runs unit tests using testthat.
Generates a code coverage report using covr.
You can view the results of the CI runs in the "Actions" tab of this GitHub repository.

License
This project is licensed under the MIT License - see the LICENSE file for details.

Acknowledgments
This project was developed as part of a Master’s program with a focus on data processing, machine learning, and continuous integration practices in R.

### Instructions for Use:
1. Place this `README.md` in the root directory of your project.
2. Update the project name, description, and any specific details relevant to your use case.
3. Ensure that the project structure and file paths mentioned align with your actual project setup.
4. Add any necessary sections, such as contributing guidelines or further documentation links if applicable.


