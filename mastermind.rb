## CODEBREAKER
# The game board is rendered between turns
# => class: Board, Public-Action: render

# The player only gets 12 turns to crack the code
# => Class: MasterMind, Public-Action: play(while or until)

# The player wins if the code is correctly guessed by the last turn
# => Class: MasterMind, Private-Action: player_win?

# The rendered board displays the number of "close" pegs (correct color, wrong position)
# => class: Board, Private-Action: close_feedback

# The rendered board displays the number of "exact" pegs, e.g. those which exactly match the color and position of the computer's code
# => class: Board, Private-Action: exact_feedback

# The player loses after the 12th turn if the code hasn't been broken
# => class: MasterMind, Private-Action: player_lose?

# When losing, the code is displayed to the player
# => class: Board, Public-Action: render

## CODEMAKER
# The game now asks whether the player wants to be the "codebreaker" or "codemaker" upon startup
# => class: Player, Public-Action: pick_character

# The codemaker player is prompted to enter a code
# => class: Player, Public-Action: initialize_code

# Once the code is entered, the computer AI "plays" the game, rendering the board between turns and displaying the final result (win/loss)
