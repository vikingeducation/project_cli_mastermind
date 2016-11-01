class Mastermind

  def initialize()
    @board = Board.new
    @codemaker = Codemaker.new
    @codebreaker = Codebreaker.new
  end

  def play
    instructions
    loop do
      take_turn
    end
  end

  def take_turn
    #
  end

  def instructions
    #
  end

  def gameover?
    #
  end

  def win?
    #
  end

  def lose?
    #
  end
end

class Board
end

class Codebreaker
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
