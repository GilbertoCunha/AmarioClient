String w, a, d;
PImage instrimg;
Button GoBack;

void setupInstructions () {
  instrimg = loadImage("instructions.png");
  
  GoBack = new Button ("exit", width/8, height/10, width/8, height/8);
}  

void InstructionsMousePressed () {
  GoBack.buttonMousePressed();
}

void drawInstructions () {  
  image(background, 0, 0);
  image(instrimg, width/5, height/6, 3*width/5, 2*height/3);
  GoBack.draw();
  if (GoBack.isPressed()) {
    gameScreen = 1;
    GoBack.reset();
  }
}
