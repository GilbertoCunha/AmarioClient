int gameScreen = 0;
int FPS = 120;
String ip = "localhost";
int gamePort = 81;
int loginPort = 80;

void setup () {
  size(1280,720);
  frameRate(FPS);
  initSetup ();
  // initMenuSetup();
  setupInstructions();
  setupLeaderboard();
  // setupGame();
}

void draw () {
  if (gameScreen == 0) drawInitScreen ();
  else if (gameScreen == 1) drawMenuScreen ();
  else if (gameScreen == 2) drawGameScreen ();
  else if (gameScreen == 3) drawInstructions ();
  else if (gameScreen == 4) drawLeaderboard ();
  else if (gameScreen == 5) drawWaitingScreen();
} 

void mousePressed () {
  if (gameScreen == 0) initMousePressed ();
  else if (gameScreen == 1) MenuMousePressed ();
  else if (gameScreen == 2) GameMousePressed ();
  else if (gameScreen == 3) InstructionsMousePressed ();
  else if (gameScreen == 4) LbMousePressed ();
  else if (gameScreen == 5) waitingScreenMousePressed ();
}

void keyPressed () {
  if (gameScreen == 0) initKeyPressed ();
  else if (gameScreen == 2) playerkeyPressed ();
}

void keyReleased () {
  if (gameScreen == 2) playerkeyReleased ();
}

void exit () {
  if (localuser != null) {
    localuser.connect("localhost", 80);
    response = localuser.request(":logout " + localuser.username + " " + localuser.password);
    response = LogoutResponse (response);
    localuser.close();
  }
}
