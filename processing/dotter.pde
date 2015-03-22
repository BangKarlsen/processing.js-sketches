int currentId = 0;
int generateId() {
	return currentId++;
}

Dot rootDot = new Dot(20, canvasSize.height / 2);
Dot currentDot;

class Dot {
	public int id;
	public int x;
	public int y;
	public color col;
	public Dot right = null;
	public Dot up = null;
	public Dot down = null;

	public Dot(int x, int y) {
		this.x = x;
		this.y = y;
		id = generateId();
		makeColor();
	}

	private void makeColor() {
	    col = color(abs(random(25) * 10));
	    if ( (int)random(7) == 0 ) {
	        colorMode(HSB, 360, 100, 100, 255);
	        col = color(325, 100, random(75, 100) );
	        colorMode(RGB, 255, 255, 255, 255);
	    }
	}

	public boolean isOutOfScreen() {
		if (x < 20 || x > canvasSize.width - 20 || 
			y < 20 || y > canvasSize.height - 20) {
			return true;
		}
		return false;
	}

	private void drawCircle() {
		float radius = 15 * canvasSize.width / 410;
		fill(col);
		ellipse(x, y, radius, radius);  
	}
}

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
	frameRate(15);
	currentDot = rootDot;
}

void draw() {
	currentDot = addDot(currentDot);
	drawDots(rootDot);
}

void drawDots(Dot node) {
	if (node != null) {
		node.drawCircle();
		drawDots(node.down);
		drawDots(node.right);
		drawDots(node.up);
	}
}

Dot addDot(Dot currentDot) {
	if (currentDot.isOutOfScreen()) {
		currentDot = findAncestor(currentDot);
	}

	float smallSpacing = 10 * canvasSize.width / 410;	// magic ratio that scales responsively
	float largeSpacing = 20 * canvasSize.width / 410;   // 410 is the original, default sketch width

	Dot childDot = currentDot;
	switch ((int)random(3)) {
	    case 0: // DOWN
	    	if (createNewBranch() || currentDot.down == null) {
	    		childDot = new Dot(currentDot.x + smallSpacing, currentDot.y + largeSpacing);
	    		currentDot.down = childDot;	
	    	}
	    	break;
	    case 1: // RIGHT
	    	if (createNewBranch() || currentDot.right == null) {
	    		childDot = new Dot(currentDot.x + largeSpacing, currentDot.y);
	    		currentDot.right = childDot;	    		
	    	}
	    	break;
	    case 2: // UP
	    	if (createNewBranch() || currentDot.up == null) {
	    		childDot = new Dot(currentDot.x + smallSpacing, currentDot.y - largeSpacing);
	    		currentDot.up = childDot;	    		
	    	}
	    	break;
	    default:
	      	console.log("Error in random");
	}
	return childDot;
}

boolean createNewBranch() {
	count++;
	return (count % 3) == 0;
}

int count = 0;
Dot findAncestor(Dot dot) {
	count++;
	return rootDot;
}
