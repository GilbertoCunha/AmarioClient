class Receiver implements Runnable {
  int exit = 0;
  
  public void run() {
    while(exit == 0) {
      exit = player.receive();
    }
    player.close();
    players.clear();
    gameScreen = 1;
  }
}
