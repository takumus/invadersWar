//-----------------------------------------------//
//EntityClass
//-----------------------------------------------//
class Entity{
  //pos
  float x, y = 0;
  //velocity
  float vx = 0;
  float vy = 0;
  int w, h;
  EntityManager manager = null;
  HashMap<Integer, Boolean> contactingColorList = new HashMap<Integer, Boolean>();
  ArrayList<Entity> hitEntity = new ArrayList<Entity>();
  ArrayList<Point> pointHistory =  new ArrayList<Point>();
  boolean removed = false;
  Entity(int w, int h){
    this.w = w;
    this.h = h;
  }
  void render() {
  }
  void update(){
    contactingColorList.clear();
    y += vy;
    x += vx;
    checkContactingEntities();
    addHistory(getCX(), getCY());
  }
  void removeEntity() {
    manager.removeEntity(this);
  }
  void setManager(EntityManager manager) {
    this.manager = manager;
  }
  void addHistory(float x, float y) {
    pointHistory.add(new Point(x, y));
    if (pointHistory.size() > 60 * 2) {
      pointHistory.remove(0);
    }
  }
  Point getPointFromHistory(int frame) {
    if (pointHistory.size() < 1) {
      return getPoint();
    }
    int index = pointHistory.size() - frame - 1;
    if (index < 0) {
      index = 0;
    }
    return pointHistory.get(index);
  }
  boolean getContacting(float x, float y, color... c) {
    color cc = get(floor(x), floor(y));
    contactingColorList.put(cc, true);
    for (int i = 0; i < c.length; i ++) {
      if (cc == c[i]) {
        return true;
      }
    }
    return false;
  }
  boolean contactWithColor(color c) {
    return contactingColorList.containsKey(c);
  }
  boolean hitTestEntity(Entity entity1, Entity entity2) {
    if (entity1.getX() + entity1.getWidth() < entity2.getX()) {
    }
    else if (entity1.getY() + entity1.getHeight() < entity2.getY()) {
    }
    else if (entity2.getX() + entity2.getWidth() < entity1.getX()) {
    }
    else if (entity2.getY() + entity2.getHeight() < entity1.getY()) {
    }
    else {
      return true;
    }
    return false;
  }
  void checkContactingEntities() {
    hitEntity.clear();
    for (Entity entity : new HashMap<Entity, Boolean> (manager.getEntityList ()).keySet()) {
      if (entity == this) {
        continue;
      }
      
      if (hitTestEntity(this, entity)) {
        hitEntity.add(entity);
        onContactWithEntity(entity);
      }
    }
  }
  void onContactWithEntity(Entity entity) {
  }
  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  Point getPoint() {
    return new Point(x, y);
  }
  float getCX() {
    return x + w/2;
  }
  float getCY() {
    return y + h/2;
  }
  float getVX() {
    return vx;
  }
  float getVY() {
    return vy;
  }
  int getWidth() {
    return w;
  }
  int getHeight() {
    return h;
  }
  void setPoint(Point point) {
    setX(point.x);
    setY(point.y);
  }
  //setter
  void setX(float x) {
    this.x = x;
    //px = x;
  }
  void setY(float y) {
    this. y = y;
    //py = y;
  }
  void setVX(float vx) {
    this.vx = vx;
  }
  void setVY(float vy) {
    this.vy = vy;
  }
}
class PhysicalEntity extends Entity{

