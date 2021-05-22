int x_pos, y_pos;
int size = width/4;
int player_color = color(0);

void setupGame(){
  x_pos = width/5;
  y_pos = height/5;
  
}

void drawPlayer () {
  fill(player_color);
  ellipse(x_pos, y_pos, size, size);
}

void playerkeyPressed () {
  if (keyCode == UP) y_pos-=5;
  else if (keyCode == LEFT) x_pos-=5;
  else if (keyCode == RIGHT) x_pos+=5;
}

void drawGameScreen () {
  background(255);
  drawPlayer();
}
