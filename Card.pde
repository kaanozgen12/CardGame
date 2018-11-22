import java.io.File;
 


public class Card{
public int number;
public float x_position;
public float y_position;
public int card_width=55;
public int card_height = 80;
public float clicked_x_margin;
public float clicked_y_margin;
public boolean cardselected=false;
PImage cardTexture;
  public Card(){
  
  }

  File dir = new File("cards");
  public Card(int number,float x_position,float y_position ,  boolean selected){
  this.number = number;
  this.x_position= x_position;
  this.y_position  =y_position;
  this.cardselected = selected;

  if(number>0){
    cardTexture = loadImage(number+".png");
  }else{
  cardTexture = loadImage("back.png");
  }
  }
  
  void demoDraw(){
  stroke(0);
  fill(255);
  
  rectMode(CENTER);
  
  int wpad = width/13;
  int hpad = height/4;
  
  if(cardTexture != null && !cardselected){
    image(cardTexture, (x_position*width),(y_position*height),55,80);
  }
  }
  
  boolean collision(float mouseX, float mouseY) {
    if (mouseX >= x_position*width &&         // right of the left edge AND
      mouseX <= x_position*width + card_width &&    // left of the right edge AND
      mouseY >= y_position*height &&         // below the top AND
      mouseY <= y_position*height + card_height) {    // above the bottom
      return true;
    }
    return false;
  }


}
