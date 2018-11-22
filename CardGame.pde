import java.util.Collections;
import java.io.*;
import java.net.*;

//volatile GameServer CardGameServer;
//GameClient client;
final int port = 8888;
Table table;
ArrayList<Card> cards=new ArrayList<Card>();
Card deck_symbol;
float easing = 0.05;
boolean dragging=false;
final int User_No=1;
ArrayList<Card> my_hand= new ArrayList<Card>();
ArrayList<Card> opponent_hand= new ArrayList<Card>();
Card i_am_dragging=null;
boolean invisibleCardAdded=false;
int invisibleCardIndex=0;
Card card_flying_to_me;
Card card_flying_to_opponent;
ArrayList<Card> deck = new ArrayList<Card>();

void setup(){
  //fullScreen();
  //size(600,600);
  fullScreen(P2D, 1);
  table = new Table();
  deck_symbol = new Card(0,((float)(width-55))/width,0.5,false);
  for(int i=1 ; i<=52;i++){
    deck.add(new Card(i,deck_symbol.x_position*width,deck_symbol.y_position*height,false));
  }
  Collections.shuffle(deck);
  
}

void drawDemoCards(){
  table.draw();//FIRST DRAW THE TABLE
  deck_symbol.demoDraw();
  fill(225);
  rect(width/2-55, height/2, 55, 80);// DRAW CARD BASE 1
  rect(width/2+55, height/2, 55, 80);//DRAW CARD BASE 2
  for(int i = 0; i < my_hand.size(); i++) {
    my_hand.get(i).demoDraw();
  }for(int i = 0; i < opponent_hand.size(); i++) {
    opponent_hand.get(i).demoDraw();
  }
  if(card_flying_to_me !=null){
  card_flying_to_me.demoDraw();
  }if(card_flying_to_opponent !=null){
  card_flying_to_opponent.demoDraw();
  }if(i_am_dragging !=null){
  i_am_dragging.demoDraw();
  }
  
} //<>//

void mouseDragged() {
      if(dragging==false){
    for(int i = 0; i < my_hand.size(); i++) {
      if (my_hand.get(i).collision(mouseX, mouseY)&&my_hand.get(i).cardselected==false&&!dragging) {
        dragging=true;
        my_hand.get(i).clicked_x_margin=((float)mouseX)/width-my_hand.get(i).x_position;
        my_hand.get(i).clicked_y_margin=((float)(mouseY))/height-my_hand.get(i).y_position;
       i_am_dragging= my_hand.get(i);
       my_hand.remove(i);
          }
      }
    }
      if(i_am_dragging!=null&&(i_am_dragging.y_position>(height-200.0)/height) && (i_am_dragging.x_position>((width/2.0)-((my_hand.size()+1)/2.0)*55-(my_hand.size()*5.0))/width || i_am_dragging.x_position<((width/2.0)+((my_hand.size()+1)/2.0)*55+(my_hand.size()*5.0))/width)){
      float targetX = mouseX;
        float dx = ((float)targetX)/width - i_am_dragging.x_position-i_am_dragging.clicked_x_margin;
        i_am_dragging.x_position += (dx);
        float targetY = mouseY;
        float dy = ((float)targetY)/height - i_am_dragging.y_position -i_am_dragging.clicked_y_margin;
        i_am_dragging.y_position += (dy);
        int temp;
        if(invisibleCardAdded==true){
          temp=(width/2)-Math.round(((my_hand.size())/2.0)*55+((my_hand.size())/2)*5);
         my_hand.remove(invisibleCardIndex);
        }else{
          temp=(width/2)-Math.round(((my_hand.size()+1)/2.0)*55+((my_hand.size()+1)/2)*5);
        }
        
        invisibleCardIndex= (mouseX-temp)/55 ;
        if(invisibleCardIndex>=my_hand.size()){
        invisibleCardIndex=my_hand.size();
        }else if(invisibleCardIndex<0){
        invisibleCardIndex=0;
        }
        invisibleCardAdded=true;
        my_hand.add(invisibleCardIndex,new Card(0,0,0,true));
        
      }else if(i_am_dragging!=null&& invisibleCardAdded&& !(i_am_dragging.y_position>(height-200.0)/height) ){
      float targetX = mouseX;
        float dx = ((float)targetX)/width - i_am_dragging.x_position-i_am_dragging.clicked_x_margin;
        i_am_dragging.x_position += (dx);
        float targetY = mouseY;
        float dy = ((float)targetY)/height - i_am_dragging.y_position -i_am_dragging.clicked_y_margin;
        i_am_dragging.y_position += (dy);
        my_hand.remove(invisibleCardIndex);
        invisibleCardAdded=false;
      }else if(i_am_dragging!=null){
      float targetX = mouseX;
        float dx = ((float)targetX)/width - i_am_dragging.x_position-i_am_dragging.clicked_x_margin;
        i_am_dragging.x_position += (dx);
  
        float targetY = mouseY;
        float dy = ((float)targetY)/height - i_am_dragging.y_position -i_am_dragging.clicked_y_margin;
        i_am_dragging.y_position += (dy);
      }
}
void mouseReleased(){
  if(i_am_dragging!=null && (i_am_dragging.y_position>(height-200.0)/height) ){
        dragging=false;
        if(invisibleCardAdded==true){
        invisibleCardAdded=false;
         my_hand.remove(invisibleCardIndex);
         my_hand.add(invisibleCardIndex,i_am_dragging);
        i_am_dragging=null;
        invisibleCardIndex=0;
        }
  }else if(i_am_dragging!=null){
        dragging=false;
        my_hand.add(i_am_dragging);
        i_am_dragging=null;
      }
}

