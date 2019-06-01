# Maret-2019-ROV
In this Git Hub, I will try to provide all the needed code, 3d model files, and instructions needed to either build or fix the 2019 ROV. 

## Contents
I will include the following:

Code
- Rasperry Pi code
- Surface laptop code
- Intructions on how to set up the code
- How to run the ROV

3d models
- Deck (both stl and pdf for printing/laser cut)
- Lateral Motor Mounts (right side)
- Lateral Motor Mounts (Left side)
- Vertical Motor Mounts (Left side)
- Vertical Motor Mounts (Right side)
- Brackets for the tube
- Skids (both stl and pdf for printing/laser cut)
- Full assembly (.f3d file format)

Other
- Full technical report
- How the internal electronics of the ROV work

## Code
### Setting up the code:

On the Raspberry Pi desktop, you will need the folder titled "New". This folder contains all the Pi code to get the craft running. I will include this folder with all its contents in the GitHub. All the code is written to be run in python. In addition to the code, the Raspberry Pi needs to also have the following libraries installed: Flask and Nanpy. Both libraries should be able to be installed via the pi terminal screen. Nanpy is pretty easy to install, Flask is pretty confusing. I will include a few links below about the process. 
- http://flask.pocoo.org/docs/1.0/installation/
- https://nanpy.github.io/

On the surface computer, you will need the folder titled "Poolside". This folder contains all the code that runs on the surface. I will also include this folder with all its contents in the GitHub. The "poolside" code runs in a program called Processing. In processing, you will need to add the following libraries: G4P, Game Control Plus, and HTTP Requests for Processing. Adding these libraries is really easy. In processing, "Open Library" --> "Add library...". From here you can search up each required library and add them. I also believe that you need to install the Xbox controller drivers. 
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

