class CommandPrompt{
  ArrayList<String> log = new ArrayList<String>();
  int maxLine = 10;
  int fontSize = 20;
  PFont font = createFont("Consolas", fontSize);
  String type = "";
  GameManager gameManager;
  boolean enabled = false;
  CommandPrompt(GameManager gameManager){
    this.gameManager = gameManager;
  }
  void render(){
    if(!enabled){
      return;
    }
    gameManager.pauseScreen.enabled = false;
    fill(#000000, 160);
    rect(0, height - fontSize * (maxLine + 2), width, fontSize * (maxLine + 2));
    rect(0, height - fontSize * 1.6, width, fontSize * 1.6);
    
    fill(#ffffff);
    
    textFont(font, fontSize);
    text(">" + type + "_", 5, height - fontSize*0.6);
    
    for(int i = 0; i < log.size(); i ++){
      text(log.get(i), 5, height - i * fontSize - fontSize * 2);
    }
    noFill();
  }
  
  void command(){
    String result = "command not found";
    String[] args = split(type, " ");
    if(args[0].equals("start")){
        if(args[1] != null){
          gameManager.startScreen.enabled = false;
          gameManager.start1Player(int(args[1]));
          gameManager.fader.reset();
          result = "started '1Player' on stage " + args[1];
        }
    }else if(args[0].equals("next")){
      gameManager.stageCount++;
      gameManager.start1Player(gameManager.stageCount);
      gameManager.fader.reset();
      result = "started next stage";
    }else if(args[0].equals("framerate")){
      frameRate(int(args[1]));
      result = "frameRate has been changed (" + args[1] + "fps)";
    }else if(args[0].equals("killall")){
      gameManager.entityManager.removeAll();
      result = "all creatures have been killed";
      gameManager.entityManager.addPlayer(gameManager.player1);
      if(gameManager.mode == "2"){
        gameManager.entityManager.addPlayer(gameManager.player2);
      }
    }else if(args[0].equals("god")){
      if(boolean(args[1])){
        gameManager.player1.god = true;
        gameManager.player2.god = true;
        result = "godMode has been enabled";
      }else{
        gameManager.player1.god = false;
        gameManager.player2.god = false;
        result = "godMode has been disabled";
      }
    }else if(args[0].equals("force2player")){
      gameManager.entityManager.addPlayer(gameManager.player2);
      gameManager.player2.setX(gameManager.player1.x);
      gameManager.player2.setY(gameManager.player1.y);
      gameManager.mode = "2";
      result = "added player2";
    }
    
    addLog(result);
    type = "";
  }
  void addType(char c){
    type += c;
  }
  void removeType(){
    if(type.length() < 1){
      return;
    }
    type = type.substring(0, type.length() - 1);
  }
  void addLog(String str){
    log.add(0, str);
    if(log.size() > maxLine){
      log.remove(log.size()-1);
    }
  }
  void keyPressed(String key) {
  }
  void changeEnabled(){
    enabled = !enabled;
  }
}
