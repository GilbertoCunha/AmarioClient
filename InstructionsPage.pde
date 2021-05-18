String w, a, d;
PImage wimg, aimg, dimg;
Button GoBack;

void setupInstructions () {
  wimg = loadImage("keyboard_key_w.png");
  aimg = loadImage("keyboard_key_a.png");
  dimg = loadImage("keyboard_key_d.png");
  w = "Accelerate forward";
  a = "Accelerate left";
  d = "Accelerate right";
  
  GoBack = new Button (width/4, height/10, 200, 100);
  GoBack.setup (base, highlight, pressed, "Go Back", true);
  
}  

void InstructionsMousePressed () {
  GoBack.buttonMousePressed();
}

void drawInstructions () {  
  background(255);
  
  textSize(100);
  textAlign(CENTER);
  text("Instructions", width/2, height/10);
  
  image(wimg,width/4, height/5,200,200);
  fill(200);
  rect(width/4 + 300, height/5, 800, 200);
  textAlign(CENTER);
  textSize(70);
  fill(0);
  text(w,width/4 + 700, height/5 + 135);
  
  image(aimg,width/4, height/2,200,200);
  fill(200);
  rect(width/4 + 300, height/2, 800, 200);
  fill(0);
  textSize(70);
  text(a,width/4 + 700, height/2 + 135);
  
  image(dimg,width/4, 4 * height/5,200,200);
  fill(200);
  rect(width/4 + 300, 4 * height/5, 800, 200);
  fill(0);
  textSize(70);
  text(d,width/4 + 700, 4 * height/5 + 135);
  
  GoBack.draw();
  
  if (GoBack.isPressed()) {
    gameScreen = 1;
    GoBack.reset();
  }
}
