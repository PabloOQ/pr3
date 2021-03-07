ArrayList<Object> system;

AstronomicalObject test;
PImage bg;

int speed;

void setup(){
  size(1000,1000,P3D);
  
  speed = 1;
  frameRate(60);
  system = new ArrayList<Object>();

  bg = loadImage("../img/2k_stars_milky_way.jpg");
  createSystem();
}

void draw(){
  logic();
  show();
}

void logic(){
  for (int i = 0; i < speed; i++){
    calculateSystem(system);
  }
}

void keyPressed(){
  if (key == CODED){
    boolean changeSpeed = false;
    switch(keyCode){
      case DOWN:
        speed--;
        changeSpeed = true;
        break;
      case UP:
        speed++;
        changeSpeed = true;
        break;
    }
    int maxSpeed = 5;
    if (changeSpeed){
      if (speed < 0){
        speed = 0;
      }else if (maxSpeed < speed){
        speed = maxSpeed;
      }
    }
  }
}

void calculateSystem(ArrayList<Object> system){
  for (Object o : system){
    if (o instanceof AstronomicalObject){
      AstronomicalObject astro = (AstronomicalObject) o;
      astro.rotate();
      astro.orbitate();
    }else if (o instanceof ArrayList<?>){
      calculateSystem((ArrayList<Object>) o);
    }
  }
}

void show(){
  if (speed != 0){
    background(200);
    showSystem(system);
    showText();
  }
}

void showText(){
  String[] text = { "Press UP or DOWN to change the speed, minimum is x0, maximum is x5",
                    "Speed: x"+speed};
  printHUDText(text);
}

void showSystem(ArrayList<Object> system){
  translate(width/2, height/2, 0);
  for (Object o : system){
    if (o instanceof AstronomicalObject){
      AstronomicalObject astro = (AstronomicalObject) o;
      astro.display();
    }else if (o instanceof ArrayList<?>){
      showSystem((ArrayList<Object>) o);
    }
  }
}

void printHUDText(String[] text){
  camera();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
  textSize(20);
  fill(0);
  for (int i = 0; i < text.length; i++){
    text(text[i], 10, 25*(i+1));
  }
  hint(ENABLE_DEPTH_TEST);
}

void createSystem(){

  //STAR
  float r = 200;
  PVector position = new PVector(0, 0, -500);
  PVector rotation = new PVector(0.3,0.1,0.2);
  system.add(new AstronomicalObject(r, loadImage("../img/2k_sun.jpg"), position, rotation, null, null, "Nus"));


  //PLANET
  AstronomicalObject parent;
  PVector translation;
  parent = (AstronomicalObject) system.get(system.size() - 1);
  r = 30;
  position = new PVector(parent.getR() + r + 5+ 20*2 +10, 0, 0);
  rotation = new PVector(0,0,1);
  translation = new PVector(0,1,0);

  system.add(new AstronomicalObject(r, loadImage("../img/2k_mars.jpg"), position, rotation, parent, translation, "Sram"));

  //SATELLITE
  parent = (AstronomicalObject) system.get(system.size() - 1);

  r = 10;
  position = new PVector(parent.getR() + r + 5 + 5*2 +10, 0,0); 
  rotation = new PVector(0.1,0.4,1);
  translation = new PVector(0,0,0.5);
  system.add(new AstronomicalObject(r, loadImage("../img/2k_uranus.jpg"), position, rotation, parent, translation, "Sunaru"));

  //SATELLITE OF SATELLITE
  parent = (AstronomicalObject) system.get(system.size() - 1);

  r = 5;
  position = new PVector(0, parent.getR() + r + 5,0); 
  rotation = new PVector(0,360-2,0);
  translation = new PVector(360-5,2,0);
  system.add(new AstronomicalObject(r, loadImage("../img/2k_moon.jpg"), position, rotation, parent, translation, "Noom"));


  //PLANET
  parent = (AstronomicalObject) system.get(0);

  r = 20;
  position = new PVector(parent.getR() + r + 100*2 ,0,0); 
  rotation = new PVector(5,0,0.1);
  translation = new PVector(0,0.5,0.1);
  system.add(new AstronomicalObject(r, loadImage("../img/2k_mercury.jpg"), position, rotation, parent, translation, "Yrucrem"));

  //PLANET
  parent = (AstronomicalObject) system.get(0);

  r = 20;
  position = new PVector(parent.getR() + r + 100*2 +50,30,0); 
  rotation = new PVector(0,360-2,0.2);
  translation = new PVector(0,360-0.6,360-0.3);
  system.add(new AstronomicalObject(r, loadImage("../img/2k_venus_surface.jpg"), position, rotation, parent, translation, "Sunev"));

  //SATELLITE
  parent = (AstronomicalObject) system.get(system.size() - 1);

  r = 5;
  position = new PVector(0,0,parent.getR() + r + 10); 
  rotation = new PVector(0,360-0.1,0);
  translation = new PVector(0,2,360-1);
  system.add(new AstronomicalObject(r, loadImage("../img/2k_neptune.jpg"), position, rotation, parent, translation, "Enutpen"));

  //PLANET
  parent = (AstronomicalObject) system.get(0);

  r = 30;
  position = new PVector(parent.getR() + r + 100*3 +50 ,0,0); 
  rotation = new PVector(360-0.2,0.1,0.1);
  translation = new PVector(0,0.05,0);
  system.add(new AstronomicalObject(r, loadImage("../img/2k_saturn.jpg"), position, rotation, parent, translation, "Nrutas"));

  //PLANET
  parent = (AstronomicalObject) system.get(0);

  r = 50;
  position = new PVector(parent.getR() + r + 100*4 + 50 ,0,0); 
  rotation = new PVector(1,0.7,0.1);
  translation = new PVector(0,360-0.05,0);
  system.add(new AstronomicalObject(r, loadImage("../img/2k_jupiter.jpg"), position, rotation, parent, translation,"Retipuj"));
}
