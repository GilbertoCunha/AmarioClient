int k, menuTextSize = 60;

// Botões de login e criar conta
Button Play;
Button Leaderboard;
Button Instructions;
Button Logout;
Button DeleteAccount;
Button ExitGame;
PImage loginimg;
HashMap<String,Player> players;
Lock playerslock;
Player player;
Obstacle[] obstacles;
Lock obstacleslock;

void initMenuSetup() {
  
  Play = new Button ("play", width / 2, 3 * height / 7, width/5, width/9);
  Leaderboard = new Button ("leaderboard", width / 2 - width/4, 3 * height / 7, width/5, width/9);
  Instructions = new Button ("instructions", width / 2 + width/4, 3 * height / 7, width/5, width/9);
  Logout = new Button ("logout", width / 2 + width/8, 5 * height / 7, width/5, width/9);
  DeleteAccount = new Button ("delaccount", width / 2 - width/8, 5 * height / 7, width/5, width/9);
  
  playerslock = new ReentrantLock();
  players = new HashMap<String,Player>();
  
  playerslock.lock();
  player = new Player(localuser.username, "amario.png");
  playerslock.unlock();
  
  obstacleslock = new ReentrantLock();
  
  // loginimg  = loadImage("bobpicanha.png");
  
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
  localuser.connect(ip, loginPort);
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
  localuser.connect(ip, loginPort);
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
    numplayers++;
    gameScreen = 2;
    setupGame();
  }
  return r;
  
}

void PlayPressed () {
  // Put localplayer in player list
  players.put(localuser.username,new Player(localuser.username, player_avatars[0]));
  avatar_free[0] = false;
  
  // Connect with the server
  player.connect(ip, gamePort);
  response = player.request(":check " + localuser.username + " " + localuser.password);
  response = PlayResponse (response);
  
  // Show the authentication result
  Play.reset();
}

void drawMenuScreen () {
  background(50);
  
  image(background, 0, 0);
  image(logo, width / 2 - width/6, height / 7 - width/14, width/3, width/7);
  
  //image(loginimg,0,0,width,height);
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
