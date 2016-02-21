import ddf.minim.*; 
Minim minim;
HashMap<String, AudioPlayer> playerList = new HashMap<String, AudioPlayer>();

class SoundPlayer{
  SoundPlayer(PApplet p){
    minim = new Minim(p);
  }
  void addSound(String tag, String path){
    playerList.put(tag, minim.loadFile(path));
  }
  void play(String tag){
    playerList.get(tag).rewind();
    playerList.get(tag).play();
  }
}
