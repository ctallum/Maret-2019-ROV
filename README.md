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
Setting up the code:

On the Raspberry Pi desktop, you will need the folder titled "New". This folder contains all the Pi code to get the craft running. I will include this folder with all its contents in the GitHub. All the code is written to be run in python. In addition to the code, the Raspberry Pi needs to also have the following libraries installed: Flask and Nanpy. Both libraries should be able to be installed via the pi terminal screen. Nanpy is pretty easy to install, Flask is pretty confusing. I will include a few links below about the process. 
- http://flask.pocoo.org/docs/1.0/installation/
- https://nanpy.github.io/

On the surface computer, you will need the folder titled "Poolside". This folder contains all the code that runs on the surface. I will also include this folder with all its contents in the GitHub. The "poolside" code runs in a program called Processing. In processing, you will need to add the following libraries: G4P, Game Control Plus, and HTTP Requests for Processing. Adding these libraries is really easy. In processing, "Open Library" --> "Add library...". From here you can search up each required library and add them. I also believe that you need to install the Xbox controller drivers. 
- https://github.com/360Controller/360Controller/

