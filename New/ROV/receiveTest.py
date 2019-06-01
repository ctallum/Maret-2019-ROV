#Imports
from flask import Flask, render_template, Response, request, url_for
#import picamera
from camera_pi import Camera
#Test camera data for computer

### PI STUFF
### Pi camera
#from time import sleep



###### CONSTANTS ######
NUM_MOTORS = 5

#Declare flask app
app = Flask(__name__)


#Main Page
@app.route('/')
def index():
        return render_template('index.html')

def gen(camera):
        while True:
                frame = camera.get_frame()
                yield (b'--frame\r\n' b'content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')
#Video streaming route
@app.route('/videoFeed')
def videoFeed():
        return Response(gen(Camera()),mimetype='multipart/x-mixed-replace; boundary=frame')

#Read in motor data
@app.route('/motorData')
def motorData():
        #OLD app.py STUFF
        '''
        for i in range(0, NUM_MOTORS):
                motor = "motor" + str(i)
                motorVal = request.args.get(motor)
                #motorVal = int(motorVal)
                print(motorVal)
       '''
        motor = "motor"
        testData = request.args.get("motor")
        testData += request.args.get("motorVal2")
        testPrint= str(testData)
        return render_template('receiveTestTemplate.html', testPrint=testPrint)


if __name__ == '__main__':
        app.run(host='0.0.0.0', port=5000, debug=True, threaded=True)
