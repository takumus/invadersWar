class RailGun{
  EntityManager manager;
  ArrayList<ArrayList<Laser>> laserList = new ArrayList<ArrayList<Laser>>();
  Entity shooter;
  RailGun(Entity shooter, EntityManager manager){
    this.manager = manager;
    this.shooter = shooter;
  }
  void launch(Point from, Point vec){
    float x = from.x;
    float y = from.y;
    ArrayList<Laser> lasers = new ArrayList<Laser>();
    for(int i = 0; i < 30; i ++){
      Laser l = new Laser(this, shooter, new Point(x, y), new Point(x + vec.x, y + vec.y));
      manager.addEntity(l);
      lasers.add(l);
      //l.setX(x);
      //l.setY(x);
      x += vec.x;
      y += vec.y;
    }
    laserList.add(lasers);
  }
  void damageToCreature(Creature c, float damage){
    
  }
  void update(){
    for(ArrayList<Laser> lasers : laserList){
      boolean startRemove = false;
      boolean damaged = false;
      for(int i = 0; i < lasers.size(); i ++){
        lasers.get(i).lupdate();
        if(lasers.get(i).target != null && !damaged){
            lasers.get(i).target.damage(0.3);
            damaged = true;
          }
        if(lasers.get(i).removed){
          startRemove = true;
        }
        if(startRemove){
          lasers.get(i).removeEntity();
          lasers.remove(i);
          i--;
        }
      }
    }
  }
}
class Laser extends Bullet{
  Point from;
  Point to;
  int life = 30;
  RailGun parent;
  int id = 0;
  Creature target;
  Laser(RailGun parent, Entity shooter, Point from, Point to){
    super(shooter, #ff0000, 1, 1);
    setPoint(to);
    this.from = from;
    this.to = to;
    this.parent = parent;
  }
  void lupdate(){
    life --;
    super.update();
    getContacting(getCX(), getCY());
    if (contactWithColor(0) || contactWithColor(#000000)) {
      removeEntity();
      return;
    }
    if(life < 0){
      removeEntity();
      println(this);
    }
    super.update();
  }
  void onHitToCreature(Creature c) {
    target = c;
  }
  void render(){
    stroke(#ff0000);
    strokeWeight(8);
    line(from.x + random(-3, 3), from.y + random(-3, 3), to.x + random(-3, 3), to.y + random(-3, 3));
    noStroke();
    //super.render();
  }
}
