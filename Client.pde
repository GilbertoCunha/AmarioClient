import java.io.*;
import java.net.*;

public class Client {
	
	public static void main(String[] args) {
		try{
			Socket s = new Socket("localhost", 26);
			InputStream input = s.getInputStream();
			//DataInputStream din = new DataInputStream(s.getInputStream());
			PrintStream out = new PrintStream(s.getOutputStream());
			BufferedReader read = new BufferedReader(new InputStreamReader(input)); 
			dout.println(":create_account broas broas");
			String line = " ";
			while(line!=null){
				line = read.readLine();
				System.out.println(line);
			}
			dout.close();
			s.close();
		} catch (Exception e) { System.out.println(e); }		
	}
}

