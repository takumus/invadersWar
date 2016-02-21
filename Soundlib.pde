import ddf.minim.*; 
static class SoundLib{
  static HashMap<String, AudioPlayer> soundList = new HashMap<String, AudioPlayer>();
  Minim minim;
  static void addPlayer(String tag, AudioPlayer player){
    soundList.put(tag, player);
  }
  static void play(String tag){
    soundList.get(tag).play();
  }
}
