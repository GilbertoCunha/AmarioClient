class Receiver implements Runnable {
  int exit = 0;
  
  public void run() {
    while(exit == 0) {
      exit = player.receive();
    }
    player.close();
    players.clear();
    
    // Login again
    localuser.connect("localhost", 80);
    response = localuser.request(":login " + Username.Text + " " + Password.Text);
    response = LoginResponse (response);
    localuser.close();
    
    System.out.println("Re-login: " + response);
    gameScreen = 1;
  }
}
