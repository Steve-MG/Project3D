class Turtle {

  String todo;
  float len;
  float theta;
  float weight;
  float turn;
  PVector pos = new PVector(0, 0, 0);

  Turtle(String s, float l, float t, float w) {
    todo = s;
    len = l; 
    theta = t;
    weight = w;
    int nb_try = 0;
    do {
      pos.x = random(100, 3400);
      pos.y = random(100, 3400);
      nb_try++;
    } while (terrain[parseInt(pos.x/scale)][parseInt(pos.y/scale)] < -200  && nb_try < 50);
    turn = random(radians(180), radians(200));
  } 

  void render() {
    if (pos.x >= 0 && pos.x < 3400 && pos.y >= 0 && pos.y < 3400) {
      treeCounter++;
      if (terrain[parseInt(pos.x/scale)][parseInt(pos.y/scale)] > -200) {
        float temp = terrain[parseInt(pos.x/scale)][parseInt(pos.y/scale)];
        stroke(0, 175);
        pushMatrix();
        pos.z = temp;
        //println(pos);
        translate(pos.x, pos.y, pos.z);
        rotateY(-PI/2);
        for (int i = 0; i < todo.length(); i++) {
          char c = todo.charAt(i);
          if (c == 'F') {
            strokeWeight(weight);
            line(0, 0, len, 0);
            translate(len, 0);
          } else if (c == 'g') {
            translate(len, 0);
          } else if (c == '+') {
            rotateX(theta);
          } else if (c == '-') {
            rotateX(-theta);
          } else if (c == '<') {
            rotateY(theta);
          } else if (c == '>') {
            rotateY(-theta);
          } else if (c == '&') {
            rotateZ(-theta);
          } else if (c == '^') {
            rotateZ(theta);
          } else if (c == '|') {
            rotateX(turn);
          } else if (c == '[') {
            pushMatrix();
          } else if (c == ']') {
            popMatrix();
          }
        }
        popMatrix();
      }
    }
  }

  void setLen(float l) {
    len = l;
  }

  void move(String s) {
    if ( s == "addX" ) {
      pos.x += scale;
    }
    if ( s == "subX" ) {
      pos.x -= scale;
    }
    if ( s == "addY" ) {
      pos.y += scale;
    }
    if ( s == "subY" ) {
      pos.y -= scale;
    }
  }

  void changeLen(float percent) {
    len *= percent;
    weight *= percent;
  }

  void setToDo(String s) {
    todo = s;
  }
}