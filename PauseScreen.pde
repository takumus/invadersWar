class PauseScreen {
  Button remuseButton;
  Button quitButton;
  boolean enabled = false;
  GameManager gameManager;
  PauseScreen(GameManager gameManager) {
    this.gameManager = gameManager;
    
    remuseButton = new RemuseButton();
    quitButton = new QuitButton();
    
    remuseButton.setX(520);
    remuseButton.setY(188);
    
    quitButton.setX(520);
    quitButton.setY(280);
  }
  void render() {
    if(!enabled){
      return;
    }
    fill(0, 200);
    rect(0, 0, width, height);
    noFill();
    remuseButton.update();
    remuseButton.render();
    quitButton.update();
    quitButton.render();
    
    if(remuseButton.pressed){
      gameManager.remuse();
    }
    if(quitButton.pressed){
      gameManager.gameStop();
      hide();
    }
  }
  void show() {
    enabled = true;
  }
  void hide() {
    enabled = false;
  }
}

