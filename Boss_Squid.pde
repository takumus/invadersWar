class SquidBoss extends Monster {
  TextureLib texture = new TextureLib();
  Tick shotTick = new Tick(23, true, true);
  int squidShotTick = 20;
  Tick modeTick = new Tick(60*3, false, true);
  Tick jumpTick = new Tick(60*3, false, false);
  int modeCount = 0;
  boolean shotMiniSquid = false;
  String[] modeList = {
    "none", "shot", "squid"
  };
  String mode = "shot";
  SquidBoss() {
    super(120, 120, 1600);

    //Difficulty
    if (Difficulty.getDifficulty().equals("hard")) {
      modeTick = new Tick(60*1, false, true);
      squidShotTick = 10;
      shotTick = new Tick(6, true, true);
    }

    knockBack = false;
    texture.addTexture("walk1", loadImage("./texture/character/squidBoss/walk1.png"));
    texture.addTexture("walk2", loadImage("./texture/character/squidBoss/walk2.png"));
    texture.addTexture("squid1", loadImage("./texture/character/squidBoss/angry1.png"));
    texture.addTexture("squid2", loadImage("./texture/character/squidBoss/angry2.png"));

    texture.getAnimation("walk").add("walk1");
    texture.getAnimation("walk").add("walk2");

    texture.getAnimation("squid").add("squid1");
    texture.getAnimation("squid").add("squid2");
    texture.setTexture("walk1");
    setVX(1);
  }
  void update() {
    super.update();

    if (getWallDirection() == "right") {
      setVX(-1);
    }
    else if (getWallDirection() == "left") {
      setVX(1);
    }
    if (modeTick.check()) {
      mode = modeList[modeCount];
      modeCount++;
      if (modeCount == modeList.length) {
        modeCount = 0;
      }
    }
    if (jumpTick.check()) {
      jump(10);
    }
    if (mode == "shot") {
      if (shotTick.check()) {
        for (Player p : manager.getPlayerList().keySet()) {
          SquidBossBallet b = new SquidBossBallet(this);
          b.setX(getCX());
          b.setY(getCY());
          b.goToEntity(p, 10, 20);
          manager.addEntity(b);
        }
      }
    } 
    else if (mode == "squid") {
      if (texture.animationCount == 1) {
        if (!shotMiniSquid) {
          shotMiniSquid = true;
          for (Player p : manager.getPlayerList().keySet()) {
            Point vec = Vector.getVectorToTarget(new Point(getCX(), getCY()), p.getPointFromHistory(0), 10);
            MiniSquid s = new MiniSquid();
            s.setX(getCX() - s.getWidth()/2);
            s.setY(getY());
            s.setVX(vec.x*random(0.1, 1));
            s.setVY(-random(8, 10));
            manager.addEntity(s);
          }
        }
      } 
      else {
        shotMiniSquid = false;
      }
    } 
    else {
    }
  }
  void onDeath() {
    Door door = new Door();
    door.setX(getCX());
    door.setY(getCY());
    manager.addEntity(door);
  }
  void render() {
    super.render();
    texture.render(getX(), getY());
    if (mode == "shot") {
      texture.playAnimation("walk", 20);
    } 
    else if (mode == "squid") {
      texture.playAnimation("squid", squidShotTick);
    }
    else if (mode == "none") {
      texture.playAnimation("walk", 20);
    }
  }
}
class MiniSquid extends Monster {
  TextureLib texture = new TextureLib();
  Tick shotTick = new Tick(60 * 2, true, false);
  MiniSquid() {
    super(40, 40, 1);
    setF(0.1);
    texture.addTexture("walk1", loadImage("./texture/character/squid/walk1.png"));
    texture.addTexture("walk2", loadImage("./texture/character/squid/walk2.png"));
    texture.getAnimation("walk").add("walk1");
    texture.getAnimation("walk").add("walk2");
    texture.setTexture("walk1");

    setVX(3);
  }
  void update() {
    super.update();

    if (getWallDirection() == "right") {
      setVX(-3);
    }
    else if (getWallDirection() == "left") {
      setVX(3);
    }
    if (shotTick.check()) {
      for (Player p : manager.getPlayerList().keySet()) {
        SquidBallet b = new SquidBallet(this);
        b.setX(getCX());
        b.setY(getCY());
        b.goToEntity(p, 20, 10);
        manager.addEntity(b);
      }
    }
  }
  void onContactWithCreature(Creature creature) {
    if (!(creature instanceof Monster)) {
    }
  }
  void render() {
    super.render();
    texture.render(getX(), getY());
    texture.playAnimation("walk", 20);
  }
}
//-----------------------------------------------//
//GunBallet
//-----------------------------------------------//
class SquidBossBallet extends Bullet {
  SquidBossBallet(Entity shooter) {
    super(shooter, #FF0099, 1, 1);
  }
  void onHitToCreature(Creature creature) {
    if (!(creature instanceof Monster)) {
      creature.damage(40);
      playHitEffect(creature);
    }
  }
  void render() {
    //super.render();
    fill(#FF0099);
    stroke(#FF0099);
    strokeWeight(8);
    for (int i = 0; i < 5; i ++) {
      Point p1 = getPointFromHistory(i);
      Point p2 = getPointFromHistory(i + 1);
      line(p1.x + random(-3, 3), p1.y + random(-3, 3), p2.x + random(-3, 3), p2.y + random(-3, 3));
    }
    noStroke();
  }
}

