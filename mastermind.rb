class Mastermind

  def initialize()
    @board = Board.new
    @codemaker = Codemaker.new
    @codebreaker = Codebreaker.new
    @turns_left = 12
    @winning_sequence = @board.winning_sequence
  end

  def play
    instructions
    @board
    until game_over?
      take_turn
    end
  end

  def take_turn
    @codebreaker.get_input

  end

  def instructions
    #
  end

  def gameover?
    gameover if @turns_left < 1

  end

  def gameover
    puts "Game over."
  end

  def win?
    
  end

  def lose?
    #
  end
end

class Board
  
  COLORS = %w(red yellow blue green black white)

  def winning_sequence
    win = []
    4.times do
      win << COLORS.sample
    end
    win
  end

end

class Codebreaker

  turn = gets.strip

  def valid_input?
    # checks whether each string is indeed in colors
    colors = turn.split(' ')
    colors.all? do |color|
      COLORS.include?(color)
    end
  end

end

class Codemaker
end

Mastermind.new.play

#Board
  #render
  #full?
  #number_of_right_answers
  #number_of_right_colors: green, blue, yellow, red, black, white

#Codebreaker
  # enter_pegs
  #valid_input?
  #right number of pegs
  # correct colors?


#Codemaker
  #set up board

#Mastermind
  #play
  #gameover?
  #win?
  #lose?


#
#Mastermind
  #play
  #gameover?
  #win?
  #lose?
