boolean movingUp;
boolean movingDown;
boolean movingRight;
boolean movingLeft;

float angleY;
float angleX;


Table table;
float r = 200;

PImage earth;
PShape globe;

float sat1Lon;
float sat1Lat;


float x;
float y;
float z;

void setup() {
  size(600, 600, P3D);
  earth = loadImage("earth.jpg");
  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
  requestData();
}

void draw() {
  push();
    background(51);
    translate(width*0.5, height*0.5);
    rotateY(angleY);
    rotateX(angleX);
    move();
    lights();
    fill(200);
    noStroke();
    shape(globe);
    translate(x,y,z);
    box(10);
  pop();
}

void keyPressed() {
  if (key=='a')
    movingLeft = true;
  if (key=='d')
    movingRight = true;
  if (key=='w')
    movingUp = true;
  if (key=='s')
    movingDown = true;
}

void keyReleased() {
  if (key=='a')
    movingLeft = false;
  if (key=='d')
    movingRight = false;
  if (key=='w')
    movingUp = false;
  if (key=='s')
    movingDown = false;
}

void move() {
  if (movingRight)
    angleY -= 0.05;
  if (movingLeft)
    angleY += 0.05;
  if (movingDown)
    angleX += 0.05;
  if (movingUp)
    angleX -= 0.05;
}

void requestData() {
  JSONObject j = loadJSONObject("https://api.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/2/&apiKey=VMDMFP-WCJTTV-T38W77-4SR6");
  JSONArray positionsJson = j.getJSONArray("positions");

  JSONObject pos = positionsJson.getJSONObject(0);

  sat1Lon = pos.getFloat("satlongitude");
  sat1Lat = pos.getFloat("satlatitude");

  float theta = radians(sat1Lat);
  float phi = radians(sat1Lon) + PI;
  
  x = (r+50) * cos(theta) * cos(phi);
  y = -(r+50) * sin(theta);
  z = -(r+50) * cos(theta) * sin(phi);

}
