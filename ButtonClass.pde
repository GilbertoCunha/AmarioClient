public class Button {
  String text;
  PImage img, imgmouseover;
  public int posX, posY;
  public int sizeX, sizeY;
  private color foregroundColor = color(0, 0, 0);
  private boolean isPressed = false, mouseOver = false;
  
  Button (String imgpath, int posX, int posY, int sizeX, int sizeY) {
    this.img = loadImage(imgpath + "1.png");
    this.imgmouseover = loadImage(imgpath + "2.png");
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.posX = posX - this.sizeX / 2;
    this.posY = posY - this.sizeY / 2;
  }
  
  boolean isPressed () { return this.isPressed; }
  
  void reset () {
    this.isPressed = false;
  }
  
  void draw () {
    checkMouseOverlap ();
    if (this.mouseOver) image(this.imgmouseover, this.posX, this.posY, this.sizeX, this.sizeY);
    else image(this.img, this.posX, this.posY, this.sizeX, this.sizeY);
    fill(this.foregroundColor);
  }
  
  void checkMouseOverlap () {
    if (mouseX >= this.posX && mouseX <= this.posX + this.sizeX && mouseY >= this.posY && mouseY <= this.posY + this.sizeY)
      this.mouseOver = true;
    else 
      this.mouseOver = false;
  }
  
  void buttonMousePressed () {
    if (this.mouseOver) this.isPressed = true;
  }
}
