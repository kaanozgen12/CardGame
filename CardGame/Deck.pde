class Deck{
  Card[] cards;
  PImage img;
  public Deck(){
  }
  public Deck(PImage img){
    this.img = img;
  }
  
  Card[] createDeck(){
  cards = new Card[52];
  if(img == null){
      for(int i = 0;i<4;i++){
       for(int j = 1;j<14;j++){
         cards[i*13 + j - 1] = new Card(j,i);
         //cards[i*13 + j - 1].returnInfo();
       }
     }  
 }else{
   PImage[] textures = new PImage[52];
   
   for(int y = 0; y < 4; y++){
     for(int x = 0; x < 13; x++){
       int w = img.width;
       int h = img.height;
       int lenX = w/13;  //CARDS.PNG HAS 13 COLUMNS
       int lenY = h/4;  //AND 4 ROWS
       int startY = y*lenY;  //Y OF THE CARD RELATIVE TO THE SCREEN
       int startX = x*lenX;  //X OF THE CARD RELATIVE TO THE SCREEN
       //println(startX + " " +startY + " " +lenX + " " +lenY);
       textures[y*13 + x] = img.get(startX,startY,lenX,lenY);  //GET THE SPECIFIC SUBIMAGE NEEDED
       cards[y*13 + x] = new Card(x + 1,y,textures[y*13 + x]);
     }
   
   }
   
 }
 
 
  return cards;
  }



}
