static class Vector {
  static Point getVectorToTarget(Point from, Point to, float v) {
    float r = atan2(to.y - from.y, to.x - from.x);
    float vx = cos(r) * v;
    float vy = sin(r) * v;
    return new Point(vx, vy);
  }
}
class Tick {
  int tick;
  int c;
  Tick(int tick, boolean random, boolean first) {
    this.tick = tick;
    if (first) {
      c = tick;
    }
    if (random) {
      c = int(float(c)*random(1));
    }
  }
  boolean check() {
    if (c >= tick) {
      c = 0;
      return true;
    }
    c++;
    return false;
  }
  void reset() {
    c = tick;
  }
}
class Fader {
  int alpha = 0;
  boolean complete = false;
  String fadeMode = "";
  int speed = 8;
  PImage screen = loadImage("./texture/screen/waitingScreen.png");
  void fadeIn() {
    fadeMode = "in";
    alpha = 255;
    complete = false;
  }
  void fadeOut() {
    fadeMode = "out";
    alpha = 0;
    complete = false;
  }
  void reset() {
    complete = false;
    fadeMode = "";
  }
  void render() {

    if (fadeMode == "in") {
      alpha -= speed;
      if (alpha <= 0) {
        complete = true;
        alpha = 0;
        fadeMode = "";
      }
      tint(255, 255, 255, alpha);
      image(screen, 0, 0);
      noTint();
    } 
    else if (fadeMode == "out") {
      alpha += speed;
      if (alpha >= 500) {
        complete = true;
        alpha = 255;
        fadeMode = "";
      }
      tint(255, 255, 255, alpha);
      image(screen, 0, 0);
      noTint();
    }
  }
}

