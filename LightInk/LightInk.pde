/**
 Takes given text by the user than cuts it into sections and shows those section one at a time. During given time.
 Used for light painting.
 
 @Tech Processing.org - Android
 @Author P.Dymala
 */



float stripeWidth = 35; // px
float time = 10;
String textToDisplay = " LIGHT "; // Text to be displayed. Keep the black spaces.
float imgWidth; // Width of the PGraphics canvas
float imgHeight = 500;
PImage img;
PImage[] stripes;
int currentStripeIndex = 0;
boolean drawingStarted = false; // Flag to track if drawing has started

void setup() {
  fullScreen();
  background(0);
  textSize(height);
  
  // Calculate the optimal width for the PGraphics canvas based on text length
  PFont font = createFont("Arial", 48); // You can use a desired font and size
  float textWidth = textWidth(textToDisplay); // Calculate the width of the text
  imgWidth = textWidth + 40; // Adding some padding
  
  println(textWidth);
  // Create a new image with black background
  PGraphics pg = createGraphics(int(imgWidth), height);
  pg.beginDraw();
  pg.background(0);
  
  // Calculate font size to fit the full height of the canvas
  float fontSize = pg.height * 1.2; // Adjust the factor to control the font size
  pg.textFont(font, fontSize); // Set the font and size
  pg.fill(255);
  pg.textAlign(CENTER, CENTER);
  pg.text(textToDisplay, pg.width / 2, pg.height / 2 );
  pg.endDraw();
  
  img = pg.get(); // Get the PImage from the PGraphics
  
  // Resize the image to fill the full height of the screen
  //img.resize(0, height);
  
  // Calculate the number of stripes based on image width and stripe width
  int numStripes = int(img.width / stripeWidth);
  stripes = new PImage[numStripes];
  
  // Extract stripes from the image
  for (int i = 0; i < numStripes; i++) {
    int x = int(i * stripeWidth);
    stripes[i] = img.get(x, 0, int(stripeWidth), img.height);
    stripes[i].resize(int(stripeWidth), height); // Resize the height of each stripe to fill the screen
  }
  
  // Calculate the frame rate to show all stripes within the specified time
  float calculatedFrameRate = numStripes / time;
  println(calculatedFrameRate);
  frameRate(calculatedFrameRate);
}

void draw() {
  if (drawingStarted) {
    background(0);
    
    // Calculate the x-coordinate to center the stripe
    float xCenter = (width - stripeWidth) / 2;
    
    // Display the current stripe in the middle of the screen
    image(stripes[currentStripeIndex], xCenter, 0);
    
    // Move to the next stripe
    currentStripeIndex++;
    
    // If we've displayed all the stripes, reset to the first stripe
    if (currentStripeIndex >= stripes.length) {
      currentStripeIndex = 0;
      drawingStarted = false;
      background(0);
    }
  }
}

void mousePressed() {
  drawingStarted = true; // Start drawing when the mouse is pressed
}
