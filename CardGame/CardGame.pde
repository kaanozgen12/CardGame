import processing.net.*;

volatile GameServer CardGameServer;
GameClient client;

final int port = 8888;

void setup(){
  //fullScreen();
  size(600,600);
  img = loadImage("cards.png");
  img.loadPixels();
  
  table = new Table();
  
  if(img != null)
  deck = new Deck(img);
  else
  deck = new Deck();
  
  cards = deck.createDeck();
  
  /*for(int i = 0; i < 52; i++) {
    String[] k = cards[i].returnInfo();
    println("card: " + k[0] + " of " + k[1]);  
    cards[i].demoDraw();
  }*/
  
  
  
  
  //println(img.width + " " + img.height + " ");
}
Table table;
Deck deck;
Card[] cards;
PImage img = null;

void drawDemoCards(){
  table.draw();//FIRST DRAW THE TABLE
  
  for(int i = 0; i < cards.length; i++) {
    cards[i].demoDraw();
  }

} //<>//

public int getUserOptionForGame(){  //0 FOR CREATING SERVER 1 FOR JOINING TO A SERVER
    background(150);
    rectMode(CORNER);
    stroke(255);
    fill(200);
    
    rect(0,0,width,height/2);
    fill(0);
    textAlign(CENTER);
    textSize(60);
    text("Create Server",width/2,height/4);
    
    fill(255,255,0);
    rect(0,height/2,width,height/2);
    fill(0);
    text("Join a Server",width/2,3*height/4);
    
    if(mousePressed   && mouseY <= height/2){
      return 0;
    }else if(mousePressed && mouseY <= 3*height/4){
     return 1;
    }else return -1;
    
    
}
int retVal = -1;
int threadCount = 0;
void draw(){
  background(0);//CLEAR BACKGROUND AT EVERY FRAME TO BLACK
  //ASK USER TO CREATE/JOIN A SERVER
  if(CardGameServer != null);// println(CardGameServer.runStatus + " " + retVal);
    if(retVal == -1){
      retVal = getUserOptionForGame();    
    }
    else if(retVal == 0){//CREATE A SERVER
    
  //println("Background " + retVal);
      if(threadCount == 0){
        thread("createServer");
        println("Create Server");
        threadCount++;
        //println(threadCount);
      }
      
      while(CardGameServer == null){println("Waiting"); delay(1000);}
      //println(CardGameServer.runStatus);
      if(CardGameServer.runStatus){
              CardGameServer.game();
      }
      //println("ex");
    }else if(retVal == 1){//JOIN A SERVER
      if(client == null){
        client = new GameClient();
        
        ArrayList<String> servers = client.GetServerInfo();
        
        println("ServersLength " + servers.size());
        
        println("client.GetServerInfo()");
      }
    }else{  //USER DID NOT PRESS ANYTHING
        println("Else");
    }
  
    
  
  
  
}

void createServer(){
  //println("CreateServer Thread");
  CardGameServer = new GameServer();
  CardGameServer.server = new Server(this,port);
  CardGameServer.BroadcastServerInfo();
}
