class Mastermind #Game flow

  def initialize
    keep_playing = true
    while keep_playing
      select_player
      @board = Board.new
      play
      keep_playing = play_again?
    end
  end

  def select_player
    if select_mode == 1
      @code_maker = Computer.new
      @code_breaker = Player.new
    else
      @code_maker = Player.new
      @code_breaker = Computer.new
    end
  end

  def select_mode
    is_valid = false
    until is_valid
      print "Do you want to be the (1) code breaker or the (2) code maker? "
      input = gets.chomp.to_i
      is_valid = [1,2].include?(input)
      puts "Try 1 or 2" unless is_valid
    end
    input
  end

  def play
    attempts_left = 12

    while attempts_left > 0 #Single game
      puts "This is the code breaker's attempt No. #{13 - attempts_left}"
      guess = @code_breaker.guess

      if guess_correct?(guess)
        win_game
        break
      else
        @board.update(guess, attempts_left)
        @board.add_to_match_history (compare_exact_match(guess))
        @board.render
        attempts_left -=1
      end
    end

      lose_game if attempts_left <= 0

  end

  def compare_exact_match(guess)
    guess_copy = guess.dup
    code = @code_maker.solution.dup
    result = {:exact_match => 0}

    guess_copy.each_with_index do |color, index|
      if color == code[index]
        result[:exact_match] +=1
        code[index] = nil
        guess_copy[index] = nil
      end
    end

    code -= [nil]
    guess_copy -= [nil]
    result[:color_match] = compare_color_match(code, guess_copy)
    result
  end

  def compare_color_match(code, guess)
    result = {:color_match => 0}

    guess.each_with_index do |color, index|
      if code.include?(color)
        result[:color_match] += 1
        code[code.index(color)] = nil
      end
    end

    result[:color_match]
  end

  def guess_correct?(guess)
    guess == @code_maker.solution
  end

  def win_game
    puts "Congratulations! The code was correct!"
  end

  def lose_game
    puts "Sorry! The solutions was:"
    puts @code_maker.solution
  end

  def play_again?
    is_valid = false
    until is_valid
      print "Do you want to play again? (Y/N): "
      input = gets.chomp.downcase
      is_valid = is_true_or_false?(input)
      puts "Try 'y' or 'n'" unless is_valid
    end
    return input == "y"
  end


  def is_true_or_false?(input)
    ["y", "n"].include?(input)
  end

end

class Board #Game logic

  def initialize
    @board = Array.new(12) { |row| row = ["-","-","-","-"] }
    @pegs =[]
  end

  def add_to_match_history(hint)
    @pegs << hint
  end

  def render
    #p @board
    @board.each_with_index do |row, index|
      print row
      print @pegs[index]
      print "\n" #also matches
    end
    puts
  end

  def update(guess, attempts_left)
    @board[12 - attempts_left]= guess
  end

end

class Player #Inputs

  CODE_COLORS = %w(b r y p g o)

  def initialize
    @solution = make_code
  end

  def make_code
    guess
  end

  def solution
    @solution
  end

  def guess
    input_valid = false
    until input_valid
      puts "The color options are [b]lue, [r]ed, [p]urple, [o]range, [y]ellow, and [g]reen"
      print "Enter your code in the format r,b,g,y : "
      raw_input = gets.strip
      move = raw_input.split(",")
      input_valid = is_input_valid?(move)
      puts "Input is invalid. Please try again." unless input_valid
    end
    return move
  end

  def is_input_valid?(input)
    input.all?{ |item| CODE_COLORS.include?(item)}
  end

end

class Computer #as code maker

  CODE_COLORS = %w(b r y p g o)

  def initialize
    @solution = make_code
  end

  def solution
    @solution
  end

  def make_code
    code = []
    #generate random code of 6 colors
    4.times do
      code << CODE_COLORS.sample
    end
    code
  end

  def guess
    make_code
  end

end

a = Mastermind.new

