class Receiver implements Runnable {
  boolean exit = false;
  
  public void run() {
    while(!exit) {
      player.receive();
    }
  }
  
  public void stop() {
    exit = true;
  }
}
