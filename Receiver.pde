class Receiver implements Runnable {
  boolean exit = false;
  
  public void run() {
    while(!exit) {
      System.out.println("Receiving");
      player.receive();
    }
  }
  
  public void stop() {
    exit = true;
  }
}
