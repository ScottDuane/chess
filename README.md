# Chess

## Setup and Play

To run the game, clone the repo and run the command ruby game.rb.  The board should show up right in your console.  

The controls for the game are as follows:

 - W to move the cursor up
 - Z to move the cursor down
 - A to move the cursor left
 - S to move the cursor right
 - Space to select a piece
 - Enter to move a selected piece
 - Ctrl-S to save

 By default, you, the human, play white.  The computer plays black. To play using two human players, change the declaration in line 15 in game.rb from ComputerPlayer to HumanPlayer.  You can also watch the computer play itself by changing the declaration in line 14 from HumanPlayer to ComputerPlayer.  

## The AI

 The ComputerPlayer class uses a minimax algorithm to decide on its best next move.  At every step of the algorithm, ComputerPlayer evaluates the board using a valuation function written by [AUTHOR].  

 By default, the depth of the decision tree is set to 10.  To experience a more difficult (but slower) opponent, increase the depth by changing the declaration on line 14 of computerplayer.rb.  Likewise, decrease the depth for an easier (but faster) opponent.  

## Directions for Improvement

The console interface is obviously not ideal.  I'd like to convert this into a Javascript game at some point, to make it playable in the browser.  

Alpha-beta pruning would improve the speed of the AI player.  This is something I plan to incorporate into the minimax algorithm later on.  

It would be nice to have some user-facing options for the game, such as how many human players are playing, what the difficulty should be, and whether the players wants "hints" -- i.e., highlighted squares that show where a selected piece can move, or the AI's evaluation of the best next move.  These changes will probably wait until I create a Javascript frontend.  
