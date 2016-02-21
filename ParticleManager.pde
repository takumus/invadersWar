//-----------------------------------------------//
//ParticleManager
//-----------------------------------------------//
static class ParticleManager {
  static HashMap<Particle, Boolean> particleList = new HashMap<Particle, Boolean>();
  static Stage stage;
  static int max = 300;
  static float fps = 60;
  static int size;
  static void addParticle(Particle particle) {
    //particle.setManager(this);
    particleList.put(particle, true);
    int i = 0;
    if (particleList.size() > max) {
      for (Particle p : new HashMap<Particle, Boolean> (particleList).keySet()) {
        removeParticle(p);
        i++;
        if(i > 3){
          return;
        }
      }
    }
  }
  static void setStage(Stage stage) {
    //this.stage = stage;
  }
  static void removeParticle(Particle particle) {
    particleList.remove(particle);
    particle = null;
  }
  static void updateFPS(float _fps){
    fps = _fps;
  }
  static void update() {
     if(fps < 58){
      max -= 10;
      if(max < 0){
        max = 0;
      }
    }else{
      if(particleList.size() >= max){
        max += 100;
      }
    }
    //image(stage.getDataLayer(), 0, 0);
    for (Particle particle : new HashMap<Particle, Boolean> (particleList).keySet()) {
      particle.update();
    }
    println(max);
  }
  static void render() {
    for (Particle particle : particleList.keySet ()) {
      particle.render();
    }
  }
}

