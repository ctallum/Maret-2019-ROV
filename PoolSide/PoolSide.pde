/*
 * Processing code to take inputs and send them
 * over HTTP request to a server on the Rasp Pi
 *
 * @auth: Chris Laporte
 * @date: 4/10/18
 * @version: 2.56
 */

/////////////////UPDATE WITH CONTROLLER ADDING BUTTONS FOR CAMERA CONTROL

// IMPORTS
import http.requests.*; //HTTP library
import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;



// Globals // 
ControlIO control; //Initializes the control library
ControlDevice xbox; //The control device

//CONSTANTS FOR TRIM
static float BACK_RIGHT_TRIM = 1;
static float BACK_LEFT_TRIM = 1;
static float FRONT_RIGHT_TRIM = 1;
static float FRONT_LEFT_TRIM = 1;
static float VERTICAL_R_TRIM = .9;
static float VERTICAL_L_TRIM = 1;


// Declare controller values
float leftStickX, leftStickY;
float rightStickX, rightStickY;
float leftTrigger, rightTrigger;
boolean leftBumper, rightBumper;


//Declare number of motors
int NUM_MOTORS = 6;
int NUM_HORIZ_MOTORS = 4;
int NUM_CLAW_STUFFS = 2;



//Create empty lists for current and previous motor values
int[] thrustValues; //Motor Thrust Values
int[] previousValues; //Old Motor Thrust Values



//Create the maxumum and minimum values for the claw
int CLAW_MIN = 100;
int CLAW_MAX = 50;



//Create the strating angle of the Swivil Cam and previous angle for swivil cam
int[] camAngles = {30, 60, 90, 120, 150, 180};
int camValue = 0;
int preCam = camValue;



//Create the current and previous claw values
int[] clawValues;
int wristValue;
int[] previousCValues;



//Create the pieces of the strings to send the data(URL and values)
String SERVER_PATH = "http://169.254.175.59:5000/";   //OLD IP: 169.254.226.122:5000
String MOTOR_PATH = "motorData?";
String CLAW_PATH = "clawData?";
String CAM_PATH = "camData?";
String camName = "swiValue=";
String[] varNames = {"motor0=", "motor1=", "motor2=", "motor3=", "motor4=", "motor5="};
//String clawName = "clawValue=";
String[] clawNames = {"clawValue=", "wristValue="};



//Create the value so that the single button claw and wrist works and does not trigger repeatedly while button is pressed
boolean preBumperPressed = false;
boolean preRBumperPressed = false;
boolean preStart = false;
boolean preSelect = false;


//Create values to store url
String sendString;
GetRequest get;



//Run once on startu[ of the program
void setup() {
  //set up the variables
  thrustValues = new int[NUM_MOTORS];
  previousValues = new int[NUM_MOTORS];
  //clawValue = CLAW_MAX;
  clawValues = new int[NUM_CLAW_STUFFS];
  clawValues[0] = CLAW_MAX;
  clawValues[1] = 10;
  previousCValues = new int[NUM_CLAW_STUFFS];
  //wristValue = 0;
  //previousClaw = clawValue;
  sendString = SERVER_PATH;



  //Create the window size
  get = new GetRequest(SERVER_PATH);
  size(600, 600);



  control = ControlIO.getInstance(this); // Initialize the ControlIO...idk what this really does
  xbox = control.getMatchedDevice("ROVConfig"); // Load the config file



  // make sure there is an xbox controller
  if (xbox == null) {
    
    println("Device not configured!");
    System.exit(-1);
    
  }
  
}



