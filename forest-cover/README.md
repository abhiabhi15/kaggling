## Forest Cover Type Prediction

#### R version :  `3.1.0`
#### Author :     `Abhishek , Nisarg`



###Project Description
The goal of this project is to predict the forest cover type (the predominant kind of tree cover) from strictly cartographic variables (as opposed to remotely sensed data) collected and derived from the US Geological Survey and USFS. The approach for this prediction task will proceed with deriving the appropriate algorithm that can perform the task with maximum accuracy along with its comparison with various other classification methods.


### Data Description

Data is obtained from the UCI repository (also in Kaggle[2]), under the data set tilted “Covertype data set”. The training set consists of 15120 observations. These data records include all of the cartographic variables plus an indicator of the correct cover type. From this training data, we are to predict the cover type for the test data set of 565892 observations. The test data set has the same cartographic variables, but does not include the cover type. For the further detailed understanding of the data we also referred the publication on Comparative accuracies on ANN[1].


### Code Description

* **Classifiers**
1. Support Vector Machine
2. K- Nearest Neighbour
3. Decision Tree
4. Random Forest
5. Naive Bayesian 


### References
[1] "Comparative Accuracies of Artificial Neural Networks and Discriminant Analysis in Predicting Forest Cover Types from Cartographic Variables" by Blackard, Jock A. and Denis J. Dean.


[2] Kaggle Link : http://www.kaggle.com/c/forest-cover-type-prediction

