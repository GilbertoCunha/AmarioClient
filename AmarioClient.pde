int gameScreen = 0;

void setup () {
  fullScreen ();
  initSetup ();
  initMenuSetup ();
  setupInstructions();
}

void draw () {
  if (gameScreen == 0) drawInitScreen ();
  else if (gameScreen == 1) drawMenuScreen ();
  else if (gameScreen == 2) drawGameScreen ();
  else if (gameScreen == 3) drawInstructions ();
} 

void mousePressed () {
  if (gameScreen == 0) initMousePressed ();
  if (gameScreen == 1) MenuMousePressed ();
  if (gameScreen == 3) InstructionsMousePressed ();
}

void keyPressed () {
  if (gameScreen == 0) initKeyPressed ();
}
