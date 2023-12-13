# load the dataset
project_two = read.csv("/Users/xiongcaiwei/Downloads/project2.csv")

# remove duplicate row from dataset
project_two = unique(project_two)

# according to record_id both missing value of center were from center 1
project_two$center[is.na(project_two$center)] = 1

# remove the data point where death is missing 
project_two = project_two %>%
  filter(!is.na(Death))

# center 21 is magic number, convert the center 21 to center 1
project_two$center[which(project_two$center == 21)] = 1


project_two = project_two %>% mutate(outcome_result = 
                                       case_when(Death == "Yes" ~ 1,
                                                 Trach == 1 ~ 1, 
                                                 .default = 0)) 

# remove the mat_race variable which does not match codebook encoding
project_two = project_two  %>%   
  dplyr::select(-c(mat_race))

# factor the categorical variable
project_two$center = as.factor(project_two$center)
project_two$mat_ethn = as.factor(project_two$mat_ethn)
project_two$del_method = as.factor(project_two$del_method)
project_two = project_two %>% mutate(prenat_ster = 
                                       case_when(prenat_ster == "Yes" ~ 1,
                                                 prenat_ster == "No" ~ 0, 
                                                 prenat_ster == "Unknown" ~ 2)) 
project_two$prenat_ster = as.factor(project_two$prenat_ster)

project_two = project_two %>% mutate(com_prenat_ster = 
                                       case_when(com_prenat_ster == "Yes" ~ 1,
                                                 com_prenat_ster == "No" ~ 0, 
                                                 com_prenat_ster == "Unknown" ~ 2)) 
project_two$com_prenat_ster = as.factor(project_two$com_prenat_ster)

project_two = project_two %>% mutate(mat_chorio = 
                                       case_when(mat_chorio == "Yes" ~ 1,
                                                 mat_chorio == "No" ~ 0, 
                                                 mat_chorio == "Unknown" ~ 2)) 
project_two$mat_chorio = as.factor(project_two$mat_chorio)

project_two = project_two %>% mutate(gender = 
                                       case_when(gender == "Male" ~ 1,
                                                 gender == "Female" ~ 0, 
                                                 gender == "Ambiguous" ~ 2)) 
project_two$gender = as.factor(project_two$gender)

project_two = project_two %>% mutate(sga = 
                                       case_when(sga == "SGA" ~ 1,
                                                 sga == "Not SGA" ~ 0)) 
project_two$sga = as.factor(project_two$sga)

project_two = project_two %>% mutate(any_surf = 
                                       case_when(any_surf == "Yes" ~ 1,
                                                 any_surf == "No" ~ 0, 
                                                 any_surf == "Unknown" ~ 2)) 
project_two$any_surf = as.factor(project_two$any_surf)

project_two$med_ph.36 = as.factor(project_two$med_ph.36)

project_two$Trach = as.factor(project_two$Trach)

project_two = project_two %>% mutate(Death = 
                                       case_when(Death == "Yes" ~ 1,
                                                 Death == "No" ~ 0)) 
project_two$Death = as.factor(project_two$Death)

project_two$outcome_result = as.factor(project_two$outcome_result)
project_two$med_ph.36 = as.factor(project_two$med_ph.36)
project_two$med_ph.44= as.factor(project_two$med_ph.44)


project_two$com_prenat_ster[which(project_two$prenat_ster == 0)] = 0

# convert the ventilation supper level in 36 and 44 weeks to ordinal variables
project_two$ventilation_support_level.36 = ordered(project_two$ventilation_support_level.36, levels = 0:2)
project_two$ventilation_support_level_modified.44 = ordered(project_two$ventilation_support_level_modified.44, levels = 0:2)

# remove 44 weeks' variable (i.e., due to extremely high missing percentage)
project_two = project_two %>% 
  dplyr::select(-c(weight_today.44, ventilation_support_level_modified.44, inspired_oxygen.44,
                   p_delta.44, peep_cm_h2o_modified.44, med_ph.44))

# create a new category for any_surf variable (i.e., missing indicator)
project_two = project_two %>%
  mutate(any_surf = case_when(
    any_surf == 1 ~ 1,
    any_surf == 0 ~ 0,
    is.na(any_surf) == TRUE ~ 2
  ))

project_two = project_two  %>%
  dplyr::select(-c(record_id, Trach, Death))

# due to our research goal was to predict the bad outcome (Death or Trachoestomy) based on patients characteristics,
# the new dataset may belong to different center. Include center variable to generate the prediction model may 
# increase prediction error. 
project_two = project_two  %>%   
  dplyr::select(-c(center))

# remove the patient who discharged before 36 weeks
project_two = project_two %>% filter(hosp_dc_ga >= 36)
