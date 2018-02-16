#SLR

#importing the dataset
dataset = read.csv('Salary_Data.csv')

#splitting the data into test and trainingset
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 2/3)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

regressor = lm(formula = Salary ~ YearsExperienceInField, data = training_set)

#visualize the training results
#install.packages("ggplot2")
library(ggplot2)
ggplot() + geom_point(aes(x = training_set$YearsExperienceInField, y = training_set$Salary), colour = 'red')+
  geom_line(aes(x = training_set$YearsExperienceInField, y = predict(regressor, newdata = training_set)), colour = 'blue')+
  ggtitle('Salary vs Years Experience (Training Set)') + xlab('Years Experience') + ylab('Salary')
ggsave('trainingset.png')

#visualizing the test set results
ggplot() + geom_point(aes(x = test_set$YearsExperienceInField, y = test_set$Salary),colour = 'red') +
  geom_line(aes(x = training_set$YearsExperienceInField, y = predict(regressor, newdata = training_set)), colour = 'blue')+
  ggtitle('Salary vs Years Experience (Test Set)') + xlab('Years Experience') + ylab('Salary')
ggsave('testset.png')
