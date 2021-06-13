class Creature {
  Lock lock;
  color cor;
  int x, y, size;
  float angle;
  
  Creature (String cor, int x, int y, int size, float angle) {
    if (cor.equals("red")) this.cor = color(255,0,0);
    else this.cor = color(0,128,0);
    this.x = x;
    this.y = y;
    this.size = size;
    this.angle = angle;
    lock = new ReentrantLock();
  }
  
  public void changeState(int x, int y, int size, float angle) {
    this.lock.lock();
    this.x = x;
    this.y = y;
    this.size = size;
    this.angle = angle;
    this.lock.unlock();  
  }
  
  public void draw() {
    lock.lock();
    fill(cor);
    stroke(200);
    strokeWeight(0);
    int size = 2 * this.size;
    ellipse(x, y, size, size);
    stroke(0);
    strokeWeight(height/300);
    drawArrow(x, y, size/2, angle);
    lock.unlock();  
  }
}
