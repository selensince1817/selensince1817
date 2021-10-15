class Mover {

  PVector position;
  PVector velocity;
  PVector acceleration;

  PVector mouse;

  float diameter;
  color colour;

  Mover() {

    position = new PVector (width/2, height/2);
    velocity = new PVector (0, 0);
    diameter = 40;
    colour = color(50);
    smooth();
  }

  void update() {

    PVector mouse = new PVector(mouseX, mouseY);
    PVector acceleration = PVector.sub(mouse, position);



    acceleration.setMag(0.9);

    if (level1End) {
      acceleration.setMag(0.5);
    }
    if (level2End) {
      acceleration.setMag(0.2);
      velocity.limit(18);
    }
    velocity.add (acceleration);
    velocity.limit(10);
    position.add (velocity);

    //  textSize(10);
    //text(mag(velocity.x, velocity.y), width*0.9, height*0.05);
    //text(mag(acceleration.x, acceleration.y), width*0.9, height*0.1);

    collision();
    antiStuck();
  }



  void display() {

    fill(colour);
    circle(position.x, position.y, diameter);
  }

  void antiStuck() {
    if (position.x - diameter/2 <=-5 ) {

      position.x = position.x + 5;
    }

    if (position.x + diameter/2 >= width+5) {
      position.x = position.x -5;
    }

    if (position.y - diameter/2 <= -5) {
      position.y = position.y + 5;
    }

    if (position.y + diameter/2 >= height + 5) {
      position.y = position.y -5;
    }
  }

  void collision() {
    if (position.x - diameter/2 <= 0 || position.x + diameter/2 >= width) {
      velocity.x = velocity.x * -1;
    }

    if (position.y - diameter/2 <= 0 || position.y + diameter/2 >= height) {
      velocity.y = velocity.y * -1;
    }
  }
}
