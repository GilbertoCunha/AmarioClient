int players_ahead = 0;

void waitingScreenMousePressed () {
  Quit.buttonMousePressed();
}

void drawWaitingScreen () {
  background(255);
  Quit.draw();
  
  textAlign(CENTER);
  textSize(height/12);
  text("Position in Queue:\n" + players_ahead, width/2, height/2);
  
  try {
    // If exit is pressed
    if (Quit.isPressed()) {
      runnable.terminate();
      receiver.join();
      gameScreen = 1;
    }
  } catch (Exception e) { System.out.println(e); }
}
