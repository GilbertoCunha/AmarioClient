
int menuTextSize = 60;

// Botões de login e criar conta
Button Play;
Button Leaderboard;
Button Instructions;
Button Logout;
PImage img;

void initMenuSetup() {
  
  Play = new Button (width / 3 + 105, 2 * height / 5, 400, 200);
  Play.setup (base, highlight, pressed, "Play", true);
  Play.textSize = menuTextSize;
  
  Leaderboard = new Button (2 * width / 3 - 105, 2 * height / 5, 400, 200);
  Leaderboard.setup (base, highlight, pressed, "Leaderboard", true);
  Leaderboard.textSize = menuTextSize;
  
  Instructions = new Button ( width / 2, 3 * height / 5 + 10, 830, 200);
  Instructions.setup (base, highlight, pressed, "Instructions", true);
  Instructions.textSize = menuTextSize;
  
  Logout = new Button ( width - 175 , height - 25, 350, 70);
  Logout.setup (base, highlight, pressed, "Logout", true); 
  Logout.textSize = menuTextSize;
  
  img  = loadImage("bobpicanha.png");
  
}

void MenuMousePressed () {
  Play.buttonMousePressed();
  Leaderboard.buttonMousePressed();
  Instructions.buttonMousePressed();
  Logout.buttonMousePressed();
}


void drawMenuScreen () {
  background(255);
  image(img,0,0,width,height);
  Play.draw();
  Leaderboard.draw();
  Instructions.draw();
  Logout.draw();
  if (Instructions.isPressed()) {
    gameScreen = 3;
    Instructions.reset();
  }
}
