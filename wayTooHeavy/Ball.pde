class Ball {

  PVector position;
  PVector velocity;
  float diameter;
  color colour;
  color orange = color(random(220, 255), random(150, 190), random(50, 130));
  color yellow = color(random(220, 245), random(190, 240), random(70, 180));
  color purple = color(random(130, 200), random(100, 160), random(190, 240));

  boolean touch;


  Ball() {

    position = new PVector(width/2, height/2);
    velocity = new PVector(random(-4, 4), random(-4, 4));
    diameter = random (20, 80);


    colour = color(orange); // orange

    if (level1End) {

      colour = color(yellow);
    }

    if (level2End) {
      colour = color(purple);
    }



    touch = false;
    smooth();
  }

  void move() {

    position.add(velocity);


    if (position.x - diameter/2 <=0 || position.x + diameter/2 >=width) {

      velocity.x = velocity.x * -1;
    }

    if (position.y - diameter/2 <= 0 || position.y + diameter/2 >= height) {

      velocity.y = velocity.y * -1;
    }
  }

  void display() {

    if (!touch) {
      fill(colour);
      circle(position.x, position.y, diameter);
    } else {

      velocity = new PVector(0, 0);
      position = new PVector(5000, 5000);
    }
  }
}
