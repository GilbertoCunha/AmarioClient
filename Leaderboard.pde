String[][] lb;
int textSize = 40;
Button lbBack;

void LeaderboardResponse(String response) {
  String[] userdata = response.split(",", 0);
  int N = 0;
  for (String s: userdata) N++;
  
  lb = new String [N][2];
  int i = 0;
  for (String s: userdata){
    lb[i++] = s.split(" ", 0);
  }
  sortLeaderboard(lb, N);
}

void sortLeaderboard (String[][] s, int N) {
    String name, score;
    for(int i = 0; i < N ; i++ ){
        for(int j = 1; j < N - i; j++) {
            if (Integer.parseInt(s[j-1][1]) < Integer.parseInt(s[j][1])) {
                name = s[j-1][0];
                score = s[j-1][1];
                s[j-1][0] = s[j][0];
                s[j-1][1] = s[j][1];
                s[j][0] = name;
                s[j][1] = score;
            }
        }
    }
}

void getLeaderboard() {
  localuser.connect("localhost", 80);
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
