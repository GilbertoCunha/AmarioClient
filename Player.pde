import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

class State {
  int x, y, size, score;
  float angle;
  
  State (int x, int y, float angle, int size, int score) {
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.size = size;
    this.score = score;
  }
}

void drawArrow(int cx, int cy, int len, float angle){
  pushMatrix();
  translate(cx, cy);
  rotate(angle);
  line(0,0,len, 0);
  line(len, 0, len - 8, -8);
  line(len, 0, len - 8, 8);
  popMatrix();
}

public class Player {
  String playername;
  Lock lock;
  Socket s;
  InputStream input;
  PrintStream out;
  BufferedReader read;
  State state;
  
  Player (String name) {
    // Just to establish connections
    this.playername = name;
    this.lock = new ReentrantLock();
    this.state = null;
  }
  
  public void connect (String ip, int port) {
    try{
      lock.lock();
      s = new Socket(ip, port);
      input = s.getInputStream();
      out = new PrintStream(s.getOutputStream());
      read = new BufferedReader(new InputStreamReader(input)); 
      lock.unlock();
    } catch (Exception e) { System.out.println(e); }    
  }
  
  public void receive () {
    try {
      String line = read.readLine();
      String[] nums = line.split(" ");
      
      int x, y, size, score;
      float angle;
      int n_players = Integer.parseInt(nums[0]);
      int n_creatures = Integer.parseInt(nums[1]);
      
      for (int i = 0; i < n_players; i++ ) {
        line = read.readLine();
        nums = line.split(" ");
        
        x = (int) (height * Double.parseDouble(nums[1]));
        y = (int) (height * Double.parseDouble(nums[2])); 
        angle = Float.parseFloat(nums[3]);
        size = (int) (height * Float.parseFloat(nums[4])); 
        score = Integer.parseInt(nums[5]); 
        
        if (!players.containsKey(nums[0])) {
          playerslock.lock();
          players.put(nums[0], new Player(nums[0]));
          playerslock.unlock();
        } 
        playerslock.lock();
        players.get(nums[0]).changeState(x, y, angle, size, score);
        playerslock.unlock();
      }
    
    } catch (Exception e) { System.out.println(e); }
  }
  
  public void send (String command) {
    try {
      out.println(command);
    } catch (Exception e) { System.out.println(e); }
  }
  
  public String request (String command) {
    try {
      out.println(command);
      String line = read.readLine();
      return line;
    } catch (Exception e) { System.out.println(e); return "Exception"; }
  }
  
  public void close () {
    try {
      out.close();
      s.close();
    } catch (Exception e) { System.out.println(e); }
  }
  
  public void changeState(int x, int y, float angle, int size, int score) {
    this.lock.lock();
    this.state = new State(x, y, angle, size, score);
    this.lock.unlock();  
  }
  
  public void draw() {
    lock.lock();
    if (this.state != null) {
      fill(200);
      stroke(200);
      strokeWeight(0);
      int size = 2 * state.size;
      ellipse(state.x, state.y, size, size);
      stroke(0);
      strokeWeight(2);
      drawArrow(state.x, state.y, state.size, state.angle);
    }
    lock.unlock();  
  }
  
}
