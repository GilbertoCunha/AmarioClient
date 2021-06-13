String[][] lb;
int textSize = (int) (height/18);
// int textSize = 40;
Button lbBack;
PImage usercloud, scorecloud, leaderboard;

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
            if (Float.parseFloat(s[j-1][1]) < Float.parseFloat(s[j][1])) {
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
  localuser.connect(ip, loginPort);
  response = localuser.request(":leaderboard 7" );
  LeaderboardResponse (response);
  localuser.close();
}

void setupLeaderboard() {
  lbBack = new Button ("exit", 5 * width/6, 9 * height/10, width/8, width/14);
  scorecloud = loadImage("scorecloud.png");
  usercloud = loadImage("usercloud.png");
  leaderboard = loadImage("leaderboard.png");
}

void LbMousePressed () {
  lbBack.buttonMousePressed();
}

void drawLeaderboard() {
  image(background, 0, 0);
  
  lbBack.draw();
  textSize = (int) (height/18);
  
  image(usercloud, 1.95*width/8, height/20, 2*width/8, height/6);
  image(scorecloud, 4.15*width/8, height/20, 2*width/8, height/6);
  image(leaderboard, 1.5*width/8, height/20+height/6, 5*width/8, 2*height/3);
  
  int i = 0;
  for (String[] userdata: lb) {
    // Username text
    textAlign(LEFT);
    textSize(textSize);
    fill(0);
    if (i >= 0 && i <= 2) text(userdata[0], width/3.7, 3 * height/13 + i*height/11.5 + textSize);
    else text(userdata[0], width/3.7, 3 * height/13 + i*height/11.5 + textSize);
    
    // Score text
    textAlign(LEFT);
    textSize(textSize);
    fill(0);
    String score = String.valueOf((int) Float.parseFloat(userdata[1]));
    text(score, width/3.7 + 2.2*width/8, 3 * height/13 + i*height/11.5 + textSize);
    i++;
  }
  
  if (lbBack.isPressed()) {
    gameScreen = 1;
    lbBack.reset();
  }
}
