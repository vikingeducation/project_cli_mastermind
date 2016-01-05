# Mastermind

## Codebreaker

# Game
 @turn
 @board

 play
  generate solution
  until game_over?
    move = get move
    Board.add_move(move)
    Board.render

  game_move
    generate solution

  game_over?
    out_of_turns?
    board.correct_solution?(code)

# Board
 @past_codes
 @solution_code
 render
 check_move

# Code
 @pegs
 ==

# Peg
  to_s
  rainbow("1").red
1 2 3



6 Colored Pegs
12 Moves

4 Possible Spots
Solution is 4
