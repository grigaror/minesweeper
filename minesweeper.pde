boolean[][] mine=new boolean[10][10];
boolean[][] found=new boolean[10][10];
boolean[][] labled=new boolean[10][10];
int time, emotion, tmr;
boolean start;
void setup() {
  size(500, 580);
  frameRate(60);
  strokeWeight(2);
  for (int i=0; i<15; i++) {
    int x=(int)random(0, 10), y=(int)random(0, 10);
    while (mine[x][y]) {
      x=(int)random(0, 10);
      y=(int)random(0, 10);
    }
    mine[x][y]=true;
    start=true;
  }
}
void draw() {
  int mines_labled=0;
  background(#FFFFFF);
  stroke(#000000);
  textSize(30);
  for (int i=1; i<10; i++)line(i*50, 0, i*50, height);
  for (int i=1; i<10; i++)line(0, i*50, width, i*50);
  noStroke();
  for (int i=0; i<10; i++) for (int j=0; j<10; j++) {
    int mines_around=0;
    fill(#FF0000);
    if (mine[i][j] && emotion==1) circle(i*50+25, j*50+25, 30);
    if (labled[i][j]) text("X", i*50+15, j*50+35);
    if (i>0 && j>0 && mine[i-1][j-1]) mines_around++;
    if (i>0 && mine[i-1][j]) mines_around++;
    if (i>0 && j<9 && mine[i-1][j+1]) mines_around++;
    if (j>0 && mine[i][j-1]) mines_around++;
    if (j<9 && mine[i][j+1]) mines_around++;
    if (i<9 && j>0 && mine[i+1][j-1]) mines_around++;
    if (i<9 && mine[i+1][j]) mines_around++;
    if (i<9 && j<9 && mine[i+1][j+1]) mines_around++;
    switch (mines_around) {
    case 0:
      fill(#555555); 
      break;
    case 1: 
      fill(#0000FF); 
      break;
    case 2: 
      fill(#00FF00); 
      break;
    case 3: 
      fill(#EEDD00); 
      break;
    case 4: 
      fill(#FF5500); 
      break;
    case 5: 
      fill(#FF0000); 
      break;
    }
    if (!mine[i][j] && found[i][j]) text(mines_around, i*50+15, j*50+35);
    if (mines_around==0 && found[i][j]) {
      if (i>0 && j>0) found[i-1][j-1]=true;
      if (i>0) found[i-1][j]=true;
      if (i>0 && j<9) found[i-1][j+1]=true;
      if (j>0) found[i][j-1]=true;
      if (j<9) found[i][j+1]=true;
      if (i<9 && j>0) found[i+1][j-1]=true;
      if (i<9) found[i+1][j]=true;
      if (i<9 && j<9) found[i+1][j+1]=true;
    }
    if (mine[i][j] && labled[i][j]) mines_labled++;
    if (mines_labled>=15 && emotion!=1) emotion=2;
  }  
  textSize(78);
  fill(#000000);
  rect(0, 500, width, 80);
  fill(#FF0000);
  if (emotion==0) time=millis()/1000;
  text(time, 5, 570);
  fill(#FFFFFF);
  push();
  translate(width-80, 520);
  rotate(PI/2);
  switch (emotion) {
  case 0: 
    text(":)", 0, 0); 
    break;
  case 1: 
    text(":(", 0, 0); 
    break;
  case 2: 
    text(";)", 0, 0); 
    break;
  }
  pop();
  if (mouseY<500 && mousePressed && !labled[mouseX/50][mouseY/50] && mouseButton==LEFT) {
    if (mine[mouseX/50][mouseY/50]) emotion=1;
    else found[mouseX/50][mouseY/50]=true;
  }
  if (mouseY<500 && mousePressed && mouseButton==RIGHT && millis()-tmr>=300 && !found[mouseX/50][mouseY/50]) {
    labled[mouseX/50][mouseY/50]=!labled[mouseX/50][mouseY/50];
    tmr=millis();
  }
}
