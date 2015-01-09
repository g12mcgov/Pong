int BOARDHEIGHT = 300;
int BOARDWIDTH = 500;
int SCOREHEIGHT = 30;
int BALLDIAMETER = 20;
int BALLRADIUS = BALLDIAMETER / 2;
int PADDLELENGTH = BOARDHEIGHT / 5;
 
int circleX, circleY;
int deltaX, deltaY;
int computerScore, humanScore;
int paddleY;
 
void setup(){
    size( BOARDWIDTH, BOARDHEIGHT + SCOREHEIGHT ); 
    paddleY  = BOARDHEIGHT / 2 - PADDLELENGTH / 2;   
    newGame();
}
 
// Clear the window; draw the ball; draw the paddle; do score; move the ball -- repeat
void draw(){
   background(255);
   drawBall( 255, 0, 0 );
   drawPaddle( paddleY ); 
   drawScore(); 
   moveBall();
}
 
// start a new game, reset the important variables
void newGame(){ 
   computerScore = 0;
   humanScore = 0;
   newBoard();
}
 
// set up a new board
void newBoard(){
   background(255);
   circleX = BOARDWIDTH / 2;
   circleY = BOARDHEIGHT / 2;
 
   // Get random step size; want it to be negative half the time 
   deltaX  = int( random(2, 5) );
   if( random(0,1) < 0.5 ){
      deltaX = -deltaX;
   }
   deltaY  = int( random(2, 4) );
   if( random(0,1) < 0.5 ){
     deltaY = -deltaY;
   }
   delay(1000);  // wait a second
}
 
// draw the ball in a color determined by the arguments.
void drawBall( float r, float g, float b ){
  fill( r, g, b );
  strokeWeight(0);
  ellipse( circleX, circleY, BALLDIAMETER, BALLDIAMETER );
}
 
// Show the score in the window.
void drawScore(){
   fill( 0, 255, 255 );
   rect( 0, BOARDHEIGHT, BOARDWIDTH, SCOREHEIGHT );
   fill(0);
   text("Computer: " + str(computerScore), 15, BOARDHEIGHT + 20 );
   text(   "Human: " + str(humanScore), width - 80, BOARDHEIGHT + 20 );
}
 
// Show the paddle.  Note that the paddle has some thickness. 
void drawPaddle( int y ){
   fill(0);
   strokeWeight(5);
   line( 0, y, 0, y + PADDLELENGTH );  
}
 
// Move the ball using the current value of deltaX and deltaY.
// After moving the ball, check to see if the ball intersects
// the paddle, hits a wall, or goes out the window.
void moveBall(){
  circleX = circleX + deltaX;  // move the ball
  circleY = circleY + deltaY;
 
  // intersection tests
  if( deltaX > 0 ){   // moving right
      if( circleX + BALLRADIUS >= BOARDWIDTH ) { // check right wall
         deltaX = -deltaX;
      }
  }
  else  // must be moving left 
  { 
      if( circleX <= -BALLDIAMETER ) {  // ball has passed left wall
          computerScore++;                      // computer gets a point
          newBoard();                         // reset points, etc
      } else if( (circleX - BALLRADIUS <= 5) && (circleX > 5) ){ // hit paddle?
            if( circleY + BALLRADIUS > paddleY &&
                   circleY - BALLRADIUS <= paddleY + PADDLELENGTH ){
                deltaX = -deltaX;
                humanScore++;
            }
      }
  }
  // check to see if upper or lower wall has been hit 
  if( circleY + BALLRADIUS > BOARDHEIGHT || circleY - BALLRADIUS < 0 ) {
      deltaY = -deltaY;
  }
}
 
// Handle keypresses
void keyPressed(){
  int PADDLEDELTA = 7;
  
  if( key == 'u' ){  // 'u' for UP
     if( paddleY >= PADDLEDELTA ){
         paddleY = paddleY - PADDLEDELTA;
     }
  } else if ( key == 'd' ){   // 'd' for DOWN
     if( paddleY < BOARDHEIGHT - PADDLELENGTH - PADDLEDELTA ){
         paddleY = paddleY + PADDLEDELTA;
     }       
  } else if ( key == 'r' ){   // 'r' for RESET
     newGame();
  } else if( key == 'x' ){    // 'x' for EXIT
     exit();
  }
}
