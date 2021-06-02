String username, password, response = null; // Strings onde são guardados o username e a password
TEXTBOX Username, Password;
User localuser;
boolean loginSuccessful = false;

// Definir cores dos botões
color base = color (140, 140, 140);
color highlight = color (150, 150, 150);
color pressed = color (220, 220, 220);

// Botões de login e criar conta
Button Login;
Button CreateAccount;

void initSetup () {
  // Criar textbox para o username
  Username = new TEXTBOX();
  Username.X = width/2;
  Username.Y = height/2 - 50;
  Username.name = "Username";
  
  // Criar textbox para a password
  Password = new TEXTBOX();
  Password.X = width/2;
  Password.Y = height/2 + 50;
  Password.name = "Password";
  Password.showText = false;
  
  // Criar os botões de login e de criar conta
  Login = new Button (width / 3, 4 * height / 5, 400, 80);
  Login.setup (base, highlight, pressed, "Login", true);
  CreateAccount = new Button (2 * width / 3, 4 * height / 5, 400, 80);
  CreateAccount.setup (base, highlight, pressed, "Create Account", true);
}

void initKeyPressed () {
  Username.KEYPRESSED (key, keyCode);
  Password.KEYPRESSED (key, keyCode);
}

void initMousePressed () {
  Username.PRESSED (mouseX, mouseY);
  Password.PRESSED (mouseX, mouseY);
  Login.buttonMousePressed ();
  CreateAccount.buttonMousePressed ();
}

void LoginPressed () {
  // Create user
  System.out.println(Username.Text);
  localuser = new User(Username.Text, Password.Text);
  
  // Connect with the server
  localuser.connect("192.168.1.80", 80);
  response = localuser.request(":login " + Username.Text + " " + Password.Text);
  response = LoginResponse (response);
  localuser.close();
  
  // Show the authentication result
  Login.reset();
}

void CreateAccountPressed () {
  // Create user
  localuser = new User();
  
  // Connect with the server
  localuser.connect("192.168.1.80", 80);
  response = localuser.request(":create_account " + Username.Text + " " + Password.Text);
  response = CreateAccountResponse (response);
  localuser.close();
  
  // Show the authentication result
  CreateAccount.reset();
}

void drawInitScreen () {
  background(255);
  Username.DRAW();
  Password.DRAW();
  Login.draw();
  CreateAccount.draw();
  if (Login.isPressed()) LoginPressed ();
  else if (CreateAccount.isPressed()) CreateAccountPressed ();
  if (response != null) {
    textSize (20);
    textAlign(LEFT);
    text (response, Login.posX, Login.posY + 100);
  }
}

String LoginResponse (String response) {
  String r = "";
  System.out.println("Login Response: \"" + response + "\"");
  if (response.equals("user_not_found")) r = "User not found";
  else if (response.equals("wrong_authentication")) r = "Username or password incorrect";
  else if (response.equals("ok")) {
    r = "Logged In";
    gameScreen = 1;
    initMenuSetup();
    Username.reset();
    Password.reset();
  }
  return r;
}

String CreateAccountResponse (String response) {
  String r = "";
  System.out.println("Create Account Response: \"" + response + "\"");
  if (response.equals("user_exists")) r = "User already in use";
  else if (response.equals("ok")) r = "Account successfully created";
  return r;
}
