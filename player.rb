class Player

  POSS_PEGS = %w(R O Y G B V)

  attr_accessor :name

  def initialize
    @quit = false
    @won = false
    @lost = false
  end

  def quit?
    @quit
  end

  def won?
    @won
  end

  def lost?
    @lost
  end

  def quit
    puts "\nQuitting now. Come play again soon!"
    @quit = true
  end

  def won(guess_num = nil)
    @won = true
  end

  def lost(guess_num = nil)
    @lost = true
  end

  def process_input
    print "> "
    input = gets.strip.upcase
    if input[0] == "Q"
      $player.quit
    elsif input.size == 4 && input != "blue"
      code = input.split("")
    else 
      code = input.split(/[\s,]+/)
    end
    code.map! { |peg| peg = peg[0] }
    return code
  end

  def valid?(input)
    input.all? { |peg| POSS_PEGS.include?(peg) } &&
    input.size <= 4
  end

  def play_again?
    print "\n"
    puts "Do you want to play again, #{$player.name}? Y/N"
    print "> "
    input = gets.strip[0]
    if input.nil?
      play_again?
    elsif input.upcase == "Y"
      $player.play_again
    else
      puts "\nI'll take that as a no. Come back soon!\n"
    end
  end

  def play_again
    game = Mastermind.new
    game.setup($player.name)
  end

end