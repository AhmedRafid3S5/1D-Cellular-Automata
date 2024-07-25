//cellular automata

int[] ruleSet = new int [8];

int spacing = 5; // Define the spacing between squares
int maxFrames = 920;
int N = maxFrames/spacing;
float[] cells = new float [N];
float[] nextGen = new float [N];

int ruleNum = 182 ; //Change this number to generate a different pattern integers 0 to 255 are the only valid rule numbers

void setup(){
  
 for(int i=0;i<N;i++)
 {
   cells[i] = 0;
   nextGen[i] = 0;
 }
 
 cells[N/2] = 1;
 
 
 determineRuleSet();
 for(int i=0;i<8;i++)
   print(ruleSet[i]+" ");
 println();

}

//take current value, calculate next state of cells and update current cell values
void nextValue(float[] cells){

  //calculate next gen cell states
   for(int i=0;i<N;i++){
     float a = cells[(i-1+N)%N];
     float b = cells[i];
     float c = cells[(i+1+N)%N];
     //print("a,b,c: "+a+" "+b+" " +c+" "+"NS: " + calculateNextState(a,b,c)+"  ");
     nextGen[i] = calculateNextState(a,b,c);
     
   }

  copyCells(cells,nextGen);

}

void copyCells(float[] currentCells,float[] updatedCells){
  
   for(int i=0;i<N;i++)
   {
     currentCells[i] = updatedCells[i];
   }
   
   
}

void determineRuleSet(){

  for(int i=0;i<8;i++){
   ruleSet[i] = (int)(ruleNum >> i) & 1; // Extract the i-th bit from the right (least significant bit first)

      }

}

float calculateNextState(float a,float b,float c){
 
  
  if      (a==0 && b==0 && c==0) return ruleSet[0] == 1 ? 1: 0;
  else if (a==0 && b==0 && c==1) return ruleSet[1] == 1 ? 1: 0;
  else if (a==0 && b==1 && c==0) return ruleSet[2] == 1 ? 1: 0;
  else if (a==0 && b==1 && c==1) return ruleSet[3] == 1 ? 1: 0;
  else if (a==1 && b==0 && c==0) return ruleSet[4] == 1 ? 1: 0;
  else if (a==1 && b==0 && c==1) return ruleSet[5] == 1 ? 1: 0;
  else if (a==1 && b==1 && c==0) return ruleSet[6] == 1 ? 1: 0;
  else if (a==1 && b==1 && c==1) return ruleSet[7] == 1 ? 1: 0;
  else 
    return 0;
  
}

void settings(){

size(maxFrames,maxFrames);
}



void draw(){

  if (frameCount > maxFrames) {
    noLoop(); // Stop the draw loop after maxFrames
    return;
  }
  
  
  int squareSize = 5; // Define the size of each square
 
  
  for (int i = 0; i < width / spacing; i++) {
//for (int j = 0; j < height / spacing; j++) {
      fill(255*cells[i],255*cells[i],cells[i]); // Set the fill color for the squares
      int x = i * spacing;
      int y = frameCount * spacing;
      noStroke();
      square(x, y, squareSize);
   // }
    
  }
  
  nextValue(cells);
 

}
