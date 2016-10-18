#Load Packages
library(tidyverse)
library(haven)
library(apaTables)
library(dplyr)

bfi_data <- psych::bfi

#Labelling Data
categorical_variables <- select(bfi_data, gender, age)
categorical_variables$gender <- as.factor(categorical_variables$gender)
levels(categorical_variables$gender) <- list("Male"=1, "Female"=2)
gender <- categorical_variables$gender

#Creating Item Scales
agreeableness <- select (bfi_data, A1, A2, A3, A4, A5)
extraversion <- select (bfi_data, E1, E2, E3, E4, E5)
neuroticism <- select (bfi_data, N1, N2, N3, N4, N5)

agreeableness <- mutate(agreeableness,A1=7-A6)
extraversion <- mutate(extraversion,E1=7-E6)
extraversion <- mutate(extraversion,E2=7-E6)

#Obtaining Scale Scores
agreeableness <- psych::alpha(as.data.frame(agreeableness), check.keys=FALSE)$scores
extraversion <- psych::alpha(as.data.frame(extraversion), check.keys=FALSE)$scores
neuroticism <- psych::alpha(as.data.frame(neuroticism), check.keys=FALSE)$scores

#Combine into analytic_data
analytic_data <- cbind(categorical_variables, agreeableness, neuroticism, extraversion)

#Saving .RData, CSV, .SAV 
write_csv(analytic_data,path="analytic_data.csv")
