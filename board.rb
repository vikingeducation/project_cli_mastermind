class Board

  attr_reader :pegs, :colors, :moves, :player_turns

  def initialize(codebreaker, codemaker)
    # number of turns
    @player_turns = 0
    @game_turns = 12
    # array of moves
    @moves = []
    # get number of pegs [ask player]
    @pegs = codebreaker.get_pegs
    # get number of colors
    @colors = set_colors(codebreaker.get_colors)
    @solution = codemaker.make_answer(self)
  end

  def render
    puts
    puts "--------------------------------"
    puts

    @moves.each_with_index do |move, index|
      puts "Move #{index + 1}: " + move.to_s
    end

    puts "--------------------------------"
    puts
  end
    # start as number_of_turns lines
    # array of pegs with color
    # go through each move so far and print that line, plus feedback for that line

  def move(move)
    @moves << move
    @player_turns += 1
  end

  def set_colors(number_of_colors)
    $COLORS.keys.sample(number_of_colors)
  end 

  # give feedback
    # look at current turn
      # count number of correct, half-correct, and wrong
    # return

  def game_over?
    win? || no_moves_left?
  end
    # did they win?
    # are the moves over?

  def win?
    if @moves.any? { |turn| turn == @solution } 
      puts "You're a mastermind!"
      true
    else
      false
    end
  end


  def no_moves_left?
    if @player_turns >= @game_turns
      puts "You lose. You're a fool."
      true
    else
      false
    end
  end

end