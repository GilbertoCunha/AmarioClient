public class Button {
  String text;
  int textSize = 40;
  int posX, posY;
  int sizeX, sizeY;
  color baseColor, highlightColor, foregroundColor = color(0, 0, 0);
  boolean isPressed = false, mouseOver = false;
  
  Button (int posX, int posY, int sizeX, int sizeY) {
    this.posX = posX;
    this.posY = posY;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
  }
  
  void setup (color base, color highlight, String text) {
    this.baseColor = base;
    this.highlightColor = highlight;
    this.text = text;
  }
  
  void draw () {
    checkMouseOverlap ();
    if (mouseOver) fill(this.highlightColor);
    else fill (this.baseColor);
    rect(this.posX, this.posY, this.sizeX, this.sizeY);
    fill(this.foregroundColor);
    textSize (this.textSize);
    text (this.text, posX, posY);
  }
  
  void checkMouseOverlap () {
    if (mouseX >= this.posX && mouseX <= this.posX + this.sizeX && mouseY >= this.posY && mouseY <= this.posY + this.sizeY)
      this.mouseOver = true;
    else 
      this.mouseOver = false;
  }
  
  void mousePressed () {
    this.isPressed = this.mouseOver;
  }
}
