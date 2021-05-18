String[][] lb;
int textSize = 40;
Button lbBack;

void LeaderboardResponse(String response) {
  String[] userdata = response.split(",", 0);
  int i = 0;
  for (String s: userdata) i++;
  
  lb = new String [i][2];
  i = 0;
  for (String s: userdata){
    lb[i++] = s.split(" ", 0);
    System.out.println("User: " + lb[i-1][0] + " | Score: " + lb[i-1][1]);
  }
}


void getLeaderboard() {
  localuser.connect("localhost",23);
  response = localuser.request(":leaderboard 10" );
  LeaderboardResponse (response);
  localuser.close();
}

void setupLeaderboard() {
  lbBack = new Button (5 * width/6, 9 * height/10, width/8, width/20);
  lbBack.setup (base, highlight, pressed, "Go Back", true);
}

void LbMousePressed () {
  lbBack.buttonMousePressed();
}

void drawLeaderboard() {
  background(255);
  
  lbBack.draw();
  
  fill(200);
  stroke(20);
  rect(width/8, height/8, 3*width/8, height/14);
  fill(200);
  stroke(20);
  rect(4*width/8, height/8, 3*width/8, height/14);
  textAlign(LEFT);
  textSize(textSize);
  fill(0);
  text("Username", width/7, height/8 + textSize);
  textAlign(LEFT);
  textSize(textSize);
  fill(0);
  text("Highscore", width/2 + width/7 - width/8, height/8 + textSize);
  
  int i = 1;
  for (String[] userdata: lb) {
    fill(200);
    stroke(20);
    rect(width/8, height/8 + i*height/14, 3*width/8, height/14);
    fill(200);
    stroke(20);
    rect(4*width/8, height/8 + i*height/14, 3*width/8, height/14);
    textAlign(LEFT);
    textSize(textSize);
    fill(0);
    text(userdata[0], width/7, height/8 + i*height/14 + textSize);
    textAlign(LEFT);
    textSize(textSize);
    fill(0);
    text(userdata[1], width/2 + width/7 - width/8, height/8 + i*height/14 + textSize);
    i++;
  }
  
  if (lbBack.isPressed()) {
    gameScreen = 1;
    lbBack.reset();
  }
}
