## Pseudocoding the solution to Mastermind

###Base assumptions
1. 6 different colors for code pegs
2. 12 turns per game

###Program flow
Set up the game [MasterMind]
  Create the game board [Board]
  Create a player [Player]
  Ask whether the player wants to break/make the code [MasterMind]
  If the player wants to break the code
    Setup the secret code [MasterMind]
  Else
    Prompt the player for the secret code [Player]
    Create a computer player to guess the code [Computer]

Display instructions for game (depending on game mode) [MasterMind]

Start the game loop [MasterMind]
  If the player is breaking the code
    Display the current game board [Board]
    Prompt the player for his guess [Player]
    Check the player's guess against the secret code [MasterMind]
    If the guess is correct
      Display victory message [MasterMind]
      Stop looping [MasterMind]
    Else
      Check if there are still turns available [MasterMind]
      If no more turns are available
        Display consolation message [MasterMind]
        Display secret code [MasterMind]
        Stop looping [MasterMind]
      Else
        Evaluate feedback for player's guess [MasterMind]
        Store feedback along with player's guess [Board]
        Display feedback to the player [Board]
        Carry on looping [MasterMind]
  
  If the player has chosen to set the code
    Display the current game board [Board]
    Computer player makes a guess [Computer]
      If the guess is correct
        Display victory message [MasterMind]
      Else
        Check if there are still turns available [MasterMind]
        If no more turns are available
          Display player victory message [MasterMind]
          Stop looping [MasterMind]
        Else
          Evaluate feedback for computer's guess [MasterMind]
          Store feedback along with computer's guess [Board]
          Display the current game board [Board]
          Carry on looping [MasterMind]

Prompt player if he would like to play again [MasterMind]
  If the player answers yes [Player]
    Reset the game [MasterMind]
  Else
    Exit the game [MasterMind]


      