import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

int x_pos, y_pos;
int size = width/4;
int player_color = color(0);
HashMap<Integer,Boolean> keys;
Thread receiver;
Iterator hm_iterator;

void setupGame(){
  keys = new HashMap<Integer,Boolean>();
  receiver = new Thread(new Receiver());
  receiver.start();
  hm_iterator = players.entrySet().iterator();
  
}


void playerkeyPressed () {
  String keypressed = "";
  if (!keys.containsKey(keyCode)) {
    if(key == 'w' || key == 'W' || keyCode == UP ) keypressed = "w";
    else if (key == 'a' || key == 'A' || keyCode == LEFT ) keypressed = "a";
    else if (key == 'd' || key == 'D' || keyCode == RIGHT ) keypressed = "d";
    if (keypressed != "") {
      keys.put(keyCode, true);
      player.send(":press " + keypressed);
    }
  }
}

void playerkeyReleased () {
  String keyreleased = "";
  if (keys.containsKey(keyCode)) {
    if(key == 'w' || key == 'W' || keyCode == UP ) keyreleased = "w";
    else if (key == 'a' || key == 'A' || keyCode == LEFT ) keyreleased = "a";
    else if (key == 'd' || key == 'D' || keyCode == RIGHT ) keyreleased = "d";
    if (keyreleased != "") {
      keys.remove(keyCode);
      player.send(":release " + keyreleased);
    }
  }
}

void drawGameScreen () {
  background(255);
  while(hm_iterator.hasNext()) {
    Map.Entry me = (Map.Entry) hm_iterator.next();
    Player p = (Player) me.getValue();
    p.draw();
  }
  
  
}
