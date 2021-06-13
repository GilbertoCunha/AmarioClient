class Obstacle {
  int x, y, size;

  Obstacle (int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  void draw() {
    int size = 2 * this.size;
    image(obstacle_img, x-size/2,y-size/2,size,size);
  }
}
