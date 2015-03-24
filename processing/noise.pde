boolean isPaused = false;
void togglePause() {
  if (isPaused) {
    loop();
    isPaused = false;
  } else {
    noLoop();
    isPaused = true;
  }
}


float increment = 0.02;
int width = canvasSize.width;
int height = canvasSize.height;

void setup() {
  size(canvasSize.width, canvasSize.height);
}

void draw() {
  
  loadPixels();

  float xoff = 0.0; // Start xoff at 0

  noiseDetail(8, 0.3);
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      //float bright = noise(xoff, yoff) * 255;

      // Try using this line instead
      float bright = random(0,255);
      
      // Set each pixel onscreen to a grayscale value
      pixels[x+y*width] = color(bright);
    }
  }
  
  updatePixels();
}