  float mvy = 0;
  float py = 0;
  float px = 0;
  //float
  //
  boolean standing = false;
  boolean head = false;
  //
  int legH;
  //
  boolean wall = false;
  //
  float g = 0.4;
  float f = 0.98; 
  //
  boolean hitGround = false;
  //
  boolean vLimit = true;
  //
  String willFallDirection = "none";
  String wallDirection = "none";
  //
  PhysicalEntity(int w, int h) {
    super(w, h);
    this.w = w;
    this.h = h;
    legH = floor(h*0.2);
  }
  void render() {
  }
  void update() {
    super.update();
    hitGround = false;
    wall = false;
    willFallDirection = "none";
    wallDirection = "none";
    if (!standing) {
      vy += g;
    }else{
      vx *= f;
    }
    if (vy > legH && vLimit) {
      vy = legH;
    }
    mvy = y - py;
    py = y;
    px = x;
    
    float uy = y;
    if (vx < 0) {
      if (vy > 0) {
        for (int i = 0; i < w; i ++) {
          if (getContacting(x + i, y, #000000)) {
            x = x + i - vx;
            wall = true;
          }
        }
      }
      for (int i = 0; i < w; i ++) {
        if (getContacting(x + i, y + h - legH - 1, #000000)) {
          x = x + i - vx;
          wall = true;
        }
      }
      if (wall) {
        wallDirection = "left";
      }
    } 
    else {
      if (vy > 0) {
        for (int i = 0; i < w; i ++) {
          if (getContacting(w + x - i, y, #000000)) {
            x = x - i - vx;
            wall = true;
          }
        }
      }
      for (int i = 0; i < w; i ++) {
        if (getContacting(w + x - i, y + h - legH - 1, #000000)) {
          x = x - i - vx;
          wall = true;
        }
      }
      if (wall) {
        wallDirection = "right";
      }
    }
    if (wall) {
      vx = 0;
    }
    if (standing) {
      //----------------------------------//
      //standing
      //----------------------------------//
      standing = false;
      float luy = uy;
      float ruy = uy;
      boolean hitLeft = false;
      boolean hitRight = false;
      //LEFT
      for (int i = -legH; i < legH; i ++) {
        if (getContacting(x, y + i + h, #000000, #CCCCCC)) {
          luy = y + i;// + h;
          standing = true;
          hitLeft = true;
          willFallDirection = "right";
          break;
        }
      }
      //RIGHT
      for (int i = -legH; i < legH; i ++) {
        if (getContacting(x + w, y + i + h, #000000, #CCCCCC)) {
          ruy = y + i;
          standing = true;
          hitRight = true;
          willFallDirection = "left";
          break;
        }
      }
      if (hitLeft && hitRight) {
        willFallDirection = "none";
        uy = ruy<luy ? ruy:luy;
      } 
      else {
        if (hitLeft) {
          uy = luy;
        } 
        else if (hitRight) {
          uy = ruy;
        }
        //vy = mvy;
      }
    } 
    else {
      //----------------------------------//
      //FLYING
      //----------------------------------//
      if (vy > 0) {
        float luy = uy;
        float ruy = uy;
        //LEFT
        for (int i = 0; i < vy; i ++) {
          if (getContacting(x, y - i + h, #000000, #CCCCCC)) {
            luy = y - i;
            standing = true;
          }
        }
        //RIGHT
        for (int i = 0; i < vy; i ++) {
          if (getContacting(x + w, y - i + h, #000000, #CCCCCC)) {
            ruy = y - i;
            standing = true;
          }
        }
        uy = ruy<luy ? ruy:luy;
      } 
      else if (vy < 0) {
        float luy = uy;
        float ruy = uy;
        for (int i = 0; i < -vy; i ++) {
          if (getContacting(x, y - i, #000000)) {
            luy = y + i;
            head = true;
          }
        }
        for (int i = 0; i < -vy; i ++) {
          if (getContacting(x + w, y - i, #000000)) {
            ruy = y + i;
            head = true;
          }
        }
        if (head) {
          uy = ruy>luy ? ruy:luy;
          vy = -vy;
        }
      }
    }
    if (standing) {
      y = uy;
      vy = 0;
    }
    //println(contactingColorList);
    hitGround = head || standing || wall;
    head = false;
  }
  boolean getStanding() {
    return standing;
  }
  //getter
  float getVXToEntity(Entity target, float v) {
    return target.getCX() - getCX();
  }
  float getVYToEntity(Entity target, float v) {
    return 0;
  }
  String getWallDirection() {
    return wallDirection;
  }
  String getWillFallDirection() {
    return willFallDirection;
  }
  String getDeadEndDirection() {
    if (wallDirection != "none") {
      return wallDirection;
    }
    if (willFallDirection != "none") {
      return willFallDirection;
    }
    return "none";
  }
  void setG(float g) {
    this.g = g;
  }
  void setF(float f) {
    this.f = 1 - f;
  }
}

