void setup(){
  fullScreen();
  
  img = loadImage("cards.png");
  img.loadPixels();
  
  table = new Table();
  
  if(img != null)
  deck = new Deck(img);
  else
  deck = new Deck();
  
  cards = deck.createDeck();
  
  for(int i = 0; i < 52; i++) {
    String[] k = cards[i].returnInfo();
    println("card: " + k[0] + " of " + k[1]);  
    cards[i].demoDraw();
  }
  
  //println(img.width + " " + img.height + " ");
}
Table table;
Deck deck;
Card[] cards;
PImage img = null;

void draw(){
  background(0);//CLEAR BACKGROUND AT EVERY FRAME TO BLACK
  table.draw();//FIRST DRAW THE TABLE
  for(int i = 0; i < 52; i++) {
    cards[i].demoDraw();
  }
  
  
  
}
