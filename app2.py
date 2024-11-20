from flask import Flask,jsonify,request
#from tensorflow.keras.models import load_model

app=Flask(__name__)


ai_model=load_model('model/model.joblib')
@app.route("/api",methods=["GET"])
def api():
    """new_data={
    'CycleNumber':request.args['CycleNumber']
 ,'LengthofCycle':request.args['LengthofCycle']
 ,'MeanCycleLength':request.args['MeanCycleLength']
 ,'LengthofMenses':request.args['LengthofMenses']
 ,'MeanMensesLength':request.args['MeanMensesLength']
 ,'Age':request.args['Age']
 ,'AgeM':request.args['AgeM']
 ,'Numberpreg':request.args['Numberpreg']
 ,'Livingkids':request.args['Livingkids']
 ,'BMI':request.args['BMI']
    }"""
    new_data=request.args['data']
    predictions=ai_model.predict(new_data)
    prediction=prediction[0]
    return jsonify({'prediction':prediction})

if __name__ == '__main__':
    app.run(debug=True)
