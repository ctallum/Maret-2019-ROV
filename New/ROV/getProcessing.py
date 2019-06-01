#Imports
from flask import Flask, render_template, Response, request, url_for

###### CONSTANTS ######

#Declare flask app
app = Flask(__name__)

#Main Page
@app.route('/')
def index():
    motorVal = request.args.get(motor, 0, type=int)
    #motorVal = int(motorVal)
    print(motorVal)

if __name__ == '__main__':
        app.run(host='0.0.0.0', port=5000, debug=False, threaded=True)
