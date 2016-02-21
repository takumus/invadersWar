//-----------------------------------------------//
//Stage
//-----------------------------------------------//
class Stage {
  PImage dataLayer;
  PImage spawnLayer;
  PImage decLayer;
  HashMap<Integer, String> markerColorList = new HashMap<Integer, String>();
  
  HashMap<Integer, ArrayList<Point>> spawnList = new HashMap<Integer, ArrayList<Point>>();
  Stage(PImage dataLayer, PImage spawnLayer, PImage decLayer) {
    this.dataLayer = dataLayer;
    this.decLayer = decLayer;
    this.spawnLayer = spawnLayer;
  }
  PImage getDataLayer() {
    return dataLayer;
  }
  PImage getDecLayer() {
    return decLayer;
  }
  void initialize() {
    spawnList.clear();
    noTint();
    image(spawnLayer, 0, 0);
    for (int j = 0; j < width; j+= 20) {  
      for (int i = 0; i < height; i+= 20) {  
        color c = get(j, i);
        if(c == #ffffff){
          continue;
        }
        
        ArrayList<Point> spawns;
        if(spawnList.containsKey(c)){
          spawns = spawnList.get(c);
        }else{
          spawns = new ArrayList<Point>();
        }
        spawns.add(new Point(j, i));
        spawnList.put(c, spawns);
      }
    }
  }
  ArrayList<Point> getPlayerSpawnList(){
    return spawnList.get(#ff0000);
  }
  HashMap<Integer, ArrayList<Point>> getSpawnList(){
    return spawnList;
  }
}
