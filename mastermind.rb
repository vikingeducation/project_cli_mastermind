Set up the game initially [Mastermind]
  Create a game board [Board]
  Create players [Players]

Start the game loop [Mastermind]
  Render the board [Board]
  Ask for and validate player's peg choices [Player]
  If the game should end [Mastermind]
    Display the proper message
    Stop looping
  Else
    Return feedback about pegs [Board]
    Keep looping [Mastermind]