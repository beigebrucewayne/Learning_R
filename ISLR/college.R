college <- read.csv("/Users/bastcastle/Desktop/College.csv")
library(tidyverse)
college <- as_tibble(rownames_to_column(college))
head(college)
# take out college names from dataset
fixed_college  <- college %>% select(-X)
head(fixed_college)
summary(fixed_college)
boxplot(fixed_college$Outstate, fixed_college$Private)
# new var called Elite, schools with > 50% of students in Top10perc of HS class
Elite  <- rep("No", nrow(fixed_college))
Elite[fixed_college$Top10perc > 50] = "Yes"
Elite  <- as.factor(Elite)
head(Elite)
# add Elite column back to fixed tibble
elite.college  <- add_column(fixed_college, Elite)
summary(Elite)
boxplot(fixed_college$Outstate, Elite)
head(fixed_college)
new.college  <- fixed_college %>%
  mutate(acpt_rate = Accept / Apps)
head(new.college$acpt_rate)
head(elite.college$Elite)
ggplot(new.college, aes(new.college$Top10perc, new.college$acpt_rate, color=Private, fill=Private)) +
  geom_point() +
  labs(x="% of Incoming Class -> HS Top 10%", y="Acceptance Rate", title="Elite Colleges") 
