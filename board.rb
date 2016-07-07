class Board

  attr_reader :pegs, :colors, :moves, :solution

  def initialize(codebreaker, codemaker)
    # number of turns
    @player_turns = 0
    @game_turns = 12
    # array of moves
    @moves = []
    @feedback = []
    # get number of pegs [ask player]
    @pegs = codebreaker.get_pegs
    # get number of colors
    @colors = set_colors(codebreaker.get_colors)
    @solution = codemaker.make_answer(self)
  end

  def render
    puts
    puts "--------------------------------"

    @moves.each_with_index do |move, index|
      puts "Move #{index + 1}: #{ move } #{@feedback[index]}"
    end

    puts "--------------------------------"
    puts
  end
    # start as number_of_turns lines
    # array of pegs with color
    # go through each move so far and print that line, plus feedback for that line

  def move(move)
    @moves << move
    @feedback << get_feedback(move)
    @player_turns += 1
  end

  def set_colors(number_of_colors)
    $COLORS.keys.sample(number_of_colors)
  end 

  def get_feedback(move)
    format_feedback(count_correct(move), count_misplaced(move))
  end

  def count_correct(move)
    count = 0
    move.each_index do |index|
      count += 1 if move[index] == @solution[index]
    end
    count
  end

  def count_misplaced(move)
    move = move.dup
    solution = @solution.dup

    move.length.times do |count|
      solution[count] = nil if move[count] == solution[count]
    end
    
    count = 0
    move.each do |element|
      solution.each_index do |index|
        if solution[index] == element
          solution[index] = nil
          count += 1
          break
        end
      end
    end
    count
  end

  def format_feedback(correct, misplaced)
    "\t\tCorrect: #{ correct }\tMisplaced: #{ misplaced }"
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