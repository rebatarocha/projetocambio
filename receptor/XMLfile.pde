class XMLfile{
  boolean xmlsaved = false;
  XML xml;
  String path;
  PApplet sketch;
  
  XMLfile(String path_, PApplet sketch_){
    sketch = sketch_;
    path = path_;
    selectFile(path);
  }
  
  void addNode(String s){
    XML newNode = parseXML(s);
    xml.addChild(newNode);
  }
  
  void addEntry(String title, String audio, String image, String bpm){
    String out = 
    "<Interaction>"+
      "<title>"+title+"</title>"+
      "<audio>"+audio+"</audio>"+
      "<image>"+image+"</image>"+
      "<bpm>"+bpm+"</bpm>"+
    "</Interaction>";
    addNode(out);
  }
  
  void selectFile(String p){
    xml = loadXML(p);
  }
  
  void saveXml(){
    saveXML(xml, path);
  }
  
  int countInteractions(){
    return xml.getChildren("Interaction").length;
  }
  
  XML[] getInteractions(){
    return xml.getChildren("Interaction");
  }
}