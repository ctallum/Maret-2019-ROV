# @auth: Chris Laporte
# @date: 9-28-2017
# @version: 2.0

#Imports
from flask import Flask, render_template, Response, request, url_for
#Test camera data for computer
### from camera import Camera
import time as t

### PI STUFF
### Pi camera
from camera_pi import Camera
from nanpy import (ArduinoApi, SerialManager, Servo)
import os
import sys



###### CONSTANTS ######
NUM_MOTORS = 6
#Pins changed to be fixed
thrustPins = [7,6,5,4,3,2] #Order: Fr L, Fr R, Ba R, Ba L, Vert1, Vert2
dirPins = [32,30,28,26,24,22]

clawPin = 8 
CLAW_MIN = 103
CLAW_MAX = 51

wristPin = 9

camPin = 11


#Declare flask app
app = Flask(__name__)

try:
        connection = SerialManager()
        print(str(connection))

        arduino = ArduinoApi(connection = connection)
        claw = Servo(clawPin)
        wrist = Servo(wristPin)
        cam = Servo(camPin)
        
except:
        print("Failed to connect to Arduino")

for i in range(0, len(thrustPins)):
        arduino.pinMode(thrustPins[i], arduino.OUTPUT)
        arduino.pinMode(dirPins[i], arduino.OUTPUT)

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

#Read in motor data and write to Arduino
@app.route('/motorData')
def motorData():
        thrustValues = []
        dirValues = []
        for i in range(0, NUM_MOTORS):
                motor = "motor" + str(i)
                motorVal = request.args.get(motor)
                motorVal = int(motorVal)                
                if motorVal < 0:
                        dirValues.append(0)
                        thrustValues.append(0 - motorVal)
                else:
                        dirValues.append(1)
                        thrustValues.append(motorVal)
        print(thrustValues)
                

        try:

                #t.sleep(1)
                for i in range(0, NUM_MOTORS):
                        arduino.analogWrite(thrustPins[i], thrustValues[i])
                        arduino.digitalWrite(dirPins[i], dirValues[i])
        except:
                print("MOTORS NOT WORKING: ")
                print(thrustValues)
                #os.execl(sys.executable, sys.executable, *sys.argv)
                for i in range(0, NUM_MOTORS + 1):
                        arduino.analogWrite(thrustPins[i], 0)


        return ""


#Read in claw data and write to Arduino
@app.route('/clawData')
def clawData():

        

        try:
                wristName = "wristValue"
                wristValue = request.args.get(wristName)
                print(wristValue)
                wrist.write(wristValue)
        except:
                print("RIP")

        
        
        try:
                clawName = "clawValue"
                clawValue = request.args.get(clawName)
                #type(clawValue)
                #clawValue = int(clawValue)
                #try:
                print(clawValue)
                claw.write(clawValue)
        except:
                print("hello chris")
                '''
                print("CLAW NOT WORKING: ")
                print(str(clawValue))
                claw.write(CLAW_MAX)
                '''
        return ""
"""     

try:
	while True:
		for i in range(0, NUM_MOTORS):
            arduino.analogWrite(motorPin[i], thrustValues[i])

except:
    for i in range(0, NUM_MOTORS):
        arduino.analogWrite(motorPin[i], 0)
"""
if __name__ == '__main__':
        app.run(host='169.254.175.59', port=5000, debug=True, threaded=True)

