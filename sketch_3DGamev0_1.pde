import peasy.*;

PeasyCam camera;
int cols, rows;
int scale = 75;
int w = 10000;
int h = 10000;
float flyingY = 0;
float flyingX = 0;
PImage imgTexture, imgSky, imgWater;
float[][] terrain;
float increment;
PVector cam, centercam;
boolean flag;
double camDistance;
String _camDistance;
float Radius = 250.0;
PFont font;

void setup() {
  frameRate(30);
  fullScreen(P3D, 1);
  cols = w / scale;
  rows = h / scale;
  terrain = new float[cols][rows];
  imgTexture = loadImage("images.jpg");
  imgTexture.resize(75, 75);
  imgSky = loadImage("skybox1.png");
  imgSky.resize(width, height);
  imgWater = loadImage("water.jpg");
  increment = 0.025;
  cam = new PVector(width/2, height/2, (height/2.0) / tan(PI*30.0 / 180.0));
  centercam = new PVector(width/2, height/2, 0);
  camera = new PeasyCam(this, centercam.x, centercam.y, centercam.z, 1300);
  camera.setPitchRotationMode();
  flag = true;
  font = createFont("Arial", 13, true);
}

void input() {
  if (keyPressed) {
    if (key == 'w') {
      flyingY -= increment;
    }
    if (key == 's') {
      flyingY += increment;
    }
    if (key == 'a') {
      flyingX -= increment;
    }
    if (key == 'd') {
      flyingX += increment;
    }
    flag = true;
  }
}

void update() {
  background(imgSky);
  stroke(0);

  float yoff = flyingY;
  for (int y = 0; y < rows; y++) {
    float xoff = flyingX;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -700, 700);
      xoff += 0.025;
    }
    yoff += 0.025;
  }
}

void render() {


  translate(width/2, height/2);
  rotateX(PI/3);

  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      texture(imgTexture);
      vertex(x*scale, y*scale, terrain[x][y]);
      vertex(x*scale, (y+1)*scale, terrain[x][y+1]);
    }
    endShape();
    camDistance = camera.getDistance();
    _camDistance= Double.toString(camDistance);
    camera.beginHUD();
      textFont(font, 36);
      fill(255);
      textAlign(LEFT);
      text(_camDistance, 10, height-75);
    camera.endHUD();
  }
  flag = false;
}

void draw() {
  input();
  update();
  render();
}