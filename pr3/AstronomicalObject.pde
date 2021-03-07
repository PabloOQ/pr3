class AstronomicalObject{
  float r;
  PVector position;                 //Relative position
  PVector rotation;
  PVector translation;
  AstronomicalObject orbitalOrigin; //Moving astro
  PVector orbitalOriginPoint;       //Fixed point
  PShape shape;
  String name;

  AstronomicalObject(float r, PImage texture, PVector position, PVector rotation, Object orbitalOrigin, PVector translation, String name){
    this.r = r;
    this.position = position.copy();
    this.rotation = rotation.copy();
    if (translation != null){
      this.translation = translation.copy();
    }

    if (orbitalOrigin instanceof AstronomicalObject){
      this.orbitalOrigin = (AstronomicalObject) orbitalOrigin;
    }else if(orbitalOrigin instanceof PVector){
      this.orbitalOriginPoint = (PVector) orbitalOrigin;
    }else{
      this.position = position.copy();
    }
    if (name != null){
      this.name = name;
    }
    startShape(texture);
  }


  void startShape(PImage texture){
    shape = createShape(SPHERE,r);
    shape.setStroke(255);
    shape.setTexture(texture);
    endShape();
  }

  void rotate(){
    shape.rotateX(radians(rotation.x));
    shape.rotateY(radians(rotation.y));
    shape.rotate(radians(rotation.z),0,0,1);
  }

  void orbitate(){
    if (translation != null){
      PVector orbit = new PVector(0,0,0);
      if (orbitalOrigin != null){
        orbit = orbitalOrigin.getAbsolutePosition();
      }else if (orbitalOriginPoint != null){
        orbit = orbitalOriginPoint;
      }

      position = rotatePoint(position, radians(translation.x), 0);
      position = rotatePoint(position, radians(translation.y), 1);
      position = rotatePoint(position, radians(translation.z), 2);
    }
  }

  void display(){
    pushMatrix();
    PVector translate = this.getAbsolutePosition();
    translate(translate.x, translate.y, translate.z);
    shape(shape);

    textSize(r);
    fill(0);
    text(name, 0, r + r, 0);

    popMatrix();
  }

  PVector rotatePoint(PVector point, float angle, int axis){
    float[] res;
    switch(axis){
      case 0:                                            //X
        float[][] X = {{1,          0,           0},
                       {0, cos(angle), -sin(angle)},
                       {0, sin(angle),  cos(angle)}};
        res = multiplication(point.array(), X);
        break;
      case 1:                                            //Y
        float[][] Y = {{ cos(angle), 0, sin(angle)},
                       {          0, 1,          0},
                       {-sin(angle), 0, cos(angle)}};
        res = multiplication(point.array(), Y);
        break;
      case 2:                                            //Z
        float[][] Z = {{ cos(angle),-sin(angle), 0},
                       { sin(angle), cos(angle), 0},
                       {          0,          0, 1}};
        res = multiplication(point.array(), Z);
        break;
      default:                                          //NOTHING
        float[][] NOTHING = {{ 1, 0, 0},
                             { 0, 1, 0},
                             { 0, 0, 1}};
        res = multiplication(point.array(), NOTHING);
        break;

    }
    return new PVector(res[0], res[1], res[2]);
  }
  
  float[] multiplication(float[] A, float[][] B){
    float[] res = new float[A.length];
    for (int i = 0; i < A.length;i++){
      float sum = 0;
      for (int j = 0; j < B[0].length;j++){
        sum += A[j]*B[j][i];
      }
      res[i] = sum;
    }
    return res;
  }


  PShape getShape(){
    return shape;
  }

  float getR(){
    return r;
  }

  PVector getAbsolutePosition(){
    if (orbitalOrigin != null){
      return PVector.add(orbitalOrigin.getAbsolutePosition(), position);
    }else if (orbitalOriginPoint != null){
      return PVector.add(orbitalOriginPoint, position);
    }else{
      return getPosition();
    }
  }

  PVector getPosition(){
    return position.copy();
  }

  PVector getRotation(){
    return rotation.copy();
  }

  AstronomicalObject getOrbitalOrigin(){
    return orbitalOrigin;
  }

  PVector getTranslation(){
    return translation.copy();
  }
}