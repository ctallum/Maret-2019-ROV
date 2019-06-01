from nanpy import (ArduinoApi, SerialManager)
from time import sleep

ledPin = [2,3,4,5,6,7]

try:
    connection = SerialManager()
    ard = ArduinoApi(connection = connection)
except:
    print("FAILED TO CONNECT")

for i in ledPin:
    ard.pinMode(i, ard.OUTPUT)


try:
    for i in (ledPin):
        print(i)
        ard.analogWrite(i, 255)
  




        
except:
    print("not working arduino")


