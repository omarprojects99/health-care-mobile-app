# Import necessary libraries
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error
from sklearn.preprocessing import StandardScaler
import joblib 







df = pd.read_csv('dataset/dataset3.csv')


#defining the necessary columns
#necessary_columns = ['ClientID','MeanCycleLength', 'MeanMensesLength', 'Age','Numberpreg','BMI','LengthofCycle',
#'LengthofMenses','EstimatedDayofOvulation']


#taking the unnecessary_columns
unnecessary_columns = ['MensesScoreDayFour','MensesScoreDayFive','MensesScoreDaySix',
                        'MensesScoreDaySeven','MensesScoreDayEight','MensesScoreDayNine',
                        'MensesScoreDayTen','MensesScoreDay11','MensesScoreDay12','MensesScoreDay13',
                        'MensesScoreDay14','MensesScoreDay15','TotalMensesScore','MeanBleedingIntensity',
                        'NumberofDaysofIntercourse','IntercourseInFertileWindow','UnusualBleeding',
                        'PhasesBleeding','IntercourseDuringUnusBleed','Maristatus',
                        'MaristatusM','Yearsmarried','Wedding','Religion','ReligionM','Ethnicity',
                        'EthnicityM','Schoolyears','SchoolyearsM','OccupationM','IncomeM','Height',
                        'Weight','Reprocate','Miscarriages','Abortions',
                        'Medvits','Medvitexplain','Gynosurgeries','LivingkidsM','Boys','Girls',
                        'MedvitsM','MedvitexplainM','Urosurgeries','Breastfeeding','Method',
                        'Prevmethod','Methoddate','Whychart','Nextpreg','NextpregM','Spousesame',
                        'SpousesameM','Timeattemptpreg','Group','ReproductiveCategory',
                        'TotalHighPostPeak','EstimatedDayofOvulation',
                        'FirstDayofHigh','LengthofLutealPhase'
                        ,'TotalNumberofHighDays','TotalNumberofPeakDays','TotalDaysofFertility','TotalFertilityFormula',
                        'CycleWithPeakorNot','MensesScoreDayOne','MensesScoreDayTwo','MensesScoreDayThree']
df = df.drop(columns=unnecessary_columns, errors='ignore')



# Select features and target
#filtered_df = df.drop_duplicates(subset='ClientID', keep='first')
filtered_df=df
filtered_df = filtered_df.replace(' ',-1) 
filtered_df.to_csv('modified_file.csv', index=False)  
features = [col for col in filtered_df.columns if (col not in unnecessary_columns and col!='ClientID') ]
cycle_length_target = "LengthofCycle"
menstruation_length_target = "LengthofMenses"


# Split the data into training and testing sets
X_cycle_train, X_cycle_test, y_cycle_train, y_cycle_test = train_test_split(filtered_df[features],
filtered_df[cycle_length_target], test_size=0.2, random_state=42)



# Create and train a linear regression model
model_cycle = LinearRegression()
#model_menstruation = LinearRegression()


model_cycle.fit(X_cycle_train, y_cycle_train)
#model_menstruation()
# Make predictions on the test set
y_cycle_prediction = model_cycle.predict(X_cycle_test)
#exporting the model

joblib.dump(model_cycle,'model/model.joblib')
# Compute the correct and incorrect result
'''correct = 0
incorrect = 0
total = 0
for actual, predicted in zip(y_cycle_test, y_cycle_prediction):
    total += 1
    if abs(actual-predicted) <=0:
        correct += 1
    else:
        incorrect += 1

# Print results
print(f"Results for model {type(model_cycle).__name__}")
print(f"total {total}")
print(f"Correct: {correct}")
print(f"Incorrect: {incorrect}")
print(f"Accuracy: {100 * correct / total:.2f}%")'''
# new_data= pd.DataFrame({

# 'CycleNumber':request.args['CycleNumber']
# ,'LengthofCycle':request.args['LengthofCycle']
# ,'MeanCycleLength':request.args['MeanCycleLength']
# ,'LengthofMenses':request.args['LengthofMenses']
# ,'MeanMensesLength':request.args['MeanMensesLength']
# ,'Age':request.args['Age']
# ,'AgeM':request.args['AgeM']
# ,'Numberpreg':request.args['Numberpreg']
# ,'Livingkids':request.args['Livingkids']
# ,'BMI':request.args['BMI']
# })
#initialize the trained model
#trained_model = LinearRegression()

#training the model on the dataset
#trained_model.fit(X_cycle_train, y_cycle_train)
#predicting
#prediction= trained_model.predict(new_data)
#result={'result':prediction}
