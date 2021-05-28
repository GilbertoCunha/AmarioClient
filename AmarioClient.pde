int gameScreen = 2;

void setup () {
  fullScreen ();
  initSetup ();
  initMenuSetup ();
  setupInstructions();
  setupLeaderboard();
  setupGame();
}

void draw () {
  if (gameScreen == 0) drawInitScreen ();
  else if (gameScreen == 1) drawMenuScreen ();
  else if (gameScreen == 2) drawGameScreen ();
  else if (gameScreen == 3) drawInstructions ();
  else if (gameScreen == 4) drawLeaderboard ();
} 

void mousePressed () {
  if (gameScreen == 0) initMousePressed ();
  else if (gameScreen == 1) MenuMousePressed ();
  else if (gameScreen == 3) InstructionsMousePressed ();
  else if (gameScreen == 4) LbMousePressed ();
}

void keyPressed () {
  if (gameScreen == 0) initKeyPressed ();
  else if (gameScreen == 2) playerkeyPressed ();
}

void keyReleased () {
  if (gameScreen == 2) playerkeyReleased ();
}
