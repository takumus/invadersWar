//-----------------------------------------------//
//GunBallet
//-----------------------------------------------//
class OctopusBallet extends Bullet {
  OctopusBallet(Entity shooter) {
    super(shooter, #9900FF, 1, 1);
  }
  void onHitToCreature(Creature creature) {
    if (!(creature instanceof Monster)) {
      creature.damage(5);
      playHitEffect(creature);
    }
  }
  void render() {
    super.render();
  }
}
//-----------------------------------------------//
//GunBallet
//-----------------------------------------------//
class SquidBallet extends Bullet {
  SquidBallet(Entity shooter) {
    super(shooter, #ff00ff, 1, 1);
  }
  void onHitToCreature(Creature creature) {
    if (!(creature instanceof Monster)) {
      creature.damage(16);
      playHitEffect(creature);
    }
  }
  void render() {
    super.render();
  }
}
//-----------------------------------------------//
//GunBallet
//-----------------------------------------------//
class GunBallet extends Bullet {
  GunBallet(Entity shooter) {
    super(shooter, #0099FF, 1, 1);
  }
  void onHitToCreature(Creature creature) {
    creature.damage(10);
    playHitEffect(creature);
    SoundPlayerOrder.order.add("hit");
  }
  void render() {
    super.render();
  }
}

//-----------------------------------------------//
//BulletClass
//-----------------------------------------------//
class Bullet extends Entity {
  Entity shooter;
  CircleParticle firework;
  Smoke smoke;
  color c;
  Bullet(Entity shooter, color c, int w, int h) {
    super(w, h);
    firework = new CircleParticle(c, 1, 4, 0.2, 20);
    smoke = new Smoke(c, 1, 2, 0, 5);
    this.c = c;
    this.shooter = shooter;
  }
  void update() {
    super.update();
    Point prevPoint = getPointFromHistory(1);
    getContacting(getCX(), getCY());
    if (contactWithColor(0) || contactWithColor(#000000)) {
      removeEntity();
      firework.launch(prevPoint.x, prevPoint.y);
      return;
    }
  }
  void goToEntity(Entity target, float velocity, int delay) {
    Point vec = Vector.getVectorToTarget(new Point(getCX(), getCY()), target.getPointFromHistory(delay), velocity);
    setVX(vec.x);
    setVY(vec.y);
  }
  void onContactWithEntity(Entity entity) {
    if (this.shooter == entity) {
      return;
    }
    if (entity instanceof Bullet) {
      return;
    }

    if (entity instanceof Creature) {
      Creature creature = (Creature)entity;
      onHitToCreature(creature);
      //entity.setVY(entity.getVY() + getVY()*0.2);
    }
  }
  void onHitToCreature(Creature entity) {
  }
  void playHitEffect(Creature creature) {
    removeEntity();
    firework.launch(x, y);
    //cast to  creature
    if (creature.getStanding() && creature.knockBack) {
      creature.setVX(creature.getVX() + getVX()*0.5);
      creature.jump(3);
    }  
  }
  void render() {
    stroke(c);
    strokeWeight(4);
      Point p1 = getPointFromHistory(0);
      Point p2 = getPointFromHistory(2);
      line(p1.x + random(-3, 3), p1.y + random(-3, 3), p2.x + random(-3, 3), p2.y + random(-3, 3));
    
    smoke.launch(getCX(), getCY());
    noStroke();
  }
}

