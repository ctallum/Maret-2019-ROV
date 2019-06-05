# Maret 2019 ROV
In this Git Hub, I will try to provide all the needed code, 3d model files, and instructions needed to either build or fix the 2019 ROV. 

## Code
### Setting up the code:
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

On the surface computer, you will need the folder titled "Poolside". This folder contains all the code that runs on the surface. I will also include this folder with all its contents in the GitHub. The "poolside" code runs in a program called Processing, so also download that. In Processing, you will need to add the following libraries: G4P, Game Control Plus, and HTTP Requests for Processing. Adding these libraries is really easy. In processing, "Open Library" --> "Add library...". From here you can search up each library and add them. I also believe that you need to install the Xbox controller drivers. 
- https://processing.org/
- https://github.com/360Controller/360Controller/

### Running the ROV
 
The first step in running the ROV is to run the code on the Pi. Since the Pi is on the craft, you must run the code remotely. This is done via ssh. On a windows machine, one could use a program such as Putty to ssh to the Pi, however, on a mac, you can use the built in Terminal. 

First, establish connection with the Pi. 
```bash
ssh pi@169.254.175.59
```
169.254.175.59 is the static IP address of the Pi we have used in years past. However, if the physical Pi changes, the IP may also change (I think). You can find the IP address of the Pi by typing "ifconfig" into the Pi terminal. You can also change the physical IP adress of the Pi by edditing the dhcpcd.conf file (see the link below). 
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

As the file runs, the Terminal screen will display what is currently going on. It should say something along the lines of setting up a nanpy connection and running a flask server on the ip address. The Terminal screen is also the Debugger window, so if anything goes wrong, it will tell you. Keep this window up. 

After you have run the Pi code, you need to run the Poolside code. To do this, open the PoolSide folder and open the file titled PoolSide.pde. This file should open up in Processing. In processing, click the "Run" button. This should bring up a small window that gives the readings of all the motor values. 

To get the video streaming site up, go to your web browser and type in:
http://169.254.175.59:5000/ 
This should open up a webpage with the live video stream. 

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

## How to wire the ROV


