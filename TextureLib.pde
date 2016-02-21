class TextureLib {
  //Created By NE260090A Takumu Hayashi
  HashMap<String, PImage> textureList = new HashMap<String, PImage>();
  HashMap<String, ArrayList<String>> animationList = new HashMap<String, ArrayList<String>>();
  PImage texture;
  int animationCount = 0;
  int animationTickCount = 0;
  String tag = null;
  void addTexture(String tag, PImage image) {
    textureList.put(tag, image);
  }
  void render(float x, float y) {
    if (texture == null) {
      return;
    }
    image(texture, x, y);
  }
  void setTexture(String tag) {
    texture = textureList.get(tag);
  }
  ArrayList<String> getAnimation(String tag) {
    if (!animationList.containsKey(tag)) {
      ArrayList<String> list = new ArrayList<String>();
      animationList.put(tag, list);
      return list;
    }
    return animationList.get(tag);
  }
  void resetAnimation() {
    animationCount = 0;
    animationTickCount = 0;
  }
  void playAnimation(String tag, int tick) {
    if (this.tag != tag) {
      resetAnimation();
      animationTickCount = tick;
      this.tag = tag;
    }
    if (animationTickCount >= tick) {
      animationTickCount = 0;
      texture = textureList.get(animationList.get(tag).get(animationCount));
      animationCount++;
      if (animationCount == animationList.get(tag).size()) {
        animationCount = 0;
      }
      return;
    }
    animationTickCount++;
  }
}

