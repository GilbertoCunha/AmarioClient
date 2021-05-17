String username, password; // Strings onde são guardados o username e a password
ArrayList<TEXTBOX> textboxes = new ArrayList<TEXTBOX>(); // Caixas de texto de username e password

// Definir cores dos botões
color base = color (140, 140, 140);
color highlight = color (150, 150, 150);
color pressed = color (220, 220, 220);

// Botões de login e criar conta
Button Login;
Button CreateAccount;

void initSetup () {
  // Criar textbox para o username
  TEXTBOX username = new TEXTBOX();
  username.X = width/2;
  username.Y = height/2 - 50;
  username.name = "Username";
  textboxes.add(username);
  
  // Criar textbox para a password
  TEXTBOX password = new TEXTBOX();
  password.X = width/2;
  password.Y = height/2 + 50;
  password.name = "Password";
  textboxes.add(password);
  
  // Criar os botões de login e de criar conta
  Login = new Button (width / 3, 4 * height / 5, 400, 50);
  Login.setup (base, highlight, pressed, "Login");
  CreateAccount = new Button (2 * width / 3, 4 * height / 5, 400, 50);
  CreateAccount.setup (base, highlight, pressed, "Create Account");
}

void drawInitScreen () {
  background(255);
  for (TEXTBOX t: textboxes) t.DRAW();
  Login.draw();
  CreateAccount.draw();
  if (Login.isPressed()) LoginPressed ();
  else if (CreateAccount.isPressed()) CreateAccountPressed ();
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

void initMousePressed () {
  for (TEXTBOX t: textboxes) t.PRESSED (mouseX, mouseY);
  Login.buttonMousePressed ();
  CreateAccount.buttonMousePressed ();
}

void LoginPressed () {
  textSize (20);
  text ("Logged In !", width / 2 - 50, Login.posY + 80);
}

void CreateAccountPressed () {
  textSize (20);
  text ("Account created !", width / 2 - 80, Login.posY + 80);
}
