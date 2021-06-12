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
    localuser.connect(ip, loginPort);
    response = localuser.request(":login " + localuser.username + " " + localuser.password);
    response = LoginResponse (response);
    localuser.close();
    
    gameScreen = 1;
    exit = 0;
  }
  
  public void terminate () {
    exit = 1;
  }
}
