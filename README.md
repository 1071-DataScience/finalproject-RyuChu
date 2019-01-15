# < Taipei House Rental 2018 >

### Groups
* < 朱奕寧, 107753042 >
* < 張筆翔, 106753038 >

### Goal
To predict the price for house rental.

### demo 
1. Using R-Studio to run Data.R to modify the rental_data.
2. Using R-Studio to run RF.R to make the model.
3. Through the shiny app to predict to price.

on-line visualization: https://ryuuuuuu.shinyapps.io/Taipei_House_Rental_2018/

## Folder organization and its related information

### docs
* My presentation, 1071_datascience_FP_<107753042|Taipei_House_Rental_2018>.pptx

### data
* Source : Dept of Land Administration M. O. I.
( https://lvr.land.moi.gov.tw/homePage.action )

* Any preprocessing?
  * Handle missing data
  * Scale value

### code
* Using 5-fold cross-validation, and random forest

### results
* Testing Accuracy: 0.1584543
  Training Accuracy: 0.9816459
  Validation Accuracy: 0.81573
* Challenge: 1.Numbers of data is small
             2.Values in the specific column are disparity
