import peasy.*;

PeasyCam camera;
int cols, rows;
int scale = 75;
int treeCounter;
int w = 3500;
int h = 3500;
float flyingY = 0;
float flyingX = 0;
PImage imgTexture, imgSky, imgWater;
float[][] terrain;
float increment;
Terrain ground;
Terrain water;
PVector cam, centercam;
float posi_x, posi_y;
int _centercamX, _centercamY;
boolean flag, updatecam;
double camDistance;
String _camDistance, Z_camPos;
PFont font;
LSystem lsys;
Turtle turtle;

void setup() {
  frameRate(30);
  fullScreen(P3D, 1);
  cols = w / scale;
  rows = h / scale;
  posi_x = random(1, w);
  posi_y = random(1, h);
  terrain = new float[cols][rows];
  imgTexture = loadImage("snow2.jpg");
  imgTexture.resize(scale, scale);
  imgSky = loadImage("skybox1.png");
  imgSky.resize(width, height);
  imgWater = loadImage("water.jpg");
  imgWater.resize(scale, scale);
  increment = 0.03;
  centercam = new PVector(width/2, height/2, 0);
  camera = new PeasyCam(this, centercam.x, centercam.y, centercam.z, 1300); 
  //camera.setPitchRotationMode();
  flag = true;
  updatecam = true;
  font = createFont("TimesNewRoman", 13, true);
  ground = new Terrain(rows, cols, imgTexture, scale);
  water = new Terrain(rows, cols, imgWater, scale);

  ground.generateTerrain(terrain, rows, cols, flyingX, flyingY);

  Rule[] ruleset = new Rule[1];
  ruleset[0] = new Rule('F', "F[-&<F][<++&F]|F[-&>F][+&F]");
  lsys = new LSystem("F", ruleset);
  for (int x = 0; x < 4; x++) {
    pushMatrix();
    lsys.generate();
    popMatrix();
  }
  for (int x = 0; x < 3; x++) {
    turtle = new Turtle(lsys.getSentence(), random(400, 600), random(radians(15), radians(40)), random(25, 40));
    ground.addTree(turtle);
    ground.setTree(turtle);
  }
}
void mouseDragged() {
  flag = true;
  updatecam = true;
}

void keyPressed() {
  if (key == 32) {
    turtle = new Turtle(lsys.getSentence(), random(400, 600), random(radians(15), radians(40)), random(25, 40));
    ground.addTree(turtle);
    ground.setTree(turtle);
  }
  flag = true;
}
void input() {
  if (keyPressed) {
    if (key == 'w') {
      flyingY -= increment;
      ground.moveTrees("addY");
    }
    if (key == 's') {
      flyingY += increment;
      ground.moveTrees("subY");
    }
    if (key == 'a') {
      flyingX -= increment;
      ground.moveTrees("addX");
    }
    if (key == 'd') {
      flyingX += increment;
      ground.moveTrees("subX");
    }
    if (key == 'r') {
      setup();
    }
    flag = true;
  }
}

void update() {
  stroke(0);
  background(imgSky);

  ground.generateTerrain(terrain, rows, cols, flyingX, flyingY);
}

void render() {
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  ground.drawTerrain(terrain);
  water.drawTerrain(-250.0);
  ground.renderTree();
  camDistance = camera.getDistance();
  _camDistance= Double.toString(camDistance);
  Z_camPos = Float.toString(terrain[w/2/scale][h/2/scale]);
  camera.beginHUD();
  fill(0);
  textFont(font, 36);
  textAlign(LEFT);
  text(treeCounter, 10, height-75);
  text(Z_camPos, 10, height-30);
  camera.endHUD();
  flag = false;
}

void draw() {
  input();
  if (treeCounter < 10) {
    turtle = new Turtle(lsys.getSentence(), random(300, 600), random(radians(15), radians(40)), random(25, 40));
    ground.addTree(turtle);
    ground.setTree(turtle);
    flag = true;
  }
  if (flag == true) { 
    update();
    render();
  }
}