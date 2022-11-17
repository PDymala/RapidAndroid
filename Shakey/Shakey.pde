


import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;

Context context;
SensorManager manager;
Sensor sensor;

float rx, ry, rz;


void setup() {
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
    rx = event.values[0];
    ry = event.values[1];
    rz = event.values[2];
    //print(rx + " " +ry + " " +rz);
  }
};


void draw() {

  manager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
  if (manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER) != null) {

    
    
    
    
    
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


 public static Phasor[] singlalTransform(double[] samples, double sampleRate) {
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
