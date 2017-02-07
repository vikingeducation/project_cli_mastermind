## Pseudocoding the solution to Mastermind

###Base assumptions
1. 6 different colors for code pegs
2. 12 turns per game

###Program flow
Set up the game
  Create the game board
  Create a player
  Ask whether the player wants to break/make the code
  If the player wants to break the code
    Setup the secret code
  Else
    Prompt the player for the secret code
    Create a computer player to guess the code

Display instructions for game (depending on game mode)

Start the game loop  
  If the player is breaking the code
    Display the current game board
    Prompt the player for his guess
    Check the player's guess against the secret code
    If the guess is correct
      Display victory message
      Stop looping
    Else
      Check if there are still turns available
      If no more turns are available
        Display consolation message
        Reveal secret code
        Stop looping
      Else
        Evaluate feedback for player's guess
        Display feedback to the player
        Carry on looping
  
  If the player has chosen to set the code
    Display the current game board
    Computer player makes a guess
      If the guess is correct
        Display victory message
      Else
        Check if there are still turns available
        If no more turns are available
          Display player victory message
          Stop looping
        Else
          Carry on looping

Prompt player if he would like to play again
  If the player answers yes
    Reset the game
  Else
    Exit the game

      