class Creature {
  Lock lock;
  color cor;
  int x, y, size;
  
  Creature (String cor, int x, int y, int size) {
    if (cor.equals("red")) this.cor = color(255,0,0);
    else this.cor = color(0,128,0);
    this.x = x;
    this.y = y;
    this.size = size;
    lock = new ReentrantLock();
  }
  
  public void changeState(int x, int y, int size) {
    this.lock.lock();
    this.x = x;
    this.y = y;
    this.size = size;
    this.lock.unlock();  
  }
  
  public void draw() {
    lock.lock();
    fill(cor);
    stroke(200);
    strokeWeight(0);
    int size = 2 * this.size;
    ellipse(x, y, size, size);
    lock.unlock();  
  }
}
