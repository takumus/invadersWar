//-----------------------------------------------//
//ParticleClass
//-----------------------------------------------//
class Particle {
  int tick = 20 + floor(random(20));
  float x = 0;
  float y = 0;
  float px;
  float py;
  float vx = 0;
  float vy = 0;
  float g = 0;
  int size;
  
  color c;
  
  Particle(int size, color c, int tick) {
    this.c = c;
    this.tick = floor(tick/2 + float(tick)*random(1));
    this.size = size;
  }
  void update() {
    if (tick < 0 || get(floor(x + vx), floor(y + vy)) < -1) {
      ParticleManager.removeParticle(this);
    }
    tick --;
    px = x;
    py = y;
    x += vx;
    y += vy;
    vy += g;
  }
  void render() {
    stroke(c);
    strokeWeight(size);
    line(px, py, x, y);
    noStroke();
  }
  void setX(float x) {
    this.px = this.x = x;
  }
  void setY(float y) {
    this.py = this. y = y;
  }
  void setVX(float vx) {
    this.vx = vx;
  }
  void setVY(float vy) {
    this.vy = vy;
  }
  void setG(float g) {
    this.g = g;
  }
}

//-----------------------------------------------//
//ParticleClass
//-----------------------------------------------//
class CircleParticle {
  color c;
  float velocity;
  float gravity;
  int size;
  int tick;
  CircleParticle(color c, int size, float velocity, float gravity, int tick){
    this.c = c;
    this.size = size;
    this.velocity = velocity;
    this.gravity = gravity;
    this.tick = tick;
  }
  void launch(float x, float y){
    for(int i = 0; i < 360; i += 4){
      Particle p = new Particle(size, c, tick);
      p.setX(x);
      p.setY(y);
      p.setVX(velocity*cos(radians(i))*random(1));
      p.setVY(velocity*sin(radians(i))*random(1));
      p.setG(gravity);
      ParticleManager.addParticle(p);
    }
  }
}
class Smoke{
  color c;
  float velocity;
  float gravity;
  int size;
  int tick;
  Smoke(color c, int size, float velocity, float gravity, int tick){
    this.c = c;
    this.size = size;
    this.velocity = velocity;
    this.gravity = gravity;
    this.tick = tick;
  }
  void launch(float x, float y){
    for(int i = 0; i < 20; i ++){
      Particle p = new Particle(size, c, tick);
      p.setX(x);
      p.setY(y);
      p.setVX(velocity*random(-1,1));
      p.setVY(velocity*random(-1,1));
      p.setG(gravity);
      ParticleManager.addParticle(p);
    }
  }
}
