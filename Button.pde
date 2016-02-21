class QuitButton extends Button {
  TextureLib textureLib = new TextureLib();
  QuitButton() {
    super(185, 35);
    textureLib.addTexture("1", loadImage("./texture/button/quit/quit1.png"));
    textureLib.addTexture("2", loadImage("./texture/button/quit/quit2.png"));
    
    textureLib.getAnimation("flash").add("1");
    textureLib.getAnimation("flash").add("2");
  }
  void rollOver() {
    textureLib.playAnimation("flash", 3);
  }
  void rollOut() {
    textureLib.setTexture("1");
  }
  void render() {
    textureLib.render(x, y);
  }
}

class RemuseButton extends Button {
  TextureLib textureLib = new TextureLib();
  RemuseButton() {
    super(185, 35);
    textureLib.addTexture("1", loadImage("./texture/button/resume/resume1.png"));
    textureLib.addTexture("2", loadImage("./texture/button/resume/resume2.png"));
    
    textureLib.getAnimation("flash").add("1");
    textureLib.getAnimation("flash").add("2");
  }
  void rollOver() {
    textureLib.playAnimation("flash", 3);
  }
  void rollOut() {
    textureLib.setTexture("1");
  }
  void render(){
    textureLib.render(x, y);
  }
}

class StartButton extends Button {
  TextureLib textureLib = new TextureLib();
  StartButton(String d) {
    super(185, 35);
    textureLib.addTexture("1", loadImage("./texture/button/start/" + d + "1.png"));
    textureLib.addTexture("2", loadImage("./texture/button/start/" + d + "2.png"));
    
    textureLib.getAnimation("flash").add("1");
    textureLib.getAnimation("flash").add("2");
  }
  void rollOver() {
    textureLib.playAnimation("flash", 3);
  }
  void rollOut() {
    textureLib.setTexture("1");
  }
  void render() {
    textureLib.render(x, y);
  }
}

class Button {
  float w;
  float h;
  float x;
  float y;
  boolean pressed;
  Button(float w, float h) {
    this.w = w;
    this.h = h;
  }
  void rollOver() {
  }
  void rollOut() {
  }
  void press() {
  }
  void setX(float x) {
    this.x = x;
  }
  void setY(float y) {
    this.y = y;
  }
  void update() {
    pressed = false;
    if (this.x < mouseX && this.x + w > mouseX && this.y < mouseY && this.y + h > mouseY) {
      if (mousePressed) {
        pressed = true;
        press();
      }
      else {
        rollOver();
      }
    }
    else {
      rollOut();
    }
  }
  boolean getPressed() {
    return pressed;
  }
  void render() {
  }
}

