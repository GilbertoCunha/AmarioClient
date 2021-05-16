int inputTextState = 0;
boolean credentials = false;
String username, password;
ArrayList<TEXTBOX> textboxes = new ArrayList<TEXTBOX>();

void initSetup () {
  TEXTBOX username = new TEXTBOX();
  username.X = width/2;
  username.Y = height/2 + 50;
  textboxes.add(username);
  
  TEXTBOX password = new TEXTBOX();
  password.X = width/2;
  password.Y = height/2 - 50;
  textboxes.add(password);
}

void drawInitScreen () {
  background(255);
  // textAlign(CENTER);
  for (TEXTBOX t: textboxes) t.DRAW();
  // if (inputTextState == 0) text("Username: " + inputText, height/2, width/2);
  // else if (inputTextState == 1) text("Username detected\n", height/2, width/2);
}

void initMousePressed () {
  for (TEXTBOX t: textboxes) t.PRESSED (mouseX, mouseY);
}

void initKeyPressed () {
  int i=0;
  for (TEXTBOX t: textboxes) {
    if (t.KEYPRESSED (key, keyCode)) { // User has pressed ENTER
      if (i==0) username = textboxes.get(0).Text;
      else if (i==1) password = textboxes.get(1).Text;
      inputTextState += 1;
      if (inputTextState == 2) credentials = true;
    } 
    i += 1;
  }
}
