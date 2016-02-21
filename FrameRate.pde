class FrameRate{
  float x = 0;
  float y = 0;
  float w;
  float h;
  int fontSize = 20;
  ArrayList<Float> fpsLog = new ArrayList<Float>();
  //PFont font = createFont("Consolas", fontSize);
  FrameRate(float w, float h){
    this.w = w;
    this.h = h;
  }
  void render(){
    fpsLog.add(0, frameRate);
    if(fpsLog.size() > w + 1){
      fpsLog.remove(fpsLog.size() - 1);
    }
    graph();
  }
  void graph(){
    fill(#000000, 160);
    rect(x, y, w, h);
    fill(#ffffff, 160);
    beginShape();
    vertex(x, h);
    int i = 0;
    if(fpsLog.size() > 1){
      for(float fps : fpsLog){
        float ty = (h - (fps/70)*h) + y;
        float tx = float(i);
        vertex(tx, ty);
        i ++;
      }
    }
    vertex(w, h);
    endShape();
    fill(#333333);
    //textFont(font, fontSize);
    String str = Float.toString(frameRate).substring(0, 2) + "/60fps";
    text(str, w/2 - textWidth(str)/2 , h/2 - fontSize/2 + fontSize);
  }
  void setX(float x){
    this.x = x;
  }
  void setY(float y){
    this.y = y;
  }
}