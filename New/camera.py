import picamera
#from picamera import PiCamera, Color
from time import sleep

camera = picamera.PiCamera() 

camera.start_preview()
sleep(30)
camera.stop_preview()
