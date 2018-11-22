import java.io.*;
import java.net.*;

class GameClient{
  final int port = 8888;
  public final int delayMillis = 1000;
  DatagramSocket datagramSocket;
  DatagramPacket datagramPacket;
  Server server;
  Client client;
  
  int clientCount = 0;
  
   byte[] buf = new byte[1000];
   DatagramPacket dp = new DatagramPacket(buf, buf.length);
  
  
  String Token;
  public GameClient(){
    
      runStatus = true;
      //println("runStatus " + runStatus);
      
      
       //<>//
      //datagramSocket.send(datagramPacket);
      //datagramSocket.receive(dp);
      //String h = new String(dp.getData(), 0, dp.getLength());
      //println("Received " /*+ h*/ + datagramPacket.getSocketAddress());
      //println("DatagramPacket length " + datagramPacket.getLength());
      //String a = new String(datagramPacket.getData(),0,datagramPacket.getLength());
      //println("Sent " + a + " " + datagramSocket.getInetAddress().getHostAddress() );
  }

  public volatile boolean runStatus = false;
    public ArrayList<String> GetServerInfo(){
      ArrayList<String> retArray = new ArrayList<String>();
        if(runStatus == true){
          try {
            InetSocketAddress broadcast = new InetSocketAddress("255.255.255.255",port);
            println("Address " + broadcast.getHostString() + " port " + broadcast.getPort());
            
            datagramSocket = new DatagramSocket(null);
            datagramSocket.setBroadcast(true);
            datagramSocket.bind(new InetSocketAddress(broadcast.getPort()));
            datagramPacket = new DatagramPacket(buf, buf.length,broadcast.getAddress(),port);
            
            int s = second();  // Values from 0 - 59
            int m = minute();  // Values from 0 - 59
            int h = hour();    // Values from 0 - 23
  
            while(runStatus == true){
              datagramSocket.setSoTimeout(10000);  //WAIT 10 SECONDS
              datagramSocket.receive(datagramPacket);
              
              String answer = new String(buf,0,datagramPacket.getLength());
              println("Received Packet: " + answer);  //CONTROL THE STRING AND COLLECT IP ADRESSES
              
              if(answer.length() > 0){
                if(answer.startsWith("CardGameServer")){  //MEANS THE SAME APPLICATION
                  String k = new String(answer.subSequence(14,answer.length()).toString());
                  retArray.add(k);
                }else{
                  println("Message: " + answer);
                }
              }
              
              int s2 = second();  // Values from 0 - 59
              int m2 = minute();  // Values from 0 - 59
              int h2 = hour();    // Values from 0 - 23
              if(h2 - h > 0) break;
              else if(m2 - m > 0) break;
              else if(s2 - s > 2) break;  //WAIT FOR AT MOST 2 SECONDS
              //println("Sent again");
            }
            
          }catch(Exception e){
          println("Exception on GameClient");
          e.printStackTrace();
        }
      }
      println("RetArray length " + retArray.size());
      return retArray;
    }
    
    public void game(){
      //println("Game");
      if(clientCount == 0){
        background(0,255,0);
        textAlign(CENTER);
        stroke(0);
        fill(255);
        text("Waiting For Player",width/2,height/2);
      }
      if(server != null && server.active() && client == null){
        if(client == null){
          client = server.available();
          if(client != null)
          println("Client Connected");
          if(client == null);
          println("Waiting client");
        }
        
        
      }else if(client != null){
          String ClientResponse = client.readString();
          if(ClientResponse != null){
          
          }
          
          
      }
    
    }
    
    public void accept(DatagramSocket socket, DatagramPacket packet){
    
    
    }
    
}
