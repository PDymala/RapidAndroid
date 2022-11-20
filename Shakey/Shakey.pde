/**
 5 min app. use you phone to detect vibrations. Shows a graph frequency/amplitude
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
int precision = 128;
double[] signalArray = new double[precision];
int counter = 0;

void setup() {
  context = getContext();
  manager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);
  sensor = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  manager.registerListener(gyroListener, sensor, SensorManager.SENSOR_DELAY_NORMAL);
  textFont(createFont("SansSerif", displayDensity * 24));
  textAlign(CENTER, CENTER);
  orientation(LANDSCAPE);
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

  manager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
  if (manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER) != null) {



    if (counter == precision-1) {

      thread("transformAndDrawData");
      counter = 0;
    }
    counter++;

    signalArray[counter] = rz;
  } else {


    background(157);
    text("No acceloerermetr :( ", width/2, height/2);
    noLoop();
  }
}

void transformAndDrawData() {
  background(0);

  Phasor[] temp = singlalTransform(signalArray, frameRate);

  int tempLen = temp.length/2;

  stroke(0, 255, 0);

  noFill();
  beginShape();

  for (int i = 0; i < tempLen; i++) {

    float y = map((float)(temp[i].getAmp()), 0, 100, 0, height);
    circle(i*width/tempLen, y, 10);
    vertex(i*width/tempLen, y);
  }
  endShape();

  drawUI(temp);
}

void drawUI(Phasor[] input) {
  fill(255, 255, 255);
  text((int)(input[0].getFreq())+"Hz", 80, 30);
  text((int)(input[input.length/2].getFreq())+"Hz", width-100, 30);
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




public Phasor[] singlalTransform(double[] samples, double sampleRate) {
  double[][] data = new double[2][samples.length];
  for (int i = 0; i < data[0].length; i++) {
    data[0][i] = samples[i];
    data[1][i] = 0;
  }

  FastFourierTransformer.transformInPlace(data, DftNormalization.STANDARD, TransformType.FORWARD);
  Phasor[] temp = new Phasor[data[0].length];
  for (int i = 0; i < data[0].length; i++) {


    double freq = i * sampleRate / samples.length;
    double amp = Math.sqrt(data[0][i] * data[0][i] + data[1][i] * data[1][i]);
    double phase = Math.atan2(data[1][i], data[0][i]);
    temp[(int) i] = new Phasor(amp, freq, phase);
  }


  return temp;
}
