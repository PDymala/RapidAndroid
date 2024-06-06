import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import processing.core.PImage;
import java.util.ArrayList;
import java.util.Iterator;

Context context;
SensorManager manager;
Sensor sensor;
float rx, ry, rz;

float x, y;
float dimm = 130;

float gravityY = 0.3;
float gravityX = 0.3;
float speedY = 0;
float speedX = 0;
float airDrag = 0.015;
float rotationalSpeed = 0;
float rotationalDrag = 0.01;

PImage img;
PImage heartImg;
float angle = 0;

ArrayList<Heart> hearts = new ArrayList<Heart>();
boolean gameWon = false;

void setup() {
  size(displayWidth, displayHeight);  // Ensure fullscreen
  context = getActivity().getApplicationContext();
  manager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
  sensor = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  manager.registerListener(gyroListener, sensor, SensorManager.SENSOR_DELAY_NORMAL);
  rectMode(CENTER);
  img = loadImage("gekko_mini.png");
  heartImg = loadImage("heart.png");
  resetGame();
}

class Heart {
  float x, y;
  boolean collected = false;

  Heart(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    if (!collected) {
      imageMode(CENTER);
      image(heartImg, x, y, 70, 70);
    }
  }

  boolean isCollected(float gx, float gy, float gDimm) {
    if (!collected && dist(x, y, gx, gy) < (gDimm / 2 + 25)) {
      collected = true;
      return true;
    }
    return false;
  }
}

SensorEventListener gyroListener = new SensorEventListener() {
  public void onAccuracyChanged(Sensor sensor, int accuracy) {}

  public void onSensorChanged(SensorEvent event) {
    rx = constrain(event.values[0], -10, 10);
    ry = constrain(event.values[1], -10, 10);
    rz = constrain(event.values[2], -10, 10);
  }
};

void draw() {
  background(0);
  if (manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER) != null) {
    if (!gameWon) {
      // Display hearts
      for (Heart heart : hearts) {
        heart.display();
      }

      pushMatrix();
      translate(x, y);
      rotate(angle);
      imageMode(CENTER);
      image(img, 0, 0, dimm, dimm);
      popMatrix();

      gravityX = map(rx, -10, 10, 0.4, -0.4);
      gravityY = map(ry, -10, 10, -0.4, 0.4);

      speedY += gravityY;
      speedY *= 1 - airDrag;
      y += speedY;

      speedX += gravityX;
      speedX *= 1 - airDrag;
      x += speedX;

      // Adding rotation based on speed and applying rotational drag
      angle += rotationalSpeed;
      rotationalSpeed *= 1 - rotationalDrag;

      // Bumping edges and changing rotation based on collision
      if (y > height - dimm / 2 || y < dimm / 2) {
        speedY *= -0.95;
        y = constrain(y, dimm / 2, height - dimm / 2);
        rotationalSpeed += abs(speedY) * 0.1; // Increase rotation based on impact speed
      }

      if (x > width - dimm / 2 || x < dimm / 2) {
        speedX *= -0.95;
        x = constrain(x, dimm / 2, width - dimm / 2);
        rotationalSpeed += abs(speedX) * 0.1; // Increase rotation based on impact speed
      }

      // Check for heart collection
      for (Iterator<Heart> iterator = hearts.iterator(); iterator.hasNext(); ) {
        Heart heart = iterator.next();
        if (heart.isCollected(x, y, dimm)) {
          iterator.remove();
        }
      }

      // Check if all hearts are collected
      if (hearts.isEmpty()) {
        gameWon = true;
      }
    } else {
      fill(0, 255, 0);
      textAlign(CENTER, CENTER);
      textSize(64);
      text("WINNER! :)", width / 2, height / 2);
    }
  } else {
    background(157);
    textAlign(CENTER, CENTER);
    text("No accelerometer :( ", width / 2, height / 2);
    noLoop();
  }
}

void mousePressed() {
  if (gameWon) {
    resetGame();
  }
}

void resetGame() {
  x = width / 2;
  y = height / 2;
  speedY = 0;
  speedX = 0;
  rotationalSpeed = 0;
  angle = 0;
  gameWon = false;
  hearts.clear();
  int numHearts = (int) random(1, 11);
  for (int i = 0; i < numHearts; i++) {
    hearts.add(new Heart(random(dimm / 2, width - dimm / 2), random(dimm / 2, height - dimm / 2)));
  }
}

void onResume() {
  if (manager != null) {
    manager.registerListener(gyroListener, sensor, SensorManager.SENSOR_DELAY_GAME);
  }
}

void onPause() {
  if (manager != null) {
    manager.unregisterListener(gyroListener);
  }
}
