PImage img;
Boolean left = false;
Boolean right = false;
Boolean jump = true;
GameManager gameManager;
CommandPrompt cp;
FrameRate fps = new FrameRate(100, 40);
SoundPlayer soundPlayer;
void setup() {
  
  Difficulty.setDifficulty("hard");
  size(1200, 600);
  background(0);
  fill(0, 0, 0);
  smooth();
  noStroke();
  frameRate(60);
  gameManager = new GameManager();
  cp = new CommandPrompt(gameManager);
  soundPlayer = new SoundPlayer(this);
  
  soundPlayer.addSound("hit", "./sounds/hit.wav");
  soundPlayer.addSound("shot", "./sounds/shot.wav");
  soundPlayer.addSound("tp", "./sounds/teleport.wav");
  //gameManager.start1Player();
}
void draw() {
  gameManager.update();
  cp.render();
  fps.render();
  for(String tag : SoundPlayerOrder.order){
    soundPlayer.play(tag);
  }
  SoundPlayerOrder.order.clear();
}
void keyPressed() {
  gameManager.keyPressed(key);
  if (keyCode == ENTER && cp.enabled) {
    cp.command();
    return;
  }
  else if (keyCode == BACKSPACE && cp.enabled) {
    cp.removeType();
    return;
  }
  else if (keyCode == TAB) {
    cp.changeEnabled();
    return;
  }
  if (cp.enabled) {
    cp.addType(key);
  }
}
void keyReleased() {
  gameManager.keyReleased(key);
}
void mousePressed(){
  gameManager.mousePressed();
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  gameManager.mouseWheel(e);
}
