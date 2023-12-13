###################################################### 
#### Lasso #### 
###################################################### 
lassor = function(df) {
  #' Runs 10-fold CV for lasso and returns corresponding coefficients
  #' @param df, data set
  #' @return coef, coefficients for minimum cv error
  
  # Matrix form for ordered variables
  x.ord = model.matrix(outcome_result~., data = df)[,-1]
  y.ord = df$outcome_result
  # Generate folds
  k = 10
  set.seed(1) # consistent seeds between imputed data sets
  folds = sample(1:k, nrow(df), replace=TRUE)
  # Lasso model
  lasso_mod_cv = cv.glmnet(x.ord, y.ord, nfolds = 10, 
                           foldid = folds,alpha = 1, 
                           family = "binomial")
  lasso_mod = glmnet(x.ord, y.ord, folds = 10, 
                     alpha = 1, family = "binomial", 
                     lambda = lasso_mod_cv$lambda.min)
  # Get coefficients
  Coef = coef(lasso_mod)
  return(Coef)
}
###################################################### 
## logistic regression model with no regularization ##
######################################################  
logistic_regression_model = function(df){
  #' Fit logistic regression to the dataset
  #' @param df, data set
  #' @return coef
  
  x.ord = model.matrix(outcome_result~., data = df)[,-1] 
  y.ord = df$outcome_result
  temp_temp = as.data.frame(cbind(x.ord, y.ord))
  logistic_model = glm(as.factor(y.ord)~.,family = "binomial",data=temp_temp)
  coefficient_value = logistic_model$coefficients
  return(coefficient_value)
}


###################################################### 
#### Ridge #### 
###################################################### 
Ridge = function(df){
  #' Runs 10-fold CV for ridge and returns corresponding coefficients 
  #' @param df, data set
  #' @return coef, coefficients for minimum cv error
  
  # Matrix form for ordered variables 
  x.ord = model.matrix(outcome_result~., data = df)[,-1] 
  y.ord = df$outcome_result
  
  # Generate folds
  k = 10 
  set.seed(1) # consistent seeds between imputed data sets
  folds = sample(1:k, nrow(df), replace=TRUE)
  
  # Ridge model
  ridge_model = cv.glmnet(x.ord, y.ord, alpha = 0, family = "binomial",
                          nfolds = 10, foldid = folds)
  
  # Get coefficients 
  coef = coef(ridge_model, lambda = ridge_model$lambda.min) 
  return(coef) 
}


###################################################### 
#### Forward Stepwise selection model #### 
###################################################### 
# Fit Forward Stepwise selection model using cross-validation
stepwise_AIC_model = function(df){
  outcome_var = "outcome_result"
  predictor_vars = setdiff(names(df), outcome_var)
  folds = createFolds(df[[outcome_var]], k = 14, list = TRUE, returnTrain = TRUE)
  cv_results = list()
  for(i in seq_along(folds)) {
    train_set = df[folds[[i]], ]
    
    # Fit the initial model with only the intercept
    initial_model = glm(as.formula(paste(outcome_var, "~ 1")),
                        data = train_set, family = binomial)
    
    # Perform stepwise selection using AIC as the criterion
    stepwise_model = stepAIC(initial_model, 
                             scope = list(lower = as.formula(paste(outcome_var, "~ 1")), 
                                          upper = as.formula(paste(outcome_var, "~", paste(predictor_vars, collapse = "+")))), 
                             direction = "forward", trace = FALSE)
    
    # Store the selected model's formula and AIC
    cv_results[[i]] = list(formula = formula(stepwise_model), aic = AIC(stepwise_model))
  }
  average_aics = sapply(cv_results, function(x) x$aic)
  best_fold = which.min(average_aics)
  best_model_formula = cv_results[[best_fold]]$formula
  final_model = glm(best_model_formula, data = df, family = binomial)
  best_model = coef(final_model)
  return(best_model)
}

###################################################### 
#### Lasso with interaction term #### 
###################################################### 
lasso_with_interaction <- function(df) { 
  #' Runs 10-fold CV for lasso and returns corresponding coefficients 
  #' @param df, data set
  #' @return coef, coefficients for minimum cv error

 #Matrix form for ordered variables 
  formula <- as.formula(outcome_result ~ .*.)
  x.ord <- model.matrix(formula, data = df)[,-1] 
  y.ord <- df$outcome_result

# Generate folds
  k <- 10 
  set.seed(1) # consistent seeds between imputed data sets
  folds <- sample(1:k, nrow(df), replace=TRUE)

 #Lasso model
  lasso_mod <- cv.glmnet(x.ord, y.ord, nfolds = 10, foldid = folds, 
                         alpha = 1, family = "binomial") 
  
# Get coefficients 
  coef <- coef(lasso_mod, lambda = lasso_mod$lambda.min) 
  return(coef) 
} 



###################################################### 
#### Best subset model #### 
###################################################### 
best_subset = function(df){
  #' Runs 10-fold CV for best subset of logistic regression and returns corresponding coefficients 
  #' @param df, data set
  #' @return coef, coefficients for minimum cv error
  x.ord = model.matrix(outcome_result~ ., data = df)
  y.ord = df$outcome_result
  fit = L0Learn.cvfit(x.ord[,-1], y.ord, penalty="L0",loss="Logistic", maxSuppSize=20,nFolds=10, seed=1)
  best_index = which(unlist(fit$cvMeans)==min(unlist(fit$cvMeans)))
  coef.bs = as.vector(coef(fit, lambda=print(fit)[best_index,]$lambda))
  names(coef.bs) = colnames(x.ord)
  return(coef.bs)
}