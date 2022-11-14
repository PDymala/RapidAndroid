/**
 5 min app. tilt your phone play around with a bauncy ball
 @Tech Processing.org - Android
 @Author P.Dymala
 */

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;


//sensor and backend
Context context;
SensorManager manager;
Sensor sensor;
float rx, ry, rz;

//ball
float x = 0;
float y = 0;
float dimm = 50;


//physics
float gravityY = 0.3;
float gravityX = 0.3;
float speedY = 0;
float speedX = 0;
float airDrag = 0.03;

void setup() {
  context = getContext();
  manager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);
  sensor = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  manager.registerListener(gyroListener, sensor, SensorManager.SENSOR_DELAY_NORMAL);
  rectMode(CENTER);
  x = width/2;
  y= height/2;
}

public SensorEventListener gyroListener = new SensorEventListener() {
  public void onAccuracyChanged(Sensor sensor, int acc) {
  }

  public void onSensorChanged(SensorEvent event) {
    rx = event.values[0];
    ry = event.values[1];
    rz = event.values[2];


    if (rx > 10) {
      rx = 10;
    }
    if (ry > 10) {
      ry = 10;
    }
    if (rz > 10) {
      rz = 10;
    }
    if (rx < -10) {
      rx = -10;
    }
    if (ry < -10) {
      ry = -10;
    }
    if (rz < -10) {
      rz = -10;
    }
  }
};


void draw() {
  
  
  background(0);
  manager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
  if (manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER) != null) {

    //drawing ball
    fill(0, 255, 0);
    ellipse (x, y, dimm, dimm);


    //counting gravity vs accelometr
    gravityX = map(rx, -10, 10, 0.4, -0.4);
    gravityY = map(ry, -10, 10, -0.4, 0.4);

    y = y + speedY;

    // Add gravity to speed.
    speedY = speedY + gravityY;
    //airdrag
    if (speedY < 0) {
      speedY += airDrag;
    } else {
      speedY -= airDrag;
    }

    //bumping edges
    if (y > height-dimm/2 || y <= dimm/2) {
      speedY = speedY * -0.95;
      //y = height;
    }


    x = x + speedX;
    //airdrag
    if (speedX < 0) {
      speedX += airDrag;
    } else {
      speedX -= airDrag;
    }

    // Add gravity to speed.
    speedX = speedX + gravityX;

    //bumping edges
    if (x > width-dimm/2 || x <= dimm/2) {
      speedX = speedX * -0.95;
      //x = width;
    }
  } else {


    background(157);
    text("No acceloerermetr :( ", width/2, height/2);
    noLoop();
  }
}
public void onResume() {
  super.onResume();
  if (manager != null) {
    manager.registerListener(gyroListener, sensor, SensorManager.SENSOR_DELAY_GAME);
  }
}

public void onPause() {
  super.onPause();
  if (manager != null) {
    manager.unregisterListener(gyroListener);
  }
}
