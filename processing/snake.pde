color white = color(255);
color black = color(0);

int lastTime = 0;
ArrayList vertices;

class Point {
    public float x;
    public float y;
    public color col;
    
    public Point(float x, float y, color col) {
        this.x = x;
        this.y = y;
        this.col = col;
    }

    public Point(float x, float y) {
        this.x = x;
        this.y = y;
        makeColor();
    }

    void makeColor() {
        col = color(abs(random(25) * 10));
        if ( (int)random(7) == 0 ) {
            colorMode(HSB, 360, 100, 100, 255);
            col = color(325, 100, random(75, 100) );
            colorMode(RGB, 255, 255, 255, 255);
        }
    }

    void setColor(color col) {
        this.col = col;
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
    background(white);
    strokeWeight(0.5);
    smooth();
    vertices = new ArrayList();
    vertices.add(new Point(canvasSize.width/2+random(-10, 10), canvasSize.height/2+random(-10, 10), black));
}

void draw() {
    int currentTime = millis();
    if (currentTime > lastTime + 75) {
        addVertice(currentTime);
        lastTime = currentTime;
    }

    scale(1.0);
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < vertices.size(); i++) {
        Point p = vertices.get(i);
        fill(p.col);
        vertex(p.x, p.y);
    }
    endShape();
}

void addVertice(int time) {
    Point lastVertex = vertices.get(vertices.size()-1);
    float x = lastVertex.x + sin(random(TWO_PI)) * 20;
    float y = lastVertex.y + cos(random(TWO_PI)) * 20;
    
    // start from center if we reach screen edge    
    if (x < 0 || x > canvasSize.width || y < 0 || y > canvasSize.height) { 
        vertices.clear();
        x = canvasSize.width / 2 + random(-10, 10);
        y = canvasSize.height / 2 + random(-10, 10);
    }

    Point vertex = new Point(x, y);
    vertices.add(vertex);
    // console.log('Created vertx at '+x+' , '+y+' col: '+col);
}
