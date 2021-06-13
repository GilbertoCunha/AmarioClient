import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

int x_pos, y_pos;
int size = width/4;
int player_color = color(0);
HashMap<Integer,Boolean> keys;
HashMap<String,Creature> creatures;
Lock creatureslock;
Thread receiver;
Iterator hm_iterator;
Button Quit;
Receiver runnable;
String[] player_avatars;
PImage floor, obstacle_img;

void setupGame(){
  keys = new HashMap<Integer,Boolean>();
  runnable = new Receiver();
  receiver = new Thread(runnable);
  receiver.start();
  
  creatureslock = new ReentrantLock();
  creatures = new HashMap<String,Creature>();
  
  Quit = new Button ("exit", width / 20, height / 20, height / 8, height/14);
  
  floor = loadImage("floor.png");
  floor.resize(width,height);
  obstacle_img = loadImage("obstacles.png");
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

void GameMousePressed () {
  Quit.buttonMousePressed();
}

void drawGameScreen () {
  background(255);
  image(floor, 0, 0);
  
  /*fill(230,89,255);
  textAlign(LEFT);
  textSize(height/18);
  text(String.valueOf((int) (frameRate)), 0, height);*/
  
  // Draw obstacles
  obstacleslock.lock();
  if (obstacles != null)
    for (Obstacle o: obstacles)
      o.draw();
  obstacleslock.unlock();
  
  strokeWeight(20);
  Quit.draw();
  
  // Draw creatures
  creatureslock.lock();
  hm_iterator = creatures.entrySet().iterator();
  while(hm_iterator.hasNext()) {
    Map.Entry me = (Map.Entry) hm_iterator.next();
    Creature c = (Creature) me.getValue();
    c.draw();
  }
  creatureslock.unlock();
  
  // Draw players
  playerslock.lock();
  hm_iterator = players.entrySet().iterator();
  while(hm_iterator.hasNext()) {
    Map.Entry me = (Map.Entry) hm_iterator.next();
    Player p = (Player) me.getValue();
    p.draw();
  }
  
  // Draw player status bars
  int i = 0;
  hm_iterator = players.entrySet().iterator();
  while(hm_iterator.hasNext()) {
    Map.Entry me = (Map.Entry) hm_iterator.next();
    Player p = (Player) me.getValue();
    p.drawstatus(i++);
  }
  playerslock.unlock();

  try {
    // If exit is pressed
    if (Quit.isPressed()) {
      runnable.terminate();
      receiver.join();
    }
  } catch (Exception e) { System.out.println(e); }
}
