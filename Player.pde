import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

// fontItalic = createFont("Arial Italic", height/40);

class State {
  int x, y, size, score;
  float angle, fuelW, fuelA, fuelD;
  
  State (int x, int y, float angle, int size, int score, float fuelW, float fuelA, float fuelD) {
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.size = size;
    this.score = score;
    this.fuelW = fuelW;
    this.fuelA = fuelA;
    this.fuelD = fuelD;
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
      double start = System.nanoTime();
      String line = read.readLine();
      String[] nums = line.split(" ");
      
      if (nums[1].equals("left")) {
        playerslock.lock();
        players.remove(nums[0]);
        playerslock.unlock();
        System.out.println(nums[0] + " removed");
      } else if (nums[1].equals("died")) {
        creatureslock.lock();
        creatures.remove(nums[0]);
        creatureslock.unlock();
        System.out.println(nums[0] + " died");
      } else {
        int x, y, size, score;
        float angle, fuelW, fuelA, fuelD; String cor;
        int n_players = Integer.parseInt(nums[0]);
        int n_creatures = Integer.parseInt(nums[1]);
        
        // Players cycle
        for (int i = 0; i < n_players; i++ ) {
          line = read.readLine();
          nums = line.split(" ");
          
          x = (int) (height * Double.parseDouble(nums[1]));
          y = (int) (height * Double.parseDouble(nums[2])); 
          angle = Float.parseFloat(nums[3]);
          size = (int) (height * Float.parseFloat(nums[4])); 
          score = Integer.parseInt(nums[5]); 
          fuelW = Float.parseFloat(nums[6]);
          fuelA = Float.parseFloat(nums[7]);
          fuelD = Float.parseFloat(nums[8]);
          
          playerslock.lock();
          if (!players.containsKey(nums[0])) {
            players.put(nums[0], new Player(nums[0]));
          } 
          players.get(nums[0]).changeState(x, y, angle, size, score, fuelW, fuelA, fuelD);
          playerslock.unlock();
        }
        
        // Creatures cycle
        for (int i=0; i<n_creatures; ++i) {
          line = read.readLine();
          nums = line.split(" ");
          
          cor = nums[1];
          x = (int) (height * Double.parseDouble(nums[2]));
          y = (int) (height * Double.parseDouble(nums[3])); 
          size = (int) (height * Float.parseFloat(nums[4]));
          
          creatureslock.lock();
          if (!creatures.containsKey(nums[0])) {
            creatures.put(nums[0], new Creature(cor, x, y, size));
          } else {
            creatures.get(nums[0]).changeState(x, y, size);
          }
          creatureslock.unlock();
        }
        start = 1000000000 / (System.nanoTime() - start);
        //System.out.println("Receive FPS: " + start);
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
  
  public void changeState(int x, int y, float angle, int size, int score, float fuelW, float fuelA, float fuelD) {
    this.lock.lock();
    this.state = new State(x, y, angle, size, score, fuelW, fuelA, fuelD);
    this.lock.unlock();  
  }
  
  public void drawstatus(int number) {
    lock.lock();
    fill(160,160,160,20);
    rect(3*width/4, height/30 + number*height/9, width/4.5, height/10, height/100);
    fill(0);
    textAlign(LEFT);
    textSize(height/36);
    text(playername,3*width/4+textWidth("a"),height/30 + number*height/9 + 2*textWidth("a"));
    textAlign(LEFT);
    textSize(height/40);
    text("Score: " + state.score,3*width/4+textWidth("a"),height/30 + number*height/9 + 4.5*textWidth("a"));
    textAlign(RIGHT);
    textSize(height/40);
    text("Size: " + state.size,3*width/4+width/4.5-textWidth("a"),height/30 + number*height/9 + 4.25*textWidth("a"));
    textAlign(LEFT);
    textSize(height/40);
    text("Fuel:",3*width/4+textWidth("a"),height/30 + number*height/9 + 6.5*textWidth("a"));
    textAlign(RIGHT);
    textSize(height/40);
    int fuelW = (int) state.fuelW;
    int fuelA = (int) state.fuelA;
    int fuelD = (int) state.fuelD;
    text(fuelW + " " + fuelA + " " + fuelD,3*width/4+width/4.5-textWidth("a"),height/30 + number*height/9 + 6.5*textWidth("a"));
    lock.unlock();
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