//public int getUserOptionForGame(){  //0 FOR CREATING SERVER 1 FOR JOINING TO A SERVER
//    background(150);
//    rectMode(CORNER);
//    stroke(255);
//    fill(200);
    
//    rect(0,0,width,height/2);
//    fill(0);
//    textAlign(CENTER);
//    textSize(60);
//    text("Create Server",width/2,height/4);
    
//    fill(255,255,0);
//    rect(0,height/2,width,height/2);
//    fill(0);
//    text("Join a Server",width/2,3*height/4);
    
//    if(mousePressed   && mouseY <= height/2){
//      return 0;
//    }else if(mousePressed && mouseY <= 3*height/4){
//     return 1;
//    }else return -1;
    
    
//}
int retVal = -1;
int threadCount = 0;
void draw(){
  background(0);//CLEAR BACKGROUND AT EVERY FRAME TO BLACK
  //ASK USER TO CREATE/JOIN A SERVER
  /*if(CardGameServer != null);// println(CardGameServer.runStatus + " " + retVal);
    if(retVal == -1){
      retVal = getUserOptionForGame();    
    }
    else if(retVal == 0){//CREATE A SERVER
    */
  //println("Background " + retVal);
      /*if(threadCount == 0){
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
  
    
   */
  drawDemoCards();
  HandArrange();
  
}
void HandArrange(){
  
for(int i = 0; i < my_hand.size(); i++) {
       
      my_hand.get(i).x_position=((width/2)- (my_hand.size()-1)*5 -(int)((my_hand.size()/2.0)*my_hand.get(i).card_width) +(i*my_hand.get(i).card_width) +(i*5))/(width*1.0);
        my_hand.get(i).y_position=(height-100.0)/height; 
  }
  for(int i = 0; i < opponent_hand.size(); i++) {
       opponent_hand.get(i).x_position=((width/2)- (opponent_hand.size()-1)*5 -(int)((opponent_hand.size()/2.0)*opponent_hand.get(i).card_width) +(i*opponent_hand.get(i).card_width) +(i*5))/(width*1.0);
       opponent_hand.get(i).y_position=10.0/height;
     
  }
}

void my_hand_add_card_animate(){

  if(deck.size()>0){
  card_flying_to_me = deck.get(deck.size()-1);
  deck.remove(deck.size()-1);
  }
  
  //while(card_flying_to_me!=null&&card_flying_to_me.x_position!=width/2){
  //  if(0.5-card_flying_to_me.x_position>20/width){
  //  card_flying_to_me.x_position+=20/width;
  //  }else{
  //  my_hand.add(card_flying_to_me);
  //  card_flying_to_me = null;
  //  }

  //}
   my_hand.add(card_flying_to_me);
}
void opponent_hand_add_card_animate(){
  if(deck.size()>0){
card_flying_to_opponent = deck.get(deck.size()-1);
  deck.remove(deck.size()-1);
  }
  //while(card_flying_to_opponent!=null&&card_flying_to_opponent.x_position!=width/2){
  //  if(0.5-card_flying_to_opponent.x_position>20/width){
  //  card_flying_to_opponent.x_position+=20/width;
  //  }else{
  //  opponent_hand.add(card_flying_to_opponent);
  //  card_flying_to_opponent = null;
  //  }

  //}
  opponent_hand.add(card_flying_to_opponent);
}
void mouseClicked(){
    if(deck_symbol.collision(mouseX,mouseY)){
    opponent_hand_add_card_animate();
    my_hand_add_card_animate();
    }

}

//void createServer(){
//  //println("CreateServer Thread");
//  CardGameServer = new GameServer();
//  CardGameServer.server = new Server(this,port);
//  CardGameServer.BroadcastServerInfo();
//}
