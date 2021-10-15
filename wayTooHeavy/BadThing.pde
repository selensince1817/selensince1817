class BadThing {

  PVector position;
  PVector velocity;


  color colour;
  float size;
  float rectCenterY;

  BadThing() {

    position = new PVector(width/2, height/2);
    velocity = new PVector(random(-3, 3), random(-3, 3));
    size = random(10, 20);
    colour = color(#E53F4C);
    rectMode(CENTER);
  }

  void display() {


    fill(colour);

    for (int i = 0; i < 3; i++) {

      rectCenterY =   position.y - ((dist(position.x, position.y, position.x, position.y - 2*size))/2);
      quad( position.x, position.y, position.x-size, position.y-size, position.x, position.y - 2*size, position.x +size, position.y-size);
      rect(position.x, rectCenterY, size*1.28, size*1.28);
    
  }
 }
 
 
}