//Main body of program
void draw() {

  //create the window displaying the values
  background(0);
  stroke(255);
  parseControlValues();
  text("Back Right: " + str(thrustValues[0]), 25, 25);
  text("Back Left: " + str(thrustValues[1]), 25, 50);
  text("Front Right: " + str(thrustValues[2]), 25, 75);
  text("Front Left: " + str(thrustValues[3]), 25, 100);
  text("Vertical L: " + str(thrustValues[4]), 25, 125);
  text("Vertical R: " + str(thrustValues[5]), 25, 150);
  text("Claw: " + str(clawValues[0]), 25, 175);
  text("Wrist: " + str(clawValues[1]), 25, 200);

  // Only sends data if the data is different. More efficient
  for (int i = 0; i < NUM_MOTORS; i++) {

    if (thrustValues[i] != previousValues[i]) {
      
      sendString = sendString + MOTOR_PATH;

      for (int j = 0; j < NUM_MOTORS; j++) {
        
        sendString = sendString + varNames[j] + str(thrustValues[j]) + "&";
        
      }

      //send motor values
      get = new GetRequest(sendString);
      get.send();

      for (int k = i; k < NUM_MOTORS; k++) {
        
        previousValues[k] = thrustValues[k];
        
      }

      sendString = SERVER_PATH;
      break;
      
    }
    
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////  
  /*
  //only send if claw value is different and send
  if (clawValue != previousClaw) {
    
    sendString = SERVER_PATH + CLAW_PATH + clawName + str(clawValue);
    previousClaw = clawValue;

    get = new GetRequest(sendString);
    get.send();

    sendString = SERVER_PATH;
    
  }
  */
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  
  /*
  //set Swivil Cam Angle only send if defferent
  if (camValue != preCam) {
    
    sendString = SERVER_PATH + CAM_PATH + camName + str(camAngles[camValue]);
    preCam = camValue;
    
    get = new GetRequest(sendString);
    get.send();
    
    sendString = SERVER_PATH;

  }
  */
  
  /////////////////////////////////////////////////////////////////////////////////////////////////////

  //set wrist and claw only sends if values are different
  
  for (int i = 0; i < NUM_CLAW_STUFFS; i++) {
   
   if (clawValues[i] != previousCValues[i]) {
     
     sendString = sendString + CLAW_PATH;
   
     for (int j = 0; j < NUM_CLAW_STUFFS; j++) {
     
       sendString = sendString + clawNames[j] + str(clawValues[j]) + "&";
   
     }
   
   //send claw values
     get = new GetRequest(sendString);
     get.send();
   
     for (int k = i; k < NUM_CLAW_STUFFS; k++) {
     
       previousCValues[k] = clawValues[k];
   
     }
   
     sendString = SERVER_PATH;
     break;
   
   }
   
 }
  
}



    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void parseControlValues() {
  getControlValues();
  float thrustConst = 0;
  float rotatConst = 0;

  if (getMag(leftStickX, leftStickY)+getMag(rightStickX, 0) > 0) {
    
    thrustConst = getMag(leftStickX, leftStickY)/(getMag(leftStickX, leftStickY)+getMag(rightStickX, 0));
    rotatConst = getMag(rightStickX, 0)/(getMag(leftStickX, leftStickY)+getMag(rightStickX, 0));
    
  }

  for (int i = 0; i < NUM_HORIZ_MOTORS; i++) {
    
    thrustValues[i] = int((thrustConst*getTranslation(leftStickX, leftStickY)[i])+(rotatConst*getRotation(rightStickX)[i]));
    thrustValues[i] = constrain(thrustValues[i], -255, 255);
    
  }
  thrustValues[NUM_MOTORS - 2] = int(rightTrigger - leftTrigger); //getAltitude(leftTrigger, rightTrigger);
  thrustValues[NUM_MOTORS - 2] = constrain(thrustValues[NUM_MOTORS - 2], int(-255*VERTICAL_L_TRIM), int(255*VERTICAL_L_TRIM));
  
  thrustValues[NUM_MOTORS - 1] = int(rightTrigger - leftTrigger); //getAltitude(leftTrigger, rightTrigger);
  thrustValues[NUM_MOTORS - 1] = constrain(thrustValues[NUM_MOTORS - 1], int(-255*VERTICAL_R_TRIM), int(255*VERTICAL_R_TRIM));

//Claw methods switch to correct one when time comes

  setClawSingle(leftBumper);
  preBumperPressed = leftBumper;
  setClawWrist(rightBumper);
  preRBumperPressed = rightBumper;
  
 //Camera method
  //setCam(start, select)
  //preStart = start;
  //preSelect = select;
  
  //-----------------------------------------------------------ADD METHOD FOR CHANGING CAMANGLE WITH BUTTONS WHEN TIME COMES-------------------------------------------
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void getControlValues() {

  leftStickX = xbox.getSlider("leftStickX").getValue();
  leftStickY = xbox.getSlider("leftStickY").getValue();
  rightStickX = xbox.getSlider("rightStickX").getValue();
  rightStickY = xbox.getSlider("rightStickY").getValue();
  leftTrigger = xbox.getSlider("leftTrigger").getValue();
  rightTrigger = xbox.getSlider("rightTrigger").getValue();
  leftBumper = xbox.getButton("leftBumper").pressed();
  rightBumper = xbox.getButton("rightBumper").pressed();
  
}

float[] getTranslation(float x, float y) {

  float mag = sqrt((x*x) + (y*y));
  if (mag > 255) {

    x *= (255/mag);
    y *= (255/mag);
    
  }

  x *= sqrt(2);
  y *= sqrt(2);
  float[] vals = new float[NUM_HORIZ_MOTORS];
  vals[0] = 0 - (x + y);
  vals[1] = x-y;
  vals[2] = vals[0];
  vals[3] = vals[1];

  //Mapping change for trim
    
  vals[0] = map(vals[0], -360.624, 360.624, (-255*BACK_RIGHT_TRIM), (255*BACK_RIGHT_TRIM));
  vals[1] = map(vals[1], -360.624, 360.624, (-255*BACK_LEFT_TRIM), (255*BACK_LEFT_TRIM));
  vals[2] = map(vals[2], -360.624, 360.624, (-255*FRONT_RIGHT_TRIM), (255*FRONT_RIGHT_TRIM));
  vals[3] = map(vals[3], -360.624, 360.624, (-255*FRONT_LEFT_TRIM), (255*FRONT_LEFT_TRIM));

  //println(x,y,vals[0],vals[1],vals[2],vals[3]);
  return vals;
  
}

int[] getRotation(float x) {

  int[] vals = new int[NUM_HORIZ_MOTORS];
  vals[0] = int(x);
  vals[1] = int(0 - x);
  vals[2] = vals[1];
  vals[3] = vals[0];

  for (int i = 0; i < NUM_HORIZ_MOTORS; i++) {
    
    vals[i] = constrain(vals[i], -255, 255);
    
  }

  return vals;
  
}

int getMag(float x, float y) {
  
  return int(sqrt((x*x) + (y*y)));
  
}

int getAltitude(float left, float right) {
  
  //left += 127.0;
  //right += 127.0;
  return int(right - left);
  
}


///////////////////////////////////////////////////////////////////////////////////
//Set claw off of a single button
void setClawSingle(boolean left) {

  //only changes once
  if (left != preBumperPressed) {

    //if pressed and it is one value make it the other
    if (left && clawValues[0] == CLAW_MIN) {

      clawValues[0] = CLAW_MAX;
      
    }

    //if pressed and it is the other value make it the first value
    else if (left && clawValues[0] == CLAW_MAX) {

      clawValues[0] =  CLAW_MIN;
      
    }
    
  }
  
}
///////////////////////////////////////////////////////////////////////////////////

//Set wrist off of a single button
 void setClawWrist(boolean right) {
 
 //only changes once
   if (right != preRBumperPressed) {
 
 //if pressed and it is one value make it the other
     if (right && clawValues[1] == 10) {
 
       clawValues[1] = 150;
 
     }  
 
 //if pressed and it is the other value make it the first value
     else if (right && clawValues[1] == 150) {
 
       clawValues[1] =  10;
 
     }
 
   }
 
 }
 
 
///////////////////////////////////////////////////////////////////////////////////

//Set camera off of two buttons
void setCam(boolean start, boolean select) {

  //increment up
  //only increment once
  if (start != preStart) {

    if (start) {

      camValue += 1;
      
      if (camValue > 5) {
       
        camValue = 0;
        
      }
      
    }
    
  }
  
  //inrement down
  //only increment once

  if (select != preSelect) {

    if (select) {

      camValue -= 1;
      
      if (camValue < 0) {
       
        camValue = 5;
        
      }
      
    }
    
  }
  
}

///////////////////////////////////////////////////////////////////////////////////
