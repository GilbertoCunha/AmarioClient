public class Player {
  String playername;
  Socket s;
  InputStream input;
  PrintStream out;
  BufferedReader read;
  
  Player () {
    // Just to establish connections
    this.playername = null;
  }
  
  public void connect (String ip, int port) {
    try{
      s = new Socket(ip, port);
      input = s.getInputStream();
      out = new PrintStream(s.getOutputStream());
      read = new BufferedReader(new InputStreamReader(input)); 
    } catch (Exception e) { System.out.println(e); }    
  }
  
  public String receive () {
    try {
      String line = read.readLine();
      return line;
    } catch (Exception e) { System.out.println(e); return "Exception"; }
  }
  
  public void send (String command) {
    try {
      out.println(command);
    } catch (Exception e) { System.out.println(e); }
  }
  
  public void close () {
    try {
      out.close();
      s.close();
    } catch (Exception e) { System.out.println(e); }
  }
  
}
