require './guess'
require './board'
require './player'
require './computer'
require './codemaker'
require './codebreaker'

class Mastermind

  def initialize
    @name = nil
  end

  def welcome
    print "\n"
    puts "******************************************************"
    puts "************* ************************** *************"
    puts "***********    ************************    ***********"
    puts "*********       **********************       *********"
    puts "*******          ********************          *******"
    puts "*****             ******************             *****" 
    puts "****               ****************               ****"
    puts "****                **************                ****"
    puts "*****                ************                *****"
    puts "******                **********                ******"
    puts "*******                ********                *******"
    puts "*********               ******               *********"
    puts "***********              ****              ***********"
    puts "*************             **             *************"
    puts "***************     **************     ***************"
    puts "*****************   * WELCOME TO *   *****************"
    puts "*******************                *******************"
    puts "*****************   * MASTERMIND *   *****************"
    puts "***************     **************     ***************"
    puts "*************             **             *************"
    puts "***********              ****              ***********"
    puts "*********               ******               *********"
    puts "*******                ********                *******"
    puts "******                **********                ******"
    puts "*****                ************                *****"
    puts "****                **************                ****"
    puts "****               ****************               ****"
    puts "*****             ******************             *****"
    puts "*******          ********************          *******"
    puts "*********       **********************       *********"
    puts "***********    ************************    ***********"
    puts "************* ************************** *************"
    puts "******************************************************"
  end

  def get_name
    puts "\nWhat's your name?"
    print "> "
    @name = gets.strip
  end

  def get_role  
    options = { 1 => "Codemaker", 2 => "Codebreaker" }
    puts "\n#{@name}, please press [1] to play this game as the Codemaker or [2] to play as the Codebreaker."
    print "> "
    choice_num = gets.strip.to_i
    get_role unless choice_num == 1 || choice_num == 2
    role = options[choice_num]
    puts "\nYou've elected to be the #{role}. Let's do this!"
    class_name = Object.const_get(role)
    $player = class_name.new(@name)
  end

  def setup(name = nil)
    welcome
    name.nil? ? get_name : @name = name
    get_role
    play
  end

  def play
    turn_num = 1
    current_board = Board.new
    loop do
      $player.turn(turn_num)
      current_board.render($guess.latest) unless $player.quit?
      break if game_over?
      turn_num += 1
    end
    $player.play_again? unless $player.quit?
  end

  def game_over?
    $player.won? || $player.lost? || $player.quit?
  end

end

game = Mastermind.new
game.setup