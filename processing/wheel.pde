/* @pjs transparent="true"; */

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

void setup() {
	size(canvasSize.width, canvasSize.height);
	background(255);
	stroke(0);
	strokeWeight(1.0);
	smooth();
}

void draw() {
	background(255);
	float time = millis()/1500;
	noFill();
	translate(width/2.0, height/2.0, 0);
	float xScale0 = 2.5;
	float xScale1 = 0.5;
	float xScale2 = 0.33;
	float yScale0 = 1.0;
	float yScale1 = 0.5;
	float yScale2 = 0.33;
	float xFrequency1 = 7;
	float yFrequency1 = 7;
	float xFrequency2 = 17;
	float yFrequency2 = 17;
	beginShape();
	for (float t = 0; t < TWO_PI; t += TWO_PI/1000) {
		float xPos = xScale0 * cos(t+time) + xScale1 * cos(xFrequency1*t+time) + xScale2 * cos(xFrequency2*t+time);
		float yPos = yScale0 * sin(t+time) + yScale1 * sin(yFrequency1*t+time) + yScale2 * cos(yFrequency2*t+time);
		xPos *= 60;
		yPos *= 60;
		//console.log('xPos, yPos: ' + xPos + ', ' + yPos);
	    vertex(xPos, yPos);
	}
    endShape(CLOSE);
}
