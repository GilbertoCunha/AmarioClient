String username, password, response = null; // Strings onde são guardados o username e a password
TEXTBOX Username, Password, IP;
User localuser;
boolean loginSuccessful = false;

// Definir cores dos botões
color base = color (140, 140, 140);
color highlight = color (150, 150, 150);
color pressed = color (220, 220, 220);

// Botões de login e criar conta
Button Login;
Button CreateAccount;
Button ChangeIP;

PImage logo, background;

void initSetup () {
  localuser = null;
  
  logo = loadImage("amario.png");
  logo.resize(width/2, width/12);
  background = loadImage("background.png");
  background.resize(width,height);
  
  // Criar textbox para o IP
  IP = new TEXTBOX();
  IP.X = (int) (width/3.6);
  IP.Y = height/2;
  IP.name = "IP";
  
  // Criar textbox para o username
  Username = new TEXTBOX();
  Username.X = width/50;
  Username.Y = height/3;
  Username.name = "Username";
  
  // Criar textbox para a password
  Password = new TEXTBOX();
  Password.X = (int) (width/1.97);
  Password.Y = height/3;
  Password.name = "Password";
  Password.showText = false;
  
  // Criar os botões de login, de criar conta e mudar configuração
  ChangeIP = new Button ("changeip", width / 6, 4 * height / 5, (int) (height/3), (int) (height/6));
  Login = new Button ("login", 3*width / 6, 4 * height / 5, (int) (height/3), (int) (height/6));
  CreateAccount = new Button ("createaccount", 5 * width / 6, 4 * height / 5, (int) (height/3), (int) (height/6));
  
  // Criar botão de sair do jogo
  ExitGame = new Button ("exit", width / 10, height / 10, (int) (height / 4.5), height/7);
}

void initKeyPressed () {
  Username.KEYPRESSED (key, keyCode);
  Password.KEYPRESSED (key, keyCode);
  IP.KEYPRESSED (key, keyCode);
}

void initMousePressed () {
  Username.PRESSED (mouseX, mouseY);
  Password.PRESSED (mouseX, mouseY);
  IP.PRESSED (mouseX, mouseY);
  Login.buttonMousePressed ();
  CreateAccount.buttonMousePressed ();
  ExitGame.buttonMousePressed ();
  ChangeIP.buttonMousePressed();
}

void LoginPressed () {
  // Create user
  localuser = new User(Username.Text, Password.Text);
  
  // Connect with the server
  localuser.connect(ip, loginPort);
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
  localuser.connect(ip, loginPort);
  response = localuser.request(":create_account " + Username.Text + " " + Password.Text);
  response = CreateAccountResponse (response);
  localuser.close();
  localuser = null;
  
  // Show the authentication result
  CreateAccount.reset();
}

void ChangeIPPressed () {
  ip = IP.Text;
  ChangeIP.reset();
  response = "IP changed";
}

void drawInitScreen () {
  image(background, 0, 0);
  image(logo, width / 2 - width/6, height / 7 - width/14, width/3, width/7);
  Username.DRAW();
  Password.DRAW();
  IP.DRAW();
  Login.draw();
  CreateAccount.draw();
  ChangeIP.draw();
  ExitGame.draw();
  if (Login.isPressed()) LoginPressed ();
  else if (CreateAccount.isPressed()) CreateAccountPressed ();
  else if (ExitGame.isPressed()) quit();
  else if (ChangeIP.isPressed()) ChangeIPPressed();
  if (response != null) {
    textSize (height/20);
    textAlign(CENTER);
    fill(0);
    text (response, width/2, 3.3 * height/5);
  }
}

String LoginResponse (String response) {
  String r = "";
  if (response.equals("user_not_found")) r = "User not found";
  else if (response.equals("wrong_authentication")) r = "Username or password incorrect";
  else if (response.equals("user_already_logged")) r = "User already logged in";
  else if (response.equals("ok")) {
    r = "Logged In";
    gameScreen = 1;
    initMenuSetup();
    Username.reset();
    Password.reset();
    IP.reset();
  }
  return r;
}

String CreateAccountResponse (String response) {
  String r = "";
  if (response.equals("user_exists")) r = "User already in use";
  else if (response.equals("ok")) r = "Account successfully created";
  return r;
}
