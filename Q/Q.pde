/**
 5 min app. tilt your phone to look around the cube
 @Tech Processing.org - Android
 @Author P.Dymala
 */

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;

Context context;
SensorManager manager;
Sensor sensor;

float rx, ry, rz;
float x,y,z;

void setup() {
  size(displayWidth, displayHeight, P3D);
  orientation(PORTRAIT);
  context = getContext();
  manager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);
  sensor = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  manager.registerListener(gyroListener, sensor, SensorManager.SENSOR_DELAY_NORMAL);
  textFont(createFont("SansSerif", displayDensity * 24));
  textAlign(CENTER, CENTER);
}

public SensorEventListener gyroListener = new SensorEventListener() {
  public void onAccuracyChanged(Sensor sensor, int acc) {
  }

  public void onSensorChanged(SensorEvent event) {
    rx = abs(event.values[0]);
    ry = abs(event.values[1]);
    rz = abs(event.values[2]);
    //print(rx + " " +ry + " " +rz);
  }
};

void draw() {
  background(0);
  manager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
  if (manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER) != null) {

    x = (int) map(rx, 0, 9.81, -90, 90);
    y = (int) map(ry, 0, 9.81, -90, 90);
    z = (int) map(rz, 0, 9.81, -90, 90);


    translate(width/2, height/2);
    stroke(0, 255, 0);
    strokeWeight(3);
    noFill();
    rotateX(radians(x));
    rotateY(radians(y));
    rotateZ(radians(z));
    box(200);
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
