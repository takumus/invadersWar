static class Difficulty{
  static String _type = "normal";
  static void setDifficulty(String type){
    _type = type;
  }
  static String getDifficulty(){
    return _type;
  }
}
