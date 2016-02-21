class EntitySpawner {
  EntityManager manager;
  HashMap<Integer, ArrayList<Point>> spawnList;
  EntitySpawner(EntityManager manager) {
    this.manager = manager;
  }
  void spawnEntities(HashMap<Integer, ArrayList<Point>> spawnList) {
    this.spawnList = spawnList;
    //door
    if (spawnList.get(#CCCCCC) != null) {
      for (Point point : spawnList.get(#CCCCCC)) {
        Entity e = new Door();
        spawn(e, point);
      }
    }

    //squid
    if (spawnList.get(#00ff00) != null) {
      for (Point point : spawnList.get(#00FF00)) {
        Entity e = new Squid();
        spawn(e, point);
      }
    }

    //octopus
    if (spawnList.get(#0000ff) != null) {
      for (Point point : spawnList.get(#0000ff)) {
        Entity e = new Octopus();
        spawn(e, point);
      }
    }
    
    //octopus
    if (spawnList.get(#ffff00) != null) {
      for (Point point : spawnList.get(#ffff00)) {
        Entity e = new SquidBoss();
        spawn(e, point);
      }
    }
  }
  void spawn(Entity e, Point p) {
    e.setX(p.x - e.getWidth()/2);
    e.setY(p.y - e.getHeight());
    manager.addEntity(e);
  }
}
