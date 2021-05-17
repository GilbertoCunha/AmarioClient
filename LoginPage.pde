String username, password; // Strings onde são guardados o username e a password
ArrayList<TEXTBOX> textboxes = new ArrayList<TEXTBOX>(); // Caixas de texto de username e password
Button Login = new Button (width / 3, height, 200, 50);
Button CreateAccount = new Button (2 * width / 3, height, 200, 50);

void initSetup () {
  TEXTBOX username = new TEXTBOX();
  username.X = width/2;
  username.Y = height/2 + 50;
  textboxes.add(username);
  
  TEXTBOX password = new TEXTBOX();
  password.X = width/2;
  password.Y = height/2 - 50;
  textboxes.add(password);
  
  Login.setup (color(140, 140, 140), color(160, 160, 160), "Login");
  CreateAccount.setup (color(140, 140, 140), color(160, 160, 160), "Create Account");
  System.out.println("Width: " + width + " | Height: " + height);
}

void drawInitScreen () {
  background(255);
  // textAlign(CENTER);
  for (TEXTBOX t: textboxes) t.DRAW();
  Login.draw();
  CreateAccount.draw();
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
    } 
    i += 1;
  }
}
