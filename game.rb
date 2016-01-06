require_relative 'player.rb'
require_relative 'human.rb'
require_relative 'computer.rb'
require_relative 'board.rb'
# require_relative 'logic.rb'

class Game

  def initialize
    @winning_board = []
    @board = Board.new
    @codemaker = nil
    @codebreaker = nil
    # @logic = Logic.new
  end


  def print_instructions
    puts "==========================================="
    puts "Welcome to Mastermind!"
    puts "The point of the game is to guess a hidden combination of four pegs."
    puts "You get 12 guesses."
    puts "Each peg has a different color and position."
    puts "The valid colors to guess are:"
    puts "red, orange, yellow, green, blue and purple"
    puts "==========================================="
  end


  def determine_codemaker
    until @codemaker
      puts "Would you like to do be codebreaker or codemaker? \nEnter 'make' or 'break'"
        choice = gets.chomp.downcase
        if ["make", "break"].include? choice
          if choice == "make"
            @codemaker, @codebreaker = Human.new, Computer.new
          else
            @codebreaker, @codemaker = Human.new, Computer.new
          end
        else
          puts "Invalid selection."
        end
    end
  end


  def user_has_won?
    @winning_board == @codebreaker.guess ? true : false
  end


  def play
    print_instructions
    # prompt user for codemaker or codebreaker
    determine_codemaker
    # make winning board
    @winning_board = @codemaker.create_board 
    puts "==================="
    print "(winning board)", @winning_board, "\n"
    puts "==================="
    # ask for guesses, constantly display current board with previous guesses
    previous_guesses = []

    until user_has_won? || (@codebreaker.turn == 0)
      @codebreaker.guess = @codebreaker.create_board
      @codebreaker.turn -= 1

      previous_guesses << @codebreaker.guess

      @board.render(previous_guesses, @winning_board, @codebreaker.guess)

    end
    # print congrats or you lose
    user_has_won? ? (puts "Congratulations! You win!") : (puts "Sorry, you lose!")

  end


end


g = Game.new
g.play