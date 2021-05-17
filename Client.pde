import java.io.*;
import java.net.*;

public class User {
  String username, password;
  Socket s;
  InputStream input;
  PrintStream out;
  BufferedReader read;
  
  User () {
    // Just to establish connections
    this.username = null;
    this.password = null;
  }
  
  User (String username) {
    // Instantiate all users besides local one
    this.username = username;
    this.password = null;
  }
  
  User (String username, String password) {
    // Instantiate local user
    this.username = username;
    this.password = password;
  }
	
	public void connect (String ip, int port) {
		try{
			Socket s = new Socket(ip, port);
			input = s.getInputStream();
			out = new PrintStream(s.getOutputStream());
			read = new BufferedReader(new InputStreamReader(input)); 
		} catch (Exception e) { System.out.println(e); }		
	}

  public String request (String command) {
    try {
      out.println(command);
      //String line = " ";
      // while(line!=null) {
      //  line = read.readLine();
      //  System.out.println(line);
      //}
      String line = read.readLine();
      // if (line != null) System.out.println(line);
      return line;
    } catch (Exception e) { System.out.println(e); return "Exception"; }
  }
  
  public void close () {
    try {
      out.close();
      s.close();
    } catch (Exception e) { System.out.println(e); }
  }

}
