class Receiver implements Runnable {
  volatile int exit = 0;
  Lock lock = new ReentrantLock();
  
  @Override
  public void run() {
    while(exit == 0) {
      exit = player.receive() + exit;
    }
    player.close();
    players.clear();
    creatures.clear();
    
    // Login again
    localuser.connect("localhost", 80);
    response = localuser.request(":login " + localuser.username + " " + localuser.password);
    response = LoginResponse (response);
    localuser.close();
    
    System.out.println("Re-login: " + response);
    gameScreen = 1;
  }
  
  public void terminate () {
    System.out.println("Terminated");
    exit = 1;
  }
}
