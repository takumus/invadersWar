class StartScreen {
  PImage background = loadImage("./texture/screen/startScreen.png");
  Button normalButton = new StartButton("normal");
  Button hardButton = new StartButton("hard");
  GameManager gameManager;
  boolean enabled = true;
  Fader fader = new Fader();
  StartScreen(GameManager gameManager) {
    this.gameManager = gameManager;

    normalButton.setX(500);
    normalButton.setY(188);

    hardButton.setX(500);
    hardButton.setY(245);
  }
  void render() {
    if (!enabled) {
      return;
    }

    image(background, 0, 0);

    normalButton.update();
    hardButton.update();
    normalButton.render();
    hardButton.render();
    if (normalButton.pressed) {
      Difficulty.setDifficulty("normal");
      fader.fadeOut();
    }
    if (hardButton.pressed) {
      Difficulty.setDifficulty("hard");
      fader.fadeOut();
    }
    fader.render();
    if (fader.complete) {
      enabled = false;
      fader.reset();
      gameManager.start1Player(1);
    }
  }
}

