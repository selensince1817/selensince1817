import processing.sound.*; 

Mover mover;
Ball[] balls;
float ballsAbsorbed;

int ballsNum;
int badThingsNum;

color backgroundColour;

boolean level1End;
boolean level2End;
boolean level3End;

boolean crash;
boolean canAbsorb;
BadThing[] badThings;

SoundFile ouch;
SoundFile boink;
SoundFile wiu;


void setup() {

  fullScreen();

  boink = new SoundFile(this, "perc_blvk.wav");
  ouch = new SoundFile(this, "perc_kak_nazvat'.wav");
  wiu = new SoundFile(this, "[PBS] Pluck ( Pizzi ).wav");
  
  canAbsorb = true;

  backgroundColour = color(240, 220, 180);

  ballsNum = 40;
  reset();
  
  backgroundColour = color(color(backgroundColour), 30);
}

void draw() {

  if (!crash) {
    background(backgroundColour);
  }

  ballsCounter();
  
  mover.display();
  
  
  mover.update();

  drawBalls();  
  drawBadThings();

  crashFunction();
  absorbFunction();


  levelEnd();
}






void levelEnd() {
  if (ballsAbsorbed == balls.length) {

    checkForLevel(); // gives a levelEnd(x) a value of true

    if (level1End) {
      ballsNum = 20;
      backgroundColour = color(#9C83E8); //purple
      badThingsNum = 2;
      
      wiu.play(1, 0.7);
      
      reset();
    }

    if (level2End) {
      ballsNum = 12;
      backgroundColour = color(255);
      badThingsNum = 4;
      
      wiu.play(1, 0.7);
      
      reset();
    }

    if (level3End) {
      wiu.play(1, 0.7);
      
      textAlign(CENTER);
      fill(250);
      textSize(100);
      text("well done!", width/2, height*3/4);
      frameRate(0);
    }
  }
}



void reset() {

  noStroke();
  smooth();
  
  textAlign(CENTER);

  crash = false;
  canAbsorb = true;
  ballsAbsorbed = 0;

  mover = new Mover();
  badThings = new BadThing[badThingsNum];
  balls = new Ball[ballsNum];

  iterateBalls();
  iterateBadThings();
}






void drawBalls() {
  for (int i=0; i<balls.length; i++) {    //  draws balls
    balls[i].display();
    balls[i].move();
  }
}





void drawBadThings() {
  for (int i =0; i<badThings.length; i++) { //  draws bad things
    badThings[i].display();
  }
}






void absorbFunction() {

  if (canAbsorb) {
    for (int i=0; i < balls.length; i++) { // Touch boolean

      if (dist(balls[i].position.x, balls[i].position.y, mover.position.x, mover.position.y) <= balls[i].diameter/2 + mover.diameter/2) {
        // balls[i].colour = color(0);
        balls[i].touch = true;
        balls[i].colour = mover.colour;
        mover.diameter = mover.diameter + balls[i].diameter/2;
        ballsAbsorbed = ballsAbsorbed + 1;
        
        boink.play(1, 0.3);
        
      } else {
        balls[i].touch = false;
      }
    }
  }
}

void crashFunction() {

  for (int i =0; i<badThings.length; i++) {

    if (dist(mover.position.x, mover.position.y, badThings[i].position.x, badThings[i].rectCenterY) <= mover.diameter/2 + badThings[i].size) {
      crash = true;
      canAbsorb = false;
      
      
      
      
      circle(badThings[i].position.x, badThings[i].rectCenterY, 40);
      badThings[i].position.x = 5000;
      badThings[i].position.y = 5000;
      ouch.play();
    }
  }

  if (crash) {

    for (int i =0; i<balls.length; i++) {

      balls[i].velocity.x = 0.1;
      balls[i].velocity.y = 0.1;
    }


    mover.velocity.limit(0.1);
  }
}





void keyPressed() {
  if (key == 'r' || key =='R') {

    reset();
  }
}








void ballsCounter()
{

  fill(0);
  textSize(60);
  text(nf(ballsAbsorbed, 1, 0), width*0.93, height*0.1);
}




void iterateBalls() {
  for (int i=0; i<balls.length; i++) {
    balls[i] = new Ball(); // iterates for each ball;
    balls[i].position.x = random(0+balls[i].diameter/2+10, width-balls[i].diameter/2-10); // random position for balls
    balls[i].position.y = random(0+balls[i].diameter/2 + 10, height-balls[i].diameter/2 - 10);
  }
}





void iterateBadThings() {
  for (int i =0; i<badThings.length; i++) {
    

    badThings[i] = new BadThing();
    badThings[i].position.x = random(150, width-150);
    badThings[i].position.y = random(200, height-200);
  }
}

void checkForLevel() {
  if (ballsAbsorbed==40) {
    level1End = true;
  } else if (ballsAbsorbed == 20) {
    level2End = true;
  } else if (ballsAbsorbed == 12) {
    level3End = true;
  }
}
