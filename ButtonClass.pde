public class Button {
  String text;
  private int textSize = 40;
  public int posX, posY;
  public int sizeX, sizeY;
  private color baseColor, highlightColor, pressedColor, foregroundColor = color(0, 0, 0);
  private boolean isPressed = false, mouseOver = false, textCenter = false;
  
  Button (int posX, int posY, int sizeX, int sizeY) {
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.posX = posX - this.sizeX / 2;
    this.posY = posY - this.sizeY / 2;
  }
  
  boolean isPressed () { return this.isPressed; }
  
  void setup (color base, color highlight, color pressed, String text, boolean center) {
    this.baseColor = base;
    this.highlightColor = highlight;
    this.pressedColor = pressed;
    this.text = text;
    this.textCenter = center;
  }
  
  void reset () {
    this.isPressed = false;
  }
  
  void draw () {
    checkMouseOverlap ();
    if (this.isPressed) fill (this.pressedColor);
    else if (this.mouseOver) fill(this.highlightColor);
    else fill (this.baseColor);
    rect(this.posX, this.posY, this.sizeX, this.sizeY);
    fill(this.foregroundColor);
    if (this.textCenter) textAlign (CENTER);
    textSize (this.textSize);
    text (this.text, this.posX + this.sizeX / 2, this.posY + this.sizeY / 2 + this.textSize / 2);
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
