int gameScreen = 0;
int FPS = 120;
String ip = "192.168.1.80";
int gamePort = 81;
int loginPort = 80;
int minSize = 0, maxSize = 100;
int numplayers = 0;
boolean[] avatar_free = new boolean[3];

void setup () {
  noSmooth();
  player_avatars = new String[3];
  player_avatars[0] = "mario.png"; avatar_free[0] = true;
  player_avatars[1] = "peach.png"; avatar_free[1] = true;
  player_avatars[2] = "wario.png"; avatar_free[2] = true;
  
  fullScreen();
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

void quit () {
  if (localuser != null) {
    localuser.connect(ip, loginPort);
    response = localuser.request(":logout " + localuser.username + " " + localuser.password);
    response = LogoutResponse (response);
    localuser.close();
  }
  exit();
}
