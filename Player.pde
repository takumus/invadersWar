//-----------------------------------------------//
//PlayerClass
//-----------------------------------------------//
class Player extends Creature {
  float maxSpeed = 6;
  boolean moveLeft = false;
  boolean moveRight = false;
  String lastFaceDirection = "right";
  int shotTickCount = 0;
  boolean god = false;
  Tick shotTick = new Tick(7, false, false);
  TextureLib texture = new TextureLib();
  GameManager gameManager;
  int jumpCount = 0;
  RailGun rg;
  Player(GameManager gameManager) {
    super(45, 45, 100);
    this.gameManager = gameManager;
    texture.addTexture("left1", loadImage("./texture/character/player/left1.png"));
    texture.addTexture("left2", loadImage("./texture/character/player/left2.png"));
    texture.addTexture("right1", loadImage("./texture/character/player/right1.png"));
    texture.addTexture("right2", loadImage("./texture/character/player/right2.png"));
    texture.addTexture("jumpLeft", loadImage("./texture/character/player/jumpLeft.png"));
    texture.addTexture("jumpRight", loadImage("./texture/character/player/jumpRight.png"));

    texture.getAnimation("walkLeft").add("left1");
    texture.getAnimation("walkLeft").add("left2");

    texture.getAnimation("walkRight").add("right1");
    texture.getAnimation("walkRight").add("right2");
    texture.setTexture("right1");
  }
  void setManager(EntityManager manager){
    super.setManager(manager);
    //rg = new RailGun(this, manager);
  }
  //-----------------------------------------------//
  //UPDATE  
  //-----------------------------------------------//
  void update() {
    
    if (moveLeft && moveRight || !moveLeft && !moveRight) {
      doWalkStop();
    } 
    else if (moveLeft) {
      doWalkLeft();
      if (shotTickCount <= 0) {
        lastFaceDirection = "left";
      }
    } 
    else if (moveRight) {
      doWalkRight();
      if (shotTickCount <= 0) {
        lastFaceDirection = "right";
      }
    }

    if (moveLeft && moveRight || !moveLeft && !moveRight) {
      doWalkStop();
    } 
    else {
      if (lastFaceDirection == "left") {
        texture.playAnimation("walkLeft", 4);
      }
      else if (lastFaceDirection == "right") {
        texture.playAnimation("walkRight", 4);
      }
    }

    if (!getStanding()) {
      if (lastFaceDirection == "right") {
        texture.setTexture("jumpRight");
      }
      else {
        texture.setTexture("jumpLeft");
      }
    }
    else {
      if (!(moveLeft || moveRight)) {
        if (lastFaceDirection == "right" ) {
          texture.setTexture("right1");
        } 
        else if (lastFaceDirection == "left") {
          texture.setTexture("left1");
        }
      }
    }
    shotTickCount--;
    if (mousePressed && shotTick.check()) {
      shot("");
    }
    if(standing){
      jumpCount = 0;
    }
    super.update();
    //rg.update();
  }
  void down(){
  }
  //-----------------------------------------------//
  //DEATH
  //-----------------------------------------------//
  void onDeath() {
    gameManager.deathPlayer(this);
  }
  void damage(float damage) {
    if (!god) {
      super.damage(damage);
    }
  }
  //-----------------------------------------------//
  //ON CONTACT WITH OTHER ENTITY
  //-----------------------------------------------//
  void onContactWithEntity(Entity entity) {

    //DOOR
    if (entity instanceof Door) {
      gameManager.nextStage();
    }
  }

  //render
  void render() {
    super.render();
    texture.render(x - 5, y);
  }
  //shot
  void shot(String direction) {
    if (mouseX > getCX()) {
      direction = "right";
    }
    else {
      direction = "left";
    }
    lastFaceDirection = direction;
    shotTickCount = 10;

    GunBallet b = new GunBallet(this);
    Point vec = Vector.getVectorToTarget(new Point(getCX(), getCY()), new Point(mouseX, mouseY), 14);
    b.setVX(vec.x);
    b.setVY(vec.y);
    b.x = getCX();
    b.y = getCY();
    manager.addEntity(b);
    SoundPlayerOrder.order.add("shot");
    //rg.launch(new Point(getCX(), getCY()), vec);
  }
  //-----------------------------------------------//
  //MOVEMENT
  //-----------------------------------------------// 
  //doJump
  void jump(float vy) {
    if (jumpCount < 2) {
      super.jump(vy);
    }
    jumpCount ++;
  }
  //stop
  void doWalkStop() {
    vx *= 0.90;
    if (abs(vx) < 1) {
      vx = 0;
    }
  }
  //left
  void walkLeft(boolean value) {
    moveLeft = value;
  }
  void doWalkLeft() {
    vx -= maxSpeed/5;
    if (vx < -maxSpeed) {
      vx = -maxSpeed;
    }
  }
  //right
  void walkRight(boolean value) {
    moveRight = value;
  }
  void doWalkRight() {
    vx += maxSpeed/5;
    if (vx > maxSpeed) {
      vx = maxSpeed;
    }
  }
}
