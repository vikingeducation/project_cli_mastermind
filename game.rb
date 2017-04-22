class Game
  require_relative 'board'
  require_relative 'human_player'
  require_relative 'computer_player'


  def initialize
    @game_board = Board.new
    @guesses = 0
  end


  def play_game
      start_game
      pick_player
      loop do
        @guess = @codebreaker.guess
        if win?(@guess, @hidden_code)
          user_won
        elsif @guesses == 12
          user_lost
        end
        @guesses += 1
        puts "The current board after you \##{@guesses} guess is:"
        @game_board.feedback(@guess, @hidden_code)
      end
  end

  def start_game
    puts "Welcome to Mastermind: The code breaking game"
    puts "The computer will fill each of four spots with either 'blue' or 'red'"
    puts "For example blue-red-red-blue"
    puts "It is your job to decided what color is in each spot"
    puts "Please enter your answer in the form color-color-color-color"
    puts "Feedback will be given after each guess"
    puts "'black' will be returned if your guess is the correct color in the correct place "
    puts "'white' will be returned for each correct color in the incorrect place"
    puts "A incorrect color and placement will retrun 'nil'"
    puts "You will have twelve guesses to break the code"
  end

  def pick_player
    puts "Would you like to be 'codemaker' or 'codebreaker'? or 'q' to quit"
    response = gets.chomp.downcase
    case response
    when "codemaker"
      @codemaker = HumanPlayer.new
      @hidden_code = @codemaker.hidden_code
      @codebreaker = ComputerPlayer.new
    when "codebreaker"
      @codemaker = ComputerPlayer.new
      @hidden_code = @codemaker.hidden_code
      @codebreaker = HumanPlayer.new
    when "q"
      exit
    else
      puts "That was not a valid selection please re-enter"
      pick_player
    end
  end


  def win?(user_guess, hidden_code)
    @guess == @hidden_code
  end

  def user_won
    puts "Congrats you cracked the code!"
    puts "The hidden code was: #{@hidden_code}"
    play_again
  end

  def user_lost
    puts "Sorry you loose, the hidden code was: #{@hidden_code}"
    play_again
  end


  def play_again
    puts "Would you like to play again? y/n?"
    answer = gets.chomp.downcase =~ /y/i ? Game.new.play_game : exit
  end


end # end of class

n = Game.new
n.play_game
