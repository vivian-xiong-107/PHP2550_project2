# PHP2550_project2
Predict the possibility of tracheostomy or mortality in individuals with severe bronchopulmonary dysplasia, utilizing multiple characteristics and medical measurements at 36 weeks postpartum


Caiwei Xiong

## Abstract
**Background:**


**Methods:**


**Results:**



**Conclusions:**

## Dataset

The BPD Collaborative Registry, a multi-center cooperation of multidisciplinary BPD programs in the US and Sweden, was the source of study participants. The consortium was founded to fill evidence gaps and advance research to improve the care of children with severe forms of BPD. Babies with severe bronchopulmonary dysplasia (sBPD), as defined by the NHLBI criteria of 2001 (FiO2 3 0.3 or positive pressure ventilation, either invasive or non-invasive, at 36 weeks postpartum), who have a gestational age of fewer than 32 weeks are included in the registry. Standard clinical and demographic information is gathered for the registry at four different intervals: birth, 36 weeks postpartum, 44 weeks postpartum, and discharge. We searched the registry for individuals with BPD and full growth records between January 1, 2021, and July 19, 2021, in order to conduct this study. Nine BPD Collaborative centres have provided data that met the research inclusion criteria at the time of analysis.

## Methods

To predict the severe result based on patient characteristics, several regression models were used: ridge regression model, logistic regression model without regularization, Forward Stepwise selection model, and lasso regression model. 

## Packages

DescTools (0.99.5)

dplyr (1.1.3)

ggplot2 (3.4.0)

gt (0.9.0)

gtsummary (1.7.2)

kableExtra (1.3.4)

mice (3.15.0)

pROC (1.18.4)

ROCR (1.0-11)

tidyr (1.2.1)

tidyverse (1.3.2)

glmnet (4.1-8)


## Files
The codes for preprocessing was stored in: ``project2_preprocessing.R``, the codes for models was stored in: ``proejct2_models.R``, the codes for construct report was stored in: ``Project2.Rmd``
