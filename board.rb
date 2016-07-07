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
      print "Move #{index + 1}: " + move.to_s + " "
      feedback(move)
    end

    puts "--------------------------------"
    puts
  end
  

  def move(move)
    @moves << move
    @player_turns += 1
  end

  def set_colors(number_of_colors)
    $COLORS.keys.sample(number_of_colors)
  end 

  def feedback(move)
    temp_arr = @solution.dup
    half_correct = 0
    correct = 0
    move.each_with_index do |item, index|
      if temp_arr.include?(move[index])
        half_correct += 1
        temp_arr.delete_at(temp_arr.index(move[index]))
      end
    end
    move.each_with_index do |item, index|
      if item == @solution[index]
        half_correct -= 1 if half_correct > 0
        correct += 1
      end
    end

    give_feedback(correct, half_correct)
  end

  def give_feedback(correct, half_correct)
    puts "You got #{correct} correct and #{half_correct} half_correct"
  end
 

  def game_over?
    win? || no_moves_left?
  end

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