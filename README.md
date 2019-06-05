# Maret 2019 ROV
In this Git Hub, I will try to provide all the needed code, 3d model files, and instructions needed to either build or fix the 2019 ROV. 

## Code
### Setting up the Rasperry Pi 

To set up the Rasperry pi, first make sure the Pi has a static IP adress. If it does, skip ahead. If it doesn not, you will not be able to ssh into the Pi. To set a static IP address, first type the following into the Pi terminal.
```bash
sudo nano /etc/dhcpcd.conf
```
At the bottom of the config file, type the following:
```bash
interface eth0
static ip_address=169.254.175.59/24
```
This should create a static IP address on the Pi. (The IP adress doesn't need to be the one written above. If you make your own, just make sure to change the code in the Poolside.pde to reflect this). You can check everything works by typing the following into the terminal.
```bash
ifconfig
```
Under eth0, it should report the static IP.

The next step is to make sure the Pi has all the needed python libraries. You will need Nanpy and Flask. To install Nanpy, type the follwing into the terminal.
```bash
sudo pip3 install nanpy
```
To install Flask, type the following into the terminal. 
```bash
sudo pip3 install flask
```
There are many installation guides online (including the one on Flask's website) that involve the creation of virtual enviorments for python. This is not nescessary. Disreagard these guides and just install flask with the above method. 

To finally get the code up and running, on the Raspberry Pi desktop, you will need the folder titled "New". This folder contains all the Pi code to get the craft running. I will include this folder with all its contents in the GitHub. All the code is written to be run in python. 

### Setting up the Surface Computer
On the surface computer, you will need the folder titled "Poolside". This folder contains all the code that runs on the surface. I will also include this folder with all its contents in the GitHub. The "poolside" code runs in a program called Processing, so also download that. In Processing, you will need to add the following libraries: G4P, Game Control Plus, and HTTP Requests for Processing. Adding these libraries is really easy. In processing, "Open Library" --> "Add library...". From here you can search up each library and add them. You need to install the Xbox controller drivers. 
- https://processing.org/
- https://www.techspot.com/drivers/driver/file/information/15363/

### Setting up the Arduino
Contrary to popular beleif (or at least what we thought we knew) you do indeed need to set up Nanpy code on the Arduino. You can follow the guide below for full instructions on installing the nanpy code on the Arduino. 
- https://nanpy.github.io/

Alternativly, you could plug the current arduino into a laptop, open up the Arduino software, save the contents as an ide. and then copy the code onto another Arduino. (I haven't tried this in person, but I think it would work, and it would save you a bit of time).

# Running the ROV

First, make sure everything is properly connected. In the ROV, the camera should be plugged in fully (and beleive me, it is easier to check now than it is to change it later once the dome is on). On the surface, the ethernet and Xbox controller should be plugged into the surface laptop. The tether should be plugged into 12 volts.
 
The first step in running the ROV is to run the code on the Pi. Since the Pi is on the craft, you must run the code remotely. This is done via ssh. On a windows machine, one could use a program such as Putty to ssh to the Pi, however, on a Mac, you can use the built in Terminal. 

First, establish connection with the Pi. 
```bash
ssh pi@169.254.38.217
```
169.254.38.217 is the static IP address of the Pi we have used in years past. However, if the physical Pi changes or you change the software, the IP may be different. You can always find the IP address of the Pi by typing "ifconfig" into the Pi terminal. You can also change the physical IP adress of the Pi by edditing the dhcpcd.conf file (see the link below). (Also see above).
- https://www.modmypi.com/blog/how-to-give-your-raspberry-pi-a-static-ip-address-update

Once you have connected to the Pi, it will request a password. On a new Pi, the default password is "raspberry". However, if Chris L. is the one who set it up, the password will probably be "hi".

Once you are into the Pi, you need to access the run file.
```bash
cd Desktop/New/ROV
```

This will put you inside the ROV subfile within the New folder. Inside this folder is the file App.py. This is the main code which runs the ROV. Run this file.
```bash
python3 App.py
```

As the file runs, the Terminal screen will display what is currently going on. It should say something along the lines of setting up a nanpy connection and running a flask server on the ip address "0.0.0.0:5000". (Don't worry that it says 0.0.0.0 and not the IP adress of the Pi, this if fine. 0.0.0.0 is the local adress of the Pi which is the IP you set). The Terminal screen is also the Debugger window, so if anything goes wrong, it will tell you. Keep this window up. 

After you have run the Pi code, you need to run the Poolside code. To do this, open the PoolSide folder and open the file titled PoolSide.pde. This file should open up in Processing. In processing, click the "Run" button. This should bring up a small window that gives the readings of all the motor values. 

To get the video streaming site up, go to your web browser and type in:
```bash
http://169.254.175.59:5000
```
This should open up a webpage with the live video stream. 

### Tips and other helpful bits
- When trying to ssh into the Pi, it may not be immediate. Just spam the ssh request until it goes through.
- If you you are testing the Pi out (and the Pi is not in the tube), you can run the program manually without ssh. To do that, hook up a monitor and keyboard/mouse to the pi. You can edit the code by oppening the App.py file in the python scrip editor, but you cannot run it like you might be used to doing with any other python program. If you run it from the python scrip editor, you cannot stop the program from running without rebooting the Pi. If you want to run it to test it out (or test out any changes you made to it), you have to run it from the terminal. 
```bash
cd Desktop/New/ROV
python3 App.py
```
- Always run the poolside code after the Pi code is running. 
- I don't think it is nescessary to runn the poolside code to access the live video stream, but that is the only thing you can do. 

# Electronics

## Componenents
- Rasperry Pi [buy link](https://www.amazon.com/ELEMENT-Element14-Raspberry-Pi-Motherboard/dp/B07BDR5PDW/ref=sr_1_4?crid=31RQ6DEWEKAVE&keywords=rasberry+pie+3+b%2B&qid=1559358411&s=gateway&sprefix=rasperry+%2Caps%2C137&sr=8-4)
- Arduino Mega [buy link](https://www.amazon.com/Elegoo-EL-CB-003-ATmega2560-ATMEGA16U2-Arduino/dp/B01H4ZLZLQ/ref=sr_1_1_sspa?keywords=arduino+mega&qid=1559358446&s=gateway&sr=8-1-spons&psc=1)
- Pololu mc33926 motor drivers (x6) [buy link](https://www.pololu.com/product/1212)
- 12v to 5v buck step down converter (x2) [buy link](https://www.amazon.com/DROK-Electric-Converter-Step-down-Regulator/dp/B00C63TLCC?ref_=fsclp_pl_dp_2)
- dsn-vc288 Volt Amp Meter [buy link](https://www.amazon.com/McIgIcM-Digital-Voltmeter-Ammeter-10ADetector/dp/B06XR2XKNT/ref=sr_1_1?keywords=volt+amp+display&qid=1559358294&s=gateway&sr=8-1-spell)
- Screw terminals [buy link](https://www.amazon.com/Eowpower-Position-Terminal-Insulated-Barrier/dp/B06XKFCTSM/ref=sr_1_4?keywords=screw+terminal+8&qid=1559358236&s=electronics&sr=1-4)

## What they do
Rasperry Pi
- This is the brains of the ROV. It handles all the inputs from the surface. The video feed also runs through the Pi. 

Arduino 
- The Arduino is what is considered a "slave" to the Rasperry Pi. It only serves as an extension of the Pi. Since the Pi has limited output pins, and it needs to control 6 motor controllers and a few servos, it uses the Arduino to send out the signals. The Pi sends instructions to the arduino such as "set pin 30 to HIGH" or "set pin 6 pwm to 125". The  Arduino follows these instructions. In total, the Arduino manages 8-9 digital outputs (on or off) depending on how many servos we are running, and 6 analog outputs (pwm 0-255).

Pololu Motor Drivers
- We are using 6 motor drivers, one for each pilge pump motor. You can think of these motor drivers as a gate. They control how much voltage goes to the motors, and, as a result, their speed. They take inputs from the arduino which indicates the speed of the motors and in which direction the motors spin. 

12v to 5v Converters
- The different electronics on board require different amounts of voltage to run, some 12v and some 5v. The craft is supplied 12 volts from the surface (through the tether). The converters simply drop the 12 volts down to 5 volts for the electronic that need it. 

Screw Terminals
- Electronically, they serve no purpose. However, they make wiring a lot easier. One of the Terminals is for 12v and the other 5v. The rows alternate positive and ground. 

Volt/Amp meter
- this gives a vidual indicator of how much voltage and amperage is running though the system. The voltage reading should always give 12.00V (or close to it). The amperage reading depends on how fast the motors are running and if the servos are currently being used. Idealy, the amperage should stay way below 20A.

## How to wire the ROV
### Power management

The Rasperry Pi should always run on 5V. Typically, we give it its own 12-5V step down coverter, hooked right up to the 12V mains. This should give it the cleanest 5V power. We currently run the power though the GPIO pins on the Pi. In our circumstance, this is the easiest way to give power to the Pi. Alternatively, you could power the Pi though the micro USB port. 

We have the Arduino running on 12V hooked up to the 12V bus. There are many different ways to power the Arduino. In a pinch, the Arduino can be powered directly by the USB data cable, under heavy load, this is not sufficient. You can also run the Arduino with 5V by plugging the 5V into the 5V pin and the ground into the ground pin. This should work perfectly fine in almost all cases. Lastly, you can power the Arduino the way we do it. You can power the Arduino through the "vin" pin with any voltage between 6 and 12V. (The ground line still goes to ground). We run 12 volts into the "vin" pin. We did this in the off chance that one of our 12-5V converters breaks. If that happens, the Arduino would fail. However, there will amost always be steady 12V power, and even if this 12V is not perfect, we have a bit of leeway. 

The motor drivers are the most complicated it terms of power wiring. They require both 12V and 5V. The 12V is reserved for the motors, and the 5V is for the chip that does all the logic. On the proto board to which the six motor drives are soldered, there are is a 5V and ground wire set attached. These should go to the 5V bus. On top of each motor driver, there are four screw terminals. Two of these are where the motors connect, the other two are where you need to run 12V. On each motor driver, there is a set of wires. One goes to 12V, the other ground. Use the 12V bus. 

All the servos run off of 5V. The red and black lines of the servo should alwasy go to the 5V bus. 

The volt/amp meter is rather confusing to wire in. I will include an image below. To wire the volt/amp meter, the small black and red wires should go directly to the power lines in the tether. The small yellow wire should also go to the postive line on the tether. The big black line of the meter should also go to the ground line in the tether. The 12V power bus line should go to the positive line on the teter. Here is where it gets weird, connect the ground line of the 12V power bus to the big red line of the meter. This may look like cross-wiring, but it is fine. Just follow the diagram. 
![diagram](http://diyprojects.eu/wp-content/uploads/2019/04/wiring-DSN-VC288-10A-100V-digital-volt-ammeter-thick-black-red-thin-black-red-yellow-wires.jpg)

### Data management

Connect the ethernet in the tether to the ethernet port of the Rasperry Pi

Connect the Rasperry Pi to the Arduino via a USB type A to USB type B cable. This cable comes with the Arduino in the box.

Connect the Arduino to the motor drivers via the two rainbow colored ribbon cables. One controls the speed of the motors, and one controlls the direction of the motors. Follow the diagram below. Idealy, there would be three cables, the last one being data feedback; however, we have never set this up in the code, and it is not particularly helpful. 

[insert diagram]


# Current Issues / Things to do next year
### Mechanics
- Shorten the wires that go to the motors
- Create a new camera mount that attaches to the electronics tray, not the front flange. Make sure that you can access the micro-SD card with the mount. 
- Add the front and back circular supports for the electronics tray

### Code
- For some reason, there is one motor that runs slower than the others. It doesn't spin under low voltage, and runs slower than others at heigher voltages. My guess that it has to do with motor controller. Maybe replace it.
- The right and left strafe are backwards. On the controller, when you move the left joystick to the left, the rov shifts right, and vice versa. This is because I rotated the motor controller protoboard 180 degrees. The drivers that used to run the left motors now run the right ones, and vice versa. To fix the issue, go into the App.py file and change around the pin order in the lists. 
- One of the motors doesn't change direction. I think this is again due to issues in the code with the pins. 

