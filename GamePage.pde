import java.util.HashMap;

int x_pos, y_pos;
int size = width/4;
int player_color = color(0);
HashMap<Integer,Boolean> keys;

void setupGame(){
  keys = new HashMap<Integer,Boolean>();
  x_pos = width/5;
  y_pos = height/5;
  
}

void drawPlayer () {
  fill(player_color);
  ellipse(x_pos, y_pos, size, size);
}

void playerkeyPressed () {
  String keypressed = "";
  if (!keys.containsKey(keyCode)) {
    if(key == 'w' || key == 'W' || keyCode == UP ) keypressed = "w";
    else if (key == 'a' || key == 'A' || keyCode == LEFT ) keypressed = "a";
    else if (key == 'd' || key == 'D' || keyCode == RIGHT ) keypressed = "d";
    if (keypressed != "") {
      keys.put(keyCode, true);
      response = localuser.request(":press " + keypressed);
      response = pressedResponse (response);
    }
  }
}

String pressedResponse (String response) {
  
}

void playerkeyReleased () {
  String keyreleased = "";
  if (keys.containsKey(keyCode)) {
    if(key == 'w' || key == 'W' || keyCode == UP ) keyreleased = "w";
    else if (key == 'a' || key == 'A' || keyCode == LEFT ) keyreleased = "a";
    else if (key == 'd' || key == 'D' || keyCode == RIGHT ) keyreleased = "d";
    if (keyreleased != "") {
      keys.remove(keyCode);
      response = localuser.request(":release " + keyreleased);
      response = releasedResponse (response);
    }
  }
}

String releasedResponse (String response) {
  
}

void drawGameScreen () {
  background(255);
  drawPlayer();
}
