from flask import Flask,request,jsonify

app=Flask(__name__)
@app.route('/api', methods=['GET'])
def helloworld():
    d={}
    d['Query']=str(request.args['Query'])
    return jsonify(d)
if __name__=='__main__':
    app.run(debug=True)