import java.io.*;
import java.net.*;

class GameServer{
  final int port = 8888;
  public final int delayMillis = 1000;
  DatagramSocket datagramSocket;
  DatagramPacket datagramPacket;
  Server server;
  Client client;
  
  int clientCount = 0;
  
   byte[] buf = new byte[1000];
   DatagramPacket dp = new DatagramPacket(buf, buf.length);
  
  byte[] buffer;
  String Token;
  public GameServer(){
    
      runStatus = true;
      println("runStatus " + runStatus);
      
      
       //<>// //<>//
      //datagramSocket.send(datagramPacket);
      //datagramSocket.receive(dp);
      //String h = new String(dp.getData(), 0, dp.getLength());
      //println("Received " /*+ h*/ + datagramPacket.getSocketAddress());
      //println("DatagramPacket length " + datagramPacket.getLength());
      //String a = new String(datagramPacket.getData(),0,datagramPacket.getLength()); //<>//
      //println("Sent " + a + " " + datagramSocket.getInetAddress().getHostAddress() );
  }

  public volatile boolean runStatus = false;
    public void BroadcastServerInfo(){
        if(runStatus == true){
          try {
            Token = new String("CardGameServer" + InetAddress.getLocalHost().getHostAddress());
            buffer = Token.getBytes();
            println(Token);
            
            InetSocketAddress broadcast = new InetSocketAddress("255.255.255.255",port);
            println("Address " + broadcast.getHostString() + " port " + broadcast.getPort());
            datagramSocket = new DatagramSocket(null);
            
            datagramSocket.setBroadcast(true);
            datagramSocket.bind(new InetSocketAddress(broadcast.getPort()));
            
            datagramPacket = new DatagramPacket(buffer, buffer.length,broadcast.getAddress(),port);
            
            while(runStatus == true){
              datagramSocket.send(datagramPacket);
              delay(delayMillis);
              //println("Sent again");
            }
            
          }catch(Exception e){
          println("Exception on GameServer");
          e.printStackTrace();
        }
      }
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
