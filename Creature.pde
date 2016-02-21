class Octopus extends Monster {
  TextureLib texture = new TextureLib();
  Tick shotTick = new Tick(10, true, false);
  Octopus() {
    super(60, 45, 50);
    texture.addTexture("walk1", loadImage("./texture/character/octopus/walk1.png"));
    texture.addTexture("walk2", loadImage("./texture/character/octopus/walk2.png"));
    texture.getAnimation("walk").add("walk1");
    texture.getAnimation("walk").add("walk2");
    texture.setTexture("walk1");

    setVX(1);
  }
  void update() {
    super.update();

    if (getDeadEndDirection() == "right") {
      setVX(-1);
    }
    else if (getDeadEndDirection() == "left") {
      setVX(1);
    }
    if (shotTick.check()) {
      for (Player p : manager.getPlayerList().keySet()) {
        OctopusBallet b = new OctopusBallet(this);
        b.setX(getCX());
        b.setY(getCY());
        b.goToEntity(p, 10, 20);
        manager.addEntity(b);
      }
    }
  }
  void render() {
    super.render();
    texture.render(getX(), getY());
    texture.playAnimation("walk", 20);
  }
}

class Squid extends Monster {
  TextureLib texture = new TextureLib();
  Tick shotTick = new Tick(60, true, false);
  Squid() {
    super(40, 40, 20);
    
     //Difficulty
    if(Difficulty.getDifficulty().equals("hard")){
      shotTick = new Tick(20, true, false);
    }
    
    texture.addTexture("walk1", loadImage("./texture/character/squid/walk1.png"));
    texture.addTexture("walk2", loadImage("./texture/character/squid/walk2.png"));
    texture.getAnimation("walk").add("walk1");
    texture.getAnimation("walk").add("walk2");
    texture.setTexture("walk1");

    setVX(1);
  }
  void update() {
    super.update();

    if (getDeadEndDirection() == "right") {
      setVX(-1);
    }
    else if (getDeadEndDirection() == "left") {
      setVX(1);
    }
    if (shotTick.check()) {
      for (Player p : manager.getPlayerList().keySet()) {
        SquidBallet b = new SquidBallet(this);
        b.setX(getCX());
        b.setY(getCY());
        b.goToEntity(p, 5, 10);
        manager.addEntity(b);
      }
    }
  }
  void render() {
    super.render();
    texture.render(getX(), getY());
    texture.playAnimation("walk", 20);
  }
}


class Door extends Creature {
  TextureLib texture = new TextureLib();
  Door() {
    super(40, 55, 100);
    living = false;
    texture.addTexture("door", loadImage("./texture/character/door/door.png"));
    texture.setTexture("door");
    setF(0.02);
  }
  void render() {
    super.render();
    texture.render(getX(), getY());
  }
}
class Monster extends Creature {
  Monster(int w, int h, int maxHealth){
    super(w, h, maxHealth);
  }
}
class Creature extends PhysicalEntity {
  boolean knockBack = true;
  String faceDirection = "right";
  HealthBar healthBar;
  float maxHealth;
  float health;
  boolean living = true;
  CircleParticle blood = new CircleParticle(#ff0000, 4, 4, 0.2, 30);
  Creature(int w, int h, int maxHealth) {
    super(w, h);
    this.maxHealth = maxHealth;
    health = maxHealth;
    setF(0);
    healthBar = new HealthBar(w * 0.8, 6, maxHealth);
    healthBar.setHealth(maxHealth);
  }
  void damage(float damage) {
    setHealth(health - damage);
  }
  void setHealth(float health) {
    this.health = health;
    healthBar.setHealth(health);
    if (health <= 0 && living) {
      removeEntity();
      blood.launch(getCX(), getCY());
      onDeath();
    }
  }
  void setMaxHealth(){
    setHealth(maxHealth);
  }
  void onDeath(){
  }
  void onContactWithEntity(Entity entity){
    if(entity instanceof Creature){
      onContactWithCreature((Creature)entity);
    }
  }
  void onContactWithCreature(Creature creature){
  }
  void update() {
    super.update();
    if (contactWithColor(#FF0000)) {
      println("dead");
    }
    if (getVX() > 0) {
      faceDirection = "right";
    }
    else if (getVX() < 0) {
      faceDirection = "left";
    }
  }
  String getFaceDirection() {
    return faceDirection;
  }
  //jump
  void jump(float vy) {
    //if (standing) {
      standing = false;
      this.vy = -vy;
    //}
  }
  void render() {
    super.render();
    if (living) {
      healthBar.render(getCX(), getCY() + (getHeight()/2) + 5);
    }
  }
}
class HealthBar {
  float w;
  float h;
  float max;
  float hp = 0;
  HealthBar(float w, float h, float max) {
    this.w = w;
    this.h = h;
    this.max = max;
  }
  void setHealth(float value) {
    if (value < 0) {
      value = 0;
    }
    hp = value;
  }
  void render(float x, float y) {
    if (hp == max) {
      return;
    }
    stroke(#000000);
    strokeWeight(1.3);
    fill(#000000);
    rect(x - w / 2, y, w, h);
    int g = floor((hp/max)*255);
    fill(255 - g, g, 0);
    rect(x - w / 2, y, w * (hp/max), h);
    noFill();
    noStroke();
  }
}

