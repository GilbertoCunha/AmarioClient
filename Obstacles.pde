class Obstacle {
  int x, y, size;

  Obstacle (int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  void draw() {
    int size = 2 * this.size;
    fill(144,133,79);
    noStroke();
    ellipse(x, y, size, size);
  }
}
