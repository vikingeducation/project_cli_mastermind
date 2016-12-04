require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @turns = 0
    @board = Board.new
  end

  def play
    puts puts
    intro
    maker_or_breaker
    @board.render
    loop do
      announce_number_of_turns
      @guess = @player1.place_guess
      @board.process(@guess, @code, @turns)
      @board.render
      @turns += 1
      if win?
        victory
        break
      elsif lose?
        failure
        break
      end        
    end
  end

  def maker_or_breaker
    choice = ""
    loop do 
      puts "Would you like to be the codemaker(m) or codebreaker(b)?"
      puts "Please enter 'm' for codemaker, or 'b' for codebreaker."
      choice = gets.chomp.downcase.strip
      break if valid_choice?(choice)
    end
    if choice == "m"
      maker
    elsif choice == 'b'
      breaker
    end
  end

  def maker
    @player1 = AI.new
    @player2 = Human.new
    @code = @player2.generate_code
  end

  def breaker
    @player1 = Human.new
    @player2 = AI.new
    @code = @player2.generate_code
  end

  def valid_choice?(choice)
    return true if %w(m b).include?(choice)
    false
  end

  def win?
    return true if @guess == @code
    false
  end

  def lose?
    return true if @turns == 12
    false
  end

  def victory
    puts "The code was #{@code}. You won!"
  end

  def failure
    puts "You lost! The code was #{@code}."
  end

  def intro
    puts "Welcome to Mastermind!"
    puts "Your opponent will select a 4 color code."
    puts "The colors are (B)lue, (P)urple, (R)ed, (O)range, (G)reen, (Y)ellow."
    puts "You have 12 chances to guess the code."
    puts "After each guess you will receive feedback to help you narrow your choices:"
    puts "'W' means that letter is in the code, but in the wrong position"
    puts "'B' means that letter is in the correct position!"
    puts "Enter 'q' to quit the game at any time"
    puts "Good luck!"
  end

  def announce_number_of_turns
    puts
    puts "You have #{12 - @turns} turns remaining."
  end
end

game = Game.new
game.play