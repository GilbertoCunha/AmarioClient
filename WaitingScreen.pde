int players_ahead = 0;

void waitingScreenMousePressed () {
  Quit.buttonMousePressed();
}

void drawWaitingScreen () {
  image(background, 0, 0);
  Quit.draw();
  
  stroke(height/36);
  fill(230,150);
  rect(width/4,height/2.9,width/2,height/3);
  fill(0);
  noStroke();
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
