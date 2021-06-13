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
  
  GoBack = new Button ("exit", width/8, height/10, width/8, height/8);
}  

void InstructionsMousePressed () {
  GoBack.buttonMousePressed();
}

void drawInstructions () {  
  image(background, 0, 0);
  
  textSize(100);
  textAlign(CENTER);
  text("Instructions", width/2, height/7);
  
  image(wimg, width/4, height/5, width/10, width/10);
  fill(200);
  rect(width/4 + width/8, 4.2 * height/20, 3 * width/5, height/8);
  textAlign(CENTER);
  textSize(70);
  fill(0);
  text(w, width/4 + width/8 + 3 * width/10, 1.5 * height/5);
  
  image(aimg, width/4, height/2, width/10, width/10);
  fill(200);
  rect(width/4 + width/8, height/2 + height/50, 3 * width/5, height/8);
  fill(0);
  textSize(70);
  text(a, width/4 + width/8 + 3 * width/10, height/2 + height/9);
  
  image(dimg,width/4, 4 * height/5, width/10, width/10);
  fill(200);
  rect(width/4 + width/8, 4.08 * height/5, 3 * width/5, height/8);
  fill(0);
  textSize(70);
  text(d, width/4 + width/8 + 3 * width/10, 4 * height/5 + height/10);
  
  GoBack.draw();
  
  if (GoBack.isPressed()) {
    gameScreen = 1;
    GoBack.reset();
  }
}
