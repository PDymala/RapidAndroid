/**
 5 min app. tilt your phone to magnify the pattern. Simpliest example- circular
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
float angle = 0;
int size = 15;


void setup() {
  fullScreen();
  background(0);
  stroke(255);
  noFill();

  context = getContext();
  manager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);
  sensor = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  manager.registerListener(gyroListener, sensor, SensorManager.SENSOR_DELAY_NORMAL);
}


public SensorEventListener gyroListener = new SensorEventListener() {
  public void onAccuracyChanged(Sensor sensor, int acc) {
  }

  public void onSensorChanged(SensorEvent event) {
    rx = event.values[0];
    ry = event.values[1];
    rz = event.values[2];
  }
};



void draw() {

  background(0);
  manager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
  if (manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER) != null) {
  }
  translate(width/2+size/2, height/2+size/2);

  for (int i = 0; i <  height/size; i++) {

    for (int j = 0; j < width/size; j++) {


      ellipse(j*size-width/2, i*size-height/2, size, size);
    }
  }

  rotate(atan2(rx, ry));
  for (int i = 0; i <  height/size; i++) {

    for (int j = 0; j < width/size; j++) {
      ellipse(j*size-width/2, i*size-height/2, size, size);
    }
  }
}
