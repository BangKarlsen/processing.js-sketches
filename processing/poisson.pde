ArrayList dots = new ArrayList();

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
	strokeWeight(1.1);
	smooth();
	frameRate(30);
}

int currentId = 0;
int generateId() {
	return currentId++;
}

class Dot {
	public int id;
	public int x;
	public int y;
	public int radius;
	public int xSpeed = random(1, 4);
	public color col;

	public Dot(int x, int y) {
		this.x = x;
		this.y = y;
		radius = xSpeed*3;//random(5, 10);
		id = generateId();
		makeColor();
		//console.log('Created dot ' + id + ' at x:' + x + ' y:' + y);
	}
	
	private void makeColor() {
	    col = color(abs(random(25) * 10));
	    if ( (int)random(7) == 0 ) {
	        colorMode(HSB, 360, 100, 100, 255);
	        col = color(325, 100, random(75, 100) );
	        colorMode(RGB, 255, 255, 255, 255);
	    }
	}

	public void update() {
		x += xSpeed;
	}

	public void draw() {
		float drawRadius = radius * canvasSize.width/410;
		fill(col);
		ellipse(x, y, drawRadius, drawRadius);  
	}

	public boolean isOutOfScreen() {
		if (x < 0 || x > canvasSize.width || 
			y < 0 || y > canvasSize.height) {
			//console.log("dot " + id + " is out of screen");
			return true;
		}
		return false;
	}
}

void draw() {
	if ((int)frameCount%2 == 0) {
		addDots();
	}
	updateDots();
	drawDots();
}

void addDots() {
	int numDots = poisson(2); // ask mr. poisson how many dots to add this time
	for (int i = 0; i < numDots; i++) {
		dots.add(new Dot(random(1, 40), random(1, canvasSize.height)));		
	}
}

// see also http://en.wikipedia.org/wiki/Poisson_distribution
int poisson(int expectedValue) {
	int k = 0;
	int limit = exp(-expectedValue);
	float p = 1;

	while(p > limit) {
		p = p * random(1.0); // between 0.0 - 1.0
		k++;
	}
	k--;
	//console.log('poisson says: expected: ' + expectedValue + ', k: ' + k + ' (mean: ' + runningMean(k) + ')');
	return k;
}

/* check that poisson is on the right track
int length = 0;
int totalNum = 0;
float runningMean(int num) {
	length++
	totalNum += num;
	return totalNum / length;
}
*/

void updateDots() {
	for (int i = 0; i < dots.size(); i++) {
		Dot dot = dots.get(i);
		if (dot.isOutOfScreen()) {
			dots.remove(i);
		} else {
			dot.update();			
		}
	}
}

void drawDots() {
	background(255);
	for (int i = 0; i < dots.size(); i++) {
		dots.get(i).draw();
	}
}
