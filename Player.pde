import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

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
  // line(0,0,len, 0);
  line(len, 0, len - 8, -8);
  line(len, 0, len - 8, 8);
  popMatrix();
}

public class Player {
  String playername, imgpath;
  Lock lock;
  Socket s;
  InputStream input;
  PrintStream out;
  BufferedReader read;
  State state;
  PImage img;
  
  Player (String name, String imgpath) {
    // Just to establish connections
    this.playername = name;
    this.lock = new ReentrantLock();
    this.imgpath = imgpath;
    this.img = loadImage(imgpath);
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
  
  public int receive () {
    int r = 0;
    try {
      String line = read.readLine();
      String[] nums = line.split(" ");
      
      if (nums[1].equals("left") || nums[1].equals("lost")) {
        playerslock.lock();
        String imgpath = players.get(nums[0]).imgpath;
        players.remove(nums[0]);
        playerslock.unlock();
        if (nums[0].equals(this.playername)) r = 1;
        for (int j=0; j<3; ++j) if (imgpath.equals(player_avatars[j])) avatar_free[j] = true;
        numplayers--;
      } else if (nums[1].equals("died")) {
        creatureslock.lock();
        creatures.remove(nums[0]);
        creatureslock.unlock();
      } else if (nums[0].equals("obstacles")) {
        int num_obstacles = Integer.parseInt(nums[1]);
        minSize = (int) (height * Float.parseFloat(nums[2]));
        maxSize = (int) (height * Float.parseFloat(nums[3]));
        int x, y, size;
        obstacleslock.lock();
        obstacles = new Obstacle[num_obstacles];
        for (int i=0; i<num_obstacles; ++i) {
          nums = read.readLine().split(" ");
          x = (int) (height * Double.parseDouble(nums[0]));
          y = (int) (height * Double.parseDouble(nums[1]));
          size = (int) (height * Double.parseDouble(nums[2]));
          obstacles[i] = new Obstacle(x, y, size);
        }
        obstacleslock.unlock();
      } else if (nums[1].equals("added")) {
        gameScreen = 2;
      } else if (nums[1].equals("ahead")) {
        players_ahead = Integer.parseInt(nums[0]);
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
          score = (int) (Float.parseFloat(nums[5])); 
          fuelW = Float.parseFloat(nums[6]);
          fuelA = Float.parseFloat(nums[7]);
          fuelD = Float.parseFloat(nums[8]);
          
          playerslock.lock();
          if (!players.containsKey(nums[0])) {
            String player_image; int j;
            for (j = 0; j<3 && !avatar_free[j]; ++j);
            player_image = player_avatars[j];
            Player novo = new Player(nums[0], player_image);
            novo.img.resize(minSize, minSize);
            players.put(nums[0], novo);
            avatar_free[j] = false;
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
          angle = Float.parseFloat(nums[5]);
          
          creatureslock.lock();
          if (!creatures.containsKey(nums[0])) creatures.put(nums[0], new Creature(cor, x, y, size, angle));
          else creatures.get(nums[0]).changeState(x, y, size, angle);
          creatureslock.unlock();
        }
      }
      return r;
    } catch (Exception e) { 
      System.out.println(e); 
      return r;
    } 
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
    if (state != null) {
      fill(230, 150);
      rect(3*width/4, height/30 + number*height/9, width/4.5, height/10, height/100);
      fill(0);
      textAlign(LEFT);
      textSize(height/36);
      text(playername,3*width/4+textWidth("a"),height/30 + number*height/9 + 2*textWidth("a"));
      textAlign(LEFT);
      textSize(height/40);
      text("Score: " + state.score, 3*width/4+textWidth("a"),height/30 + number*height/9 + 4.25*textWidth("a"));
      textAlign(RIGHT);
      textSize(height/40);
      text("Size:",3*width/4+width/8-textWidth("a"),height/30 + number*height/9 + 4.25*textWidth("a"));
      textAlign(LEFT);
      textSize(height/40);
      text("Fuel:",3*width/4+textWidth("a"),height/30 + number*height/9 + 6.5*textWidth("a"));
      textAlign(RIGHT);
      textSize(height/40);
      float fuelW = (float) state.fuelW;
      float fuelA = (float) state.fuelA;
      float fuelD = (float) state.fuelD;
      
      if(fuelW > 0.6) fill(0, 255, 0); //nível alto de combustível: verde
      else if(fuelW > 0.3) fill(255, 255, 0); //nível médio de combustível: amarelo
      else if(fuelW < 0.3) fill(255, 0, 0); //nível baixo de combustível: vermelho
      rect(3*width/4+5.5*textWidth("a"),height/30 + number*height/9 + 4.9*textWidth("a"), height/3.35*fuelW, height/205);
      
      if(fuelA > 0.6) fill(0, 255, 0);
      else if(fuelA > 0.3) fill(255, 255, 0);
      else if(fuelA < 0.3) fill(255, 0, 0);
      rect(3*width/4+5.5*textWidth("a"),height/30 + number*height/9 + 5.7*textWidth("a"), height/3.35*fuelA, height/205);
      
      if(fuelD > 0.6) fill(0, 255, 0);
      else if(fuelD > 0.3) fill(255, 255, 0);
      else if(fuelD < 0.3) fill(255, 0, 0);
      rect(3*width/4+5.5*textWidth("a"),height/30 + number*height/9 + 6.5*textWidth("a"), height/3.35*fuelD, height/205);
      
      float size = (float) (state.size - minSize) / (float) (maxSize - minSize);
      if(size > 0.6) fill(0, 255, 0);
      else if(size > 0.3) fill(255, 255, 0);
      else if(size < 0.3) fill(255, 0, 0);
      rect(3*width/4+width/8-textWidth("a"),height/30 + number*height/9 + 3.5*textWidth("a"), height/6*size, height/205);
      
    }
    lock.unlock();
  }
  
  public void draw() {
    lock.lock();
    if (this.state != null) {
      image(this.img, state.x - state.size, state.y - state.size, 2*state.size, 2*state.size);
      stroke(0);
      strokeWeight(2);
      drawArrow(state.x, state.y, state.size, state.angle);
    }
    lock.unlock();  
  }
  
}
