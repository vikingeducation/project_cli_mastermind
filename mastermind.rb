require_relative "./human_codemaker.rb"
require_relative "./computer_codemaker.rb"
require_relative "./human_codebreaker.rb"
require_relative "./computer_codebreaker.rb"
require_relative "./board.rb"


class Mastermind

  COLOURS = ["R", "B", "G", "P", "Y", "O"]
  PEGS = ["w", "b"]

  def initialize
    @code = []
    @board = Board.new(@code, PEGS)
  end

  def play
    welcome_display
    start_or_instruction
    code_breaker_maker_decision
    turn = 1
    while turn <= 12
      @board.render(turn)
      @player.get_combination #it asks player and checks validation
      @board.score_provider
      @board.add_turn_to_storage(turn)
      board_state = @board.check_in_storage(turn)
      break if is_code_guessed?(board_state[0][0])
      turn += 1
      loosing_display if turn > 12
    end
  end

  private

  def instruction_display
    puts
    puts
    puts "--------ABOUT THE GAME---------"
    puts "The computer has selected a secret combination of 4 colors, some of which might be repeating"
    puts "You only have 12 turns to guess the combination."
    puts
    puts "--------HOW TO PLAY . . .-----"
    puts "To create a guess you will be asked to choose combination of four colours."
    puts "After every guess, the machine will use score pegs to let you know how close you were"
    puts "One black score peg - indicates that you have guessed one colour and its correct position."
    puts "One white score peg - indicates that you have guessed only color but were wrong about its position."
    puts
    puts
  end

  def welcome_display
    puts
    puts "Hello and Welcome to Mastermind game"
    puts
  end

  def code_breaker_maker_decision
    loop do
      puts "Please press 'm' if you want to play as Codemaker (making computer to guess)"
      puts "...or 'b' if you want to play as Codebreaker (making computer to create a secret code)"
      player_decision = gets.chomp
      break if code_breaker_or_maker?(player_decision)
    end
  end

  def code_breaker_or_maker?(decision)
    if decision == "m"
      @code = HumanCodemaker.new(COLOURS).get_combination
      @board = Board.new(@code, PEGS)
      @player = ComputerCodebreaker.new(COLOURS, @board)
      true
    elsif decision == "b"
      @code = ComputerCodemaker.new(COLOURS).get_combination
      @board = Board.new(@code, PEGS)
      @player = HumanCodebreaker.new(COLOURS, @board)
      puts "DBG: @code = #{@code.inspect}"
      true
    else
      puts "This is not the value we have asked for. We asked for 'm' or 'b'! :)"
      puts
    end
  end

  def start_or_instruction
    loop do
      puts
      puts "Please type 'i' to read instruction for the game or 's' to start the game"
      player_decision = gets.chomp
      break if s_or_i(player_decision)
    end
  end

  def s_or_i(decision)
    if decision == "i"
      instruction_display
      false
    elsif decision == "s"
      true
    else
      puts "This is not the value we have asked for. We asked for 's' or 'i'! :)"
      puts
    end
  end

  def start_or_instruction
    loop do
      puts
      puts "Please type 'i' to read instruction for the game or 's' to start the game"
      player_decision = gets.chomp
      break if s_or_i(player_decision)
    end
  end

  def loosing_display
    puts
    puts "This was your last guess."
    puts "You didn't guess the right combination in 12 turns."
    puts "The right combination you didn't guess is |#{@code.join("|")}|"
  end

  def is_code_guessed?(new_var)
    if new_var == @code
      puts "Congratulations!!! You have guessed the secret colour code."
      true
    else
      false
    end
  end

end

s = Mastermind.new
s.play
