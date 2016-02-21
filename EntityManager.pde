//-----------------------------------------------//
//EntityManager
//-----------------------------------------------//
class EntityManager {
  HashMap<Entity, Boolean> entityList = new HashMap<Entity, Boolean>();
  HashMap<Player, Boolean> playerList = new HashMap<Player, Boolean>();
  
  void addEntity(Entity entity) {
    entity.setManager(this);
    entityList.put(entity, true);
  }
  
  void addPlayer(Player player){
    addEntity(player);
    playerList.put(player, true);
  }
  
  void removeEntity(Entity entity) {
    entityList.remove(entity);
    playerList.remove(entity);
    entity.removed = true;
    entity = null;
  }
  
  void removeAll(){
    for (Entity entity : new HashMap<Entity, Boolean> (entityList).keySet()) {
      removeEntity(entity);
    }
    entityList.clear();
    playerList.clear();
  }
  void update() {
    for (Entity entity : new HashMap<Entity, Boolean> (entityList).keySet()) {
      entity.update();
    }
  }
  void render() {
    for (Entity entity : entityList.keySet ()) {
      entity.render();
    }
  }
  HashMap<Entity, Boolean> getEntityList() {
    return entityList;
  }
  HashMap<Player, Boolean> getPlayerList() {
    return playerList;
  }
}

