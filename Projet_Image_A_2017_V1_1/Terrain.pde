class Terrain {
  int rows;
  int cols;
  PImage imgtexture;
  int scl;
  float[][] terrain;
  color c;
  ArrayList<Turtle> trees;

  Terrain(int _rows, int _cols, PImage _texture, int _scl ) {
    rows = _rows;
    cols = _cols;
    imgtexture = _texture;
    scl = _scl;
    trees = new ArrayList<Turtle>();
  }

  void generateTerrain (float[][] terrain, int rows, int cols, float FlyingX, float FlyingY) {
    float yoff = FlyingY;
    for (int y = 0; y < rows; y++) {
      float xoff = FlyingX;
      for (int x = 0; x < cols; x++) {
        terrain[x][y] = map(noise(xoff, yoff), 0, 1, -700, 700);
        xoff += 0.03;
      }
      yoff += 0.03;
    }
  }
  void drawTerrain(float[][] terrain) {
    for (int y = 0; y < rows-1; y++) {
      beginShape(TRIANGLE_STRIP);
      texture(imgtexture);
      //noStroke();
      for (int x = 0; x < cols; x++) {
        float u = imgtexture.width / cols * x;
        float v = imgtexture.height / rows * y;
        vertex(x*scale, y*scale, terrain[x][y], u, 0);
        vertex(x*scale, (y+1)*scale, terrain[x][y+1], 0, v );
      }
      endShape();
    }
  }
  void drawTerrain(float terrain) {
    for (int y = 0; y < rows-1; y++) {
      beginShape(TRIANGLE_STRIP);
      texture(imgtexture);
      for (int x = 0; x < cols; x++) {
        float u = imgtexture.width / cols * x;
        float v = imgtexture.height / rows * y;
        vertex(x*scale, y*scale, terrain, u, 0);
        vertex(x*scale, (y+1)*scale, terrain, u, v);
      }
      endShape();
    }
  }

  ////////All the code the for trees

  void addTree(Turtle t) {
    trees.add(t);
  }

  void setTree(Turtle t) {
    t.setToDo(lsys.getSentence());
    for (int x = 0; x < 5; x++) {
      t.changeLen(0.5);
    }
  }

  void renderTree() {
    treeCounter = 0;
    for (Turtle t : trees) {
      t.render();
    }
  }

  void moveTrees(String s) {
    for (Turtle t : trees) {
      t.move(s);
    }
  }
}