/**
 5 min app. check the connected wifi signal. Shown by screen color
 @Tech Processing.org - Android
 @Author P.Dymala
 */

import android.net.wifi.WifiManager;
import android.content.Context;

private Context context;
private WifiManager wifiManager;
private int linkSpeed = 0;
private float bg = 0;
private int percent = 0;

void setup() {
  fullScreen();
  background(255);
  context = getContext();
  wifiManager = (WifiManager)context.getSystemService(Context.WIFI_SERVICE);
  colorMode(HSB, 360, 100, 100);
  textFont(createFont("SansSerif", displayDensity * 24));
  textAlign(CENTER, CENTER);
}

void draw() {

  linkSpeed = wifiManager.getConnectionInfo().getRssi();


  if (linkSpeed < -110) {
    background(0, 0, 0);
    text("Signal: No connection", width/2, height/2);
  } else {
    bg = map(linkSpeed, -90, 0, 0, 120);
    percent = (int)map(linkSpeed, -90, 0, 0, 100);
    background(int(bg), 100, 100);
    text("Signal:" + percent + "%", width/2, height/2);
  }
}
