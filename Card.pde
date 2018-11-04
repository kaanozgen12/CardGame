public class Card{
int number;  //1 TO 10 AND JACK QUEEN KING TOTAL 13
int suit;  //HEARTS SPADES CLUBS DIAMONDS /* 13*4=52 */
PImage cardTexture;
  public Card(){
  
  }

  public Card(int number, int suit){
  this.number = number;
  this.suit = suit;
  }
  
  public Card(int number, int suit,PImage texture){
  this.number = number;
  this.suit = suit;
  cardTexture = texture;
  }
  
  public String[] returnInfo(){
    String ret[] = new String[2];
    switch (number){//!DOES NOT CHECK NUMBER GREATER THAN 13 CHECK IT
      case 11:
      ret[0] = "JACK";
      break;
       case 12:
      ret[0] = "QUEEN";
      break;
      case 13:
      ret[0] = "KING";
      break;
      default:
      ret[0] = String.valueOf(number);
      break;
    }
  
    switch (suit){ 
      case 0:
      ret[1] = "HEARTS";
      break;
      case 1:
      ret[1] = "SPADES";
      break;
      case 2:
      ret[1] = "CLUBS";
      break;
      case 3:
      ret[1] = "DIAMONDS";
      break;
    }
    
  //println(ret[0] + " of " + ret[1]);
  return ret;
  }
  
  
  void demoDraw(){
  stroke(0);
  fill(255);
  
  rectMode(CENTER);
  
  int wpad = width/4;
  int hpad = height/13;
  
  int myW = (wpad * suit) + (wpad/2);  //HALF OF THE CARD WIDTH
  int myH = (hpad * number) - (hpad/2);  //ESTIMATE OF HALF OF THE CARD HEIGHT
  if(cardTexture == null){
    rect(myW ,myH,wpad,hpad);
    println("RECT: " + myW+ " " + myH+ " " + wpad+ " " + hpad);
    println("TextSize: " + wpad/3);
    String[] k = this.returnInfo();
    String a = k[0]+"of"+k[1];
    textSize(wpad/(a.length()));
    textAlign(CENTER,CENTER);
    stroke(0);
    fill(0);
    text(a,myW,myH);
    println("Text: " + number + " " + myW + " " +myH + "textsize: " + wpad/(a.length()));
    println("Text written");
  }else{
    imageMode(CENTER);
    image(cardTexture,myW ,myH,wpad,hpad);  //SMALL CARDS FO DEMO IMAGES
    //image(cardTexture,myW ,myH,wpad,hpad); //FULLCARDS
    println("IMAGE: " + myW+ " " + myH+ " " + wpad+ " " + hpad);
  }
  
  
  
  
  
  }

}
