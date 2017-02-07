## Pseudocoding the solution to Mastermind

### Program flow
```
Set up the game [Mastermind]
  Create the game board [Board]
  Create a player [Player]
  Ask whether the player wants to break/make the code [Mastermind]
  If the player wants to break the code
    Setup the secret code [Mastermind]
  Else
    Prompt the player for the secret code [Player]
    Create a computer player to guess the code [Computer]

Display instructions for game (depending on game mode) [Mastermind]

Start the game loop [Mastermind]
  If the player is breaking the code
    Display the current game board [Board]
    Prompt the player for his guess [Player]
    Check the player's guess against the secret code [Mastermind]
    If the guess is correct
      Display victory message [Mastermind]
      Stop looping [Mastermind]
    Else
      Check if there are still turns available [Mastermind]
      If no more turns are available
        Display consolation message [Mastermind]
        Display secret code [Mastermind]
        Stop looping [Mastermind]
      Else
        Evaluate feedback for player's guess [Mastermind]
        Store feedback along with player's guess [Board]
        Display feedback to the player [Board]
        Carry on looping [Mastermind]
  
  If the player has chosen to set the code
    Display the current game board [Board]
    Computer player makes a guess [Computer]
      If the guess is correct
        Display victory message [Mastermind]
      Else
        Check if there are still turns available [Mastermind]
        If no more turns are available
          Display player victory message [Mastermind]
          Stop looping [Mastermind]
        Else
          Evaluate feedback for computer's guess [Mastermind]
          Store feedback along with computer's guess [Board]
          Display the current game board [Board]
          Carry on looping [Mastermind]

Prompt player if he would like to play again [Mastermind]
  If the player answers yes [Player]
    Reset the game [Mastermind]
  Else
    Exit the game [Mastermind]
```

### Thoughts      
1. Object decomposition:
  1. Mastermind for overall game control and logic
  2. Board to store and display current state of game
  3. Player to represent a human player
  4. Computer to represent a computer player
2. We could probably create a Player parent class, with HumanPlayer and ComputerPlayer child classes