#Imports
from flask import Flask, render_template, Response, request, url_for

###### CONSTANTS ######

#Declare flask app
app = Flask(__name__)
number = 0
#Main Page
@app.route('/')
def index():
    global number
    number += 1
    return render_template('get_data.html', number=number)

@app.route('/subpage')

    #motorVal = request.args.get(motor)
    #print(motorVal)
if __name__ == '__main__':
        app.run(host='0.0.0.0', port=5000, debug=True, threaded=True)
