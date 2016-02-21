class GameManager {
  int stageCount = 1;
  Stage stage;
  EntityManager entityManager = new EntityManager();
  EntitySpawner entitySpawner = new EntitySpawner(entityManager);
  Player player1 = new Player(this);
  Player player2 = new Player(this);
  String status = "none";
  String mode = "none";
  Fader fader = new Fader();
  PauseScreen pauseScreen = new PauseScreen(this);
  StartScreen startScreen = new StartScreen(this);
  boolean pauseing = false;
  void startGame() {
    PImage dataLayer = loadImage("./stages/" + mode + "/" + stageCount + "/data.png");
    PImage spawnLayer = loadImage("./stages/" + mode + "/" + stageCount + "/spawn.png");
    PImage decLayer = loadImage("./stages/" + mode + "/" + stageCount + "/dec.png");

    if (dataLayer == null) {
      gameStop();
      return;
    }
    fader.fadeIn();
    status = "playing";
    pauseing = false;

    entityManager.removeAll();

    stage = new Stage(dataLayer, spawnLayer, decLayer);
    stage.initialize();

    entitySpawner.spawnEntities(stage.getSpawnList());

    //spawn
    entityManager.addPlayer(player1);
    player1.setPoint(stage.getPlayerSpawnList().get(0));
    player1.setMaxHealth();
    if (mode == "2player") {
      entityManager.addPlayer(player2);
      player2.setPoint(stage.getPlayerSpawnList().get(1));
      player2.setMaxHealth();
    }
    //set point
  }
  void start1Player(int stage) {
    stageCount = stage;
    mode = "1player";

    startGame();
  }
  void start2Player(int stage) {
    stageCount = stage;
    mode = "2player";

    startGame();
  }
  void nextStage() {
    if (status == "playing") {
      stageCount++;
      status = "waiting";
      SoundPlayerOrder.order.add("tp");
      fader.fadeOut();
    }
  }
  void restartStage() {
    if (status == "playing") {
      status = "waiting";
      fader.fadeOut();
    }
  }
  void update() {
    if (status == "waiting") {
      if (fader.complete) {
        startGame();
      }
    }

    if (status != "none") {
      //redner DATA
      noTint();
      image(stage.getDataLayer(), 0, 0);
      if (!pauseing) {
        entityManager.update();
        ParticleManager.updateFPS(frameRate);
        ParticleManager.update();
        if (!focused) {
          pauseing = true;
          pauseScreen.show();
          player1.walkLeft(false);
          player1.walkRight(false);
        }
      }

      //render DECORATION
      image(stage.getDecLayer(), 0, 0);
      entityManager.render();
      ParticleManager.render();
    }
    startScreen.render();
    pauseScreen.render();
    fader.render();
  }
  void gameStop() {
    startScreen.enabled = true;
    status = "none";
    mode = "none";
  }
  void addEntity(Entity entity) {
    entityManager.addEntity(entity);
  }
  void deathPlayer(Player player) {
    println("GAME OVER");
    restartStage();
  }
  void pause() {
    pauseing = true;
    pauseScreen.show();
  }
  void remuse() {
    pauseing = false;
    pauseScreen.hide();
  }
  //-----------------------------------------------//
  //KeyController
  //-----------------------------------------------//
  void mousePressed() {
    if (status != "playing") {
      return;
    }
    player1.shot("");
  }
  void mouseWheel(float v) {
  }
  void keyPressed(char key) {
    if (status != "playing") {
      return;
    }
    //pause
    if (key == 'p') {
      pauseing = !pauseing;
      if (pauseing) {
        pauseScreen.show();
      }
      else {
        pauseScreen.hide();
      }
    }
    if (pauseing) {
      return;
    }

    //Player 01
    if (key == 'w' || key == ' ') {
      player1.jump(10);
    }
    if (key == 'a') {
      player1.walkLeft(true);
    }
    if (key == 'd') {
      player1.walkRight(true);
    }
    if (key == 'f') {
      //player1.shot("right");
    }
    if (key == 'd') {
      //player1.shot("left");
    }

    if (entityManager.getPlayerList().size()<2) {
      return;
    }

    //Player 02
    if (key == 'w') {
      // player2.jump(10);
    }
    if (key == 'a') {
      // player2.walkLeft(true);
    }
    if (key == 'd') {
      // player2.walkRight(true);
    }
    if (key == 'l') {
      // player2.shot("right");
    }
    if (key == 'k') {
      //  player2.shot("left");
    }
  }
  void keyReleased(char key) {
    if (status == "none") {
      return;
    }

    //Player1
    if (key == 'a') {
      player1.walkLeft(false);
    }
    if (key == 'd') {
      player1.walkRight(false);
    }

    if (entityManager.getPlayerList().size()<2) {
      return;
    }

    //Player2
    if (key == 'y') {
      //player2.walkLeft(false);
    }
    if (key == 'i') {
      //player2.walkRight(false);
    }
  }
}

