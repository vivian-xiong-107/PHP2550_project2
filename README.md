# PHP2550 project2
Predict the possibility of tracheostomy or mortality in individuals with severe bronchopulmonary dysplasia, utilizing multiple characteristics and medical measurements at 36 weeks postpartum


Caiwei Xiong

## Abstract
**Background:** Tracheostomy insertion may provide potential benefits for patients presenting with severe cases of bronchopulmonary dysplasia (BPD). Nevertheless, the implantation of a tracheostomy may potentially elevate the likelihood of mortality, inadvertent removal of the cannula, obstruction of the cannula, heightened rates of infection, and the development of tracheal stenosis.


**Methods:** This report will utilize various predictive models, including the lasso model, ridge model, logistic regression (without regularization), and the forward stepwise selection model, to accurately forecast the outcome.


**Results:**



**Conclusions:**

## Dataset

The BPD Collaborative Registry, a multi-center cooperation of multidisciplinary BPD programs in the US and Sweden, was the source of study participants. The consortium was founded to fill evidence gaps and advance research to improve the care of children with severe forms of BPD. Babies with severe bronchopulmonary dysplasia (sBPD), as defined by the NHLBI criteria of 2001 (FiO2 3 0.3 or positive pressure ventilation, either invasive or non-invasive, at 36 weeks postpartum), who have a gestational age of fewer than 32 weeks are included in the registry. Standard clinical and demographic information is gathered for the registry at four different intervals: birth, 36 weeks postpartum, 44 weeks postpartum, and discharge. We searched the registry for individuals with BPD and full growth records between January 1, 2021, and July 19, 2021, in order to conduct this study. Nine BPD Collaborative centres have provided data that met the research inclusion criteria at the time of analysis.


## Table and Plots

|              | Ridge regression model | Lasso regression model | Best subset model | Logistic regression model|
|:-------------|:----------------------:|-----------------------:|------------------:|-------------------------:|
|     AUC      |          0.861         |          0.863         |       0.918       |          0.857           |
|  Brier Score |          0.758         |          0.776         |       0.776       |          0.789           |
|  Sensitivity |                        |                        |                   |                          |
|  Specificity |                        |                        |                   |                          |
|   Accuracy   |                        |                        |                   |                          |
|   Precision  |                        |                        |                   |                          |



![Calibration Plot]([https://github.com/yourusername/yourrepository/blob/main/path/to/your/plot.png](https://github.com/vivian-xiong-107/PHP2550_project2/blob/main/AUC_models.png))


## Packages

All code contained within the R Markdown (Rmd) file, and R scripts are compatible with R version 4.2.1 and can be successfully compiled. The following part lists the packages and their corresponding versions that will be used:

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

## Acknowledgement

This project represents a collaborative effort, involving Dr. Chris Schmid in the Biostatistics Department(christopher_schmid@brown.edu), and is under the guidance of Dr. Alice Paul (alice_paul@brown.edu).
