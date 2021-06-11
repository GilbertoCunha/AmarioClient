int menuTextSize = 60;

// Botões de login e criar conta
Button Play;
Button Leaderboard;
Button Instructions;
Button Logout;
Button DeleteAccount;
PImage img;
HashMap<String,Player> players;
Lock playerslock;
Player player;
Obstacle[] obstacles;
Lock obstacleslock;

void initMenuSetup() {
  
  Play = new Button ( width / 2, 1 * height / 6, width/2, width/12);
  Play.setup (base, highlight, pressed, "Play", true);
  Play.textSize = menuTextSize;
  
  Leaderboard = new Button ( width / 2, 2 * height / 6, width/2, width/12);
  Leaderboard.setup (base, highlight, pressed, "Leaderboard", true);
  Leaderboard.textSize = menuTextSize;
  
  Instructions = new Button ( width / 2, 3 * height / 6, width/2, width/12);
  Instructions.setup (base, highlight, pressed, "Instructions", true);
  Instructions.textSize = menuTextSize;
  
  Logout = new Button ( width / 2, 5 * height / 6, width/2, width/12);
  Logout.setup (base, highlight, pressed, "Logout", true); 
  Logout.textSize = menuTextSize;
  
  DeleteAccount = new Button ( width / 2, 4 * height / 6, width/2, width/12);
  DeleteAccount.setup (base, highlight, pressed, "Delete Account", true); 
  DeleteAccount.textSize = menuTextSize;
  
  playerslock = new ReentrantLock();
  players = new HashMap<String,Player>();
  
  playerslock.lock();
  player = new Player(localuser.username);
  playerslock.unlock();
  
  obstacleslock = new ReentrantLock();
  
  img  = loadImage("bobpicanha.png");
  
}

void MenuMousePressed () {
  Play.buttonMousePressed();
  Leaderboard.buttonMousePressed();
  Instructions.buttonMousePressed();
  Logout.buttonMousePressed();
  DeleteAccount.buttonMousePressed();
}

String LogoutResponse (String response) {
  String r = "";
  if (response.equals("user_not_found")) r = "User not found";
  else if (response.equals("wrong_authentication")) r = "Username or password incorrect";
  else if (response.equals("ok")) {
    r = "Logged Out";
    gameScreen = 0;
  }
  return r;
}

void LogoutPressed () {
  // Connect with the server
  localuser.connect("localhost", 80);
  response = localuser.request(":logout " + localuser.username + " " + localuser.password);
  response = LogoutResponse (response);
  localuser.close();
  
  // Show the authentication result
  Logout.reset();
}

String DeleteAccountResponse (String response) {
  String r = "";
  if (response.equals("user_not_found")) r = "User not found";
  else if (response.equals("wrong_authentication")) r = "Username or password incorrect";
  else if (response.equals("ok")) {
    System.out.println("Deleted");
    r = "Account Deleted";
    gameScreen = 0;
  }
  return r;
}

void DeleteAccountPressed () {
  // Connect with the server
  localuser.connect("localhost", 80);
  response = localuser.request(":close_account " + localuser.username + " " + localuser.password);
  response = DeleteAccountResponse (response);
  localuser.close();
  
  // Show the authentication result
  DeleteAccount.reset();
}

String PlayResponse (String response) {
  String r = "";
  if (response.equals("game full")) r = "Game is full";
  else if (response.equals("wrong authentication")) r = "Username or password incorrect";
  else if (response.equals("added to queue")) {
    r = "Entered Queue";
    setupGame();
    gameScreen = 5;
  } else {
    r = "Entered game";
    gameScreen = 2;
    setupGame();
  }
  return r;
  
}

void PlayPressed () {
  // Put localplayer in player list
  players.put(localuser.username,new Player(localuser.username));
  
  // Connect with the server
  player.connect("localhost", 81);
  response = player.request(":check " + localuser.username + " " + localuser.password);
  response = PlayResponse (response);
  
  // Show the authentication result
  Play.reset();
}

void drawMenuScreen () {
  background(255);
  image(img,0,0,width,height);
  Play.draw();
  Leaderboard.draw();
  Instructions.draw();
  Logout.draw();
  DeleteAccount.draw();
  if (Instructions.isPressed()) {
    gameScreen = 3;
    Instructions.reset();
  }
  else if (Logout.isPressed()) LogoutPressed();
  else if (Leaderboard.isPressed()) {
    gameScreen = 4;
    Leaderboard.reset();
    getLeaderboard();
  }
  else if (Play.isPressed()) PlayPressed();
  else if (DeleteAccount.isPressed()) DeleteAccountPressed();
}
