/*
 *  HackDFW
 *
 *  Author: Eric Trexel
 *  Date: 3/1/15
 *
 *  This software polls three sensors for the bottom of a shoe to evaluate 
 *  stride characteristics. This data is then sent over bluetooth to
 *  the companion iOS app which processes the sent values and determines
 *  the type of stride. Only one leg worth of sensors is currently supported.
 *
 *  This software is written using the ReadBearLab BLE Shield.
 *
 */

//includes for BLE module
#include <SPI.h>
#include <boards.h>
#include <RBL_nRF8001.h>
#include <services.h>

//defines for sensor map
#define LEFT 1
#define RIGHT 2
#define HEEL 3

//buffer to send data over bluetooth
unsigned char buf[6];
//count of cycles between sensor actuation
int delta = 0;

//arduino pins for each sensor
int heelPin = A0;
int leftPin = A1;
int rightPin = A2;

//variables for read values
int heelValue = 0;
int leftValue = 0;
int rightValue = 0;

//booleans to determine if a strike has occurred
boolean stepStart = false;
boolean firstStrike = false;
boolean secondStrike = false;
boolean heelStrike = false;
boolean leftStrike = false;
boolean leftLift = false;
boolean rightStrike = false;
boolean rightLift = false;
boolean firstLift = false;
boolean secondLift = false;

//setup bluetooth/serial communication
void setup() {
  ble_set_name("hackdfw");
  ble_begin();
  Serial.begin(57600); 
}

//main loop
void loop() {
  //read all values
  heelValue = digitalRead(heelPin);
  leftValue = digitalRead(leftPin);
  rightValue = digitalRead(rightPin);

  //if we are between first and second strike add to cycle count
  if(firstStrike && !secondStrike) {
    delta++;
  }

  //if we are between first and second lift add to cycle count
  if(firstLift && !secondLift) {
    delta++;
  }

  //register heel strike if no heel strike this stride and above threshold
  if(!heelValue && !heelStrike) {
    if(!secondStrike && firstStrike) {
      buf[1] = HEEL;
      secondStrike = true;
      delta = map(delta, 0, 32767, 0, 255);
      buf[2] = delta;
      delta = 0;
    }
    if(!firstStrike) {
      buf[0] = HEEL;
      firstStrike = true;
    }
    heelStrike = true;
  }

  //register left strike if no left strike this stride and above threshold
  if(!leftValue && !leftStrike) {
    if(!secondStrike && firstStrike) {
      buf[1] = LEFT;
      secondStrike = true;
      delta = map(delta, 0, 32767, 0, 255);
      buf[2] = delta;
      delta = 0;
    }
    if(!firstStrike) {
      buf[0] = LEFT;
      firstStrike = true;
    }
    leftStrike = true;
  }

  //register right strike if no right strike this stride and above threshold
  if(!rightValue && !rightStrike) {
    if(!secondStrike && firstStrike) {
      buf[1] = RIGHT;
      secondStrike = true;
      delta = map(delta, 0, 32767, 0, 255);
      buf[2] = delta;
      delta = 0;
    }
    if(!firstStrike) {
      buf[0] = RIGHT;
      firstStrike = true;
    }
    rightStrike = true;
  }

  //register left lift if first and second strikes are triggered
  if(leftValue && secondStrike && !leftLift && leftStrike && rightStrike) {
    if(!secondLift && firstLift) {
      buf[4] = LEFT;
      secondLift = true;
      delta = map(delta, 0, 32767, 0, 255);
      buf[5] = delta;
    }
    if(!firstLift) {
      buf[3] = LEFT;
      firstLift = true;
    }
    leftLift = true;
  }

  //register right lift if first and second strikes are triggered
  if(rightValue && secondStrike && !rightLift && leftStrike && rightStrike) {
    if(!secondLift && firstLift) {
      buf[4] = RIGHT;
      secondLift = true;
      delta = map(delta, 0, 32767, 0, 255);
      buf[5] = delta;
    }
    if(!firstLift) {
      buf[3] = RIGHT;
      firstLift = true;
    }
    rightLift = true;
  }

  //if all sensors are below threshold and a step is recorded reset all values
  if(heelValue && leftValue && rightValue && secondLift){
    heelStrike = false;
    leftStrike = false;
    rightStrike = false;
    leftLift = false;
    rightLift = false;
    firstStrike = false;
    secondStrike = false;
    firstLift = false;
    secondLift = false;
    if(ble_connected()) {
      for(int i=0; i<6; i++) {
        ble_write(buf[i]);
      }
    }
    delta = 0;
    buf[0] = 0;
    buf[1] = 0;
    buf[2] = 0;
    buf[3] = 0;
    buf[4] = 0;
    buf[5] = 0;
  }

  //do bluetooth stuff
  ble_do_events();
}
