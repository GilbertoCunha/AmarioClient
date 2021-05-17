int gameScreen = 0;

void setup () {
  fullScreen ();
  if (gameScreen == 0) initSetup ();
}

void draw () {
  if (gameScreen == 0) drawInitScreen ();
  else if (gameScreen == 1) drawGameScreen ();
} 

void mousePressed () {
  if (gameScreen == 0) initMousePressed ();
}

void keyPressed () {
  if (gameScreen == 0) initKeyPressed ();
}
