int menuTextSize = 60;

// Botões de login e criar conta
Button Play;
Button Leaderboard;
Button Instructions;
Button Logout;
PImage img;

void initMenuSetup() {
  
  Play = new Button (width / 4 + width/20, 2 * height / 5, width/3, width/10);
  Play.setup (base, highlight, pressed, "Play", true);
  Play.textSize = menuTextSize;
  
  Leaderboard = new Button (3 * width / 4 - width/20, 2 * height / 5, width/3, width/10);
  Leaderboard.setup (base, highlight, pressed, "Leaderboard", true);
  Leaderboard.textSize = menuTextSize;
  
  Instructions = new Button ( width / 2, 3 * height / 5, width/2, width/10);
  Instructions.setup (base, highlight, pressed, "Instructions", true);
  Instructions.textSize = menuTextSize;
  
  Logout = new Button ( width - 2 * width/15, height - 2 * width/28, width/5, width/14);
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

String LogoutResponse (String response) {
  String r = "";
  System.out.println("Login Response: \"" + response + "\"");
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
  localuser.connect("localhost", 23);
  response = localuser.request(":logout " + localuser.username + " " + localuser.password);
  response = LogoutResponse (response);
  localuser.close();
  
  // Show the authentication result
  Logout.reset();
}

String PlayResponse (String response) {
  String r = "";
  System.out.println("Response: \"" + response + "\"");
  if (response.equals("game full")) r = "Game is full";
  else if (response.equals("wrong authentication")) r = "Username or password incorrect";
  else if (response.equals("user added")) {
    r = "Entered game";
    gameScreen = 2;
  }
  return r;
  
}

void PlayPressed () {
  // Connect with the server
  localuser.connect("localhost", 24);
  response = localuser.request(":check " + localuser.username + " " + localuser.password);
  response = PlayResponse (response);
  localuser.close();
  
  // Show the authentication result
  Logout.reset();
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
  else if (Logout.isPressed()) LogoutPressed();
  else if (Leaderboard.isPressed()) {
    gameScreen = 4;
    Leaderboard.reset();
    getLeaderboard();
  }
  else if (Play.isPressed()) PlayPressed();
}
