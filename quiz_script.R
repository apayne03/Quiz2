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

agreeableness <- mutate(agreeableness,A1=6-A5)
extraversion <- mutate(extraversion,E1=6-E5)
extraversion <- mutate(extraversion,E2=6-E5)

#Obtaining Scale Scores
agreeableness <- psych::alpha(as.data.frame(agreeableness), check.keys=FALSE)$scores
extraversion <- psych::alpha(as.data.frame(extraversion), check.keys=FALSE)$scores
neuroticism <- psych::alpha(as.data.frame(neuroticism), check.keys=FALSE)$scores

#Combine into analytic_data
analytic_data <- cbind(categorical_variables, agreeableness, neuroticism, extraversion)

# Creating Male and Female Subsets
analytic_data_male <-  filter(analytic_data, sex=="Males", age>"40")
analytic_data_male <- select(analytic_data, -sex, -age)

#Saving .RData, CSV, .SAV 
write_csv(analytic_data,path="analytic_data.csv")

apa.cor.table(analytic_data, filename="Table1.doc", table.number=1)
apa.cor.table(analytic_data_male, filename = "Table2.doc", table.number=2)
