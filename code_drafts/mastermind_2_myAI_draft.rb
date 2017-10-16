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
      puts "DBG: @player = #{@player.inspect}"
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

#============================================
class Board

  def initialize(code, pegs)
    @board = [[nil,nil,nil,nil],[nil,nil,nil,nil]]
    @code = code
    @stored_scores = {}
    @pegs = pegs
  end

  def add_pegs(picked_colours)
    @board[0] = picked_colours
    @board[1] = score_provider
  end

  def add_turn_to_storage(turn)
    @stored_scores[turn] = @board.dup
  end

  def check_in_storage(turn)
    @stored_scores.values_at(turn)
  end

  def render(turn)
    puts
    puts
    puts "    TURN NUMBER #{turn}"
    1.upto(turn-1) do |turn_number|
      break if @stored_scores  == {}
      colour_and_score_pegs = check_in_storage(turn_number)
      puts "|*|*|*|*| * * |#{colour_and_score_pegs[0][1][0]}|#{colour_and_score_pegs[0][1][1]}|"
      puts "|#{colour_and_score_pegs[0][0][0]}|#{colour_and_score_pegs[0][0][1]}|#{colour_and_score_pegs[0][0][2]}|#{colour_and_score_pegs[0][0][3]}| * * |#{colour_and_score_pegs[0][1][2]}|#{colour_and_score_pegs[0][1][3]}|"
      puts
    end
  end

  def score_provider
    final_score = score_for_colours_in_position + score_for_colours_only
    (4-final_score.size).times {|iterator| final_score << "-"} if final_score.size != 4
    final_score
  end

  private

  def score_for_colours_in_position
    feedback = []
    4.times do |position|
      feedback << @pegs[1] if @code[position] == @board[0][position]
    end
    feedback
  end

  def score_for_colours_only
    feedback = []
    code_as_string = @code.join(",")
    4.times do |position|
      if code_as_string.include?(@board[0][position]) \
                          && @code[position] != @board[0][position]
        feedback << @pegs[0]
        code_as_string.delete! @board[0][position]
      end
    end
    feedback
  end

end

#=======================================
class ComputerCodemaker

  def initialize(colours)
    @colours = colours
  end

  def get_combination
    combination = []
    4.times {|colour_index| combination << @colours[rand(0..5)]}
    combination
  end
end

#=========================================


class HumanCodebreaker

  def initialize(colours, board)
    @colours = colours
    @board = board
  end

  def get_combination
    loop do
      guess = ask_for_combination #i.e. ["R", "O", "B", "G"]
      if validate_combination(guess)#it's true
        @board.add_pegs(guess)
        break
      end
    end
  end

  protected

  def ask_for_combination
    puts
    puts
    puts "Take a guess, what is the secret combination of the colours?"
    puts "Please choose 4 colours from the following (colours might be duplicated):"
    puts "RED BLUE GREEN PURPLE YELLOW ORANGE"
    puts "You can make a guess by typing the first letter of each colour in the following pattern: R-G-B-B"
    puts
    puts
    gets.strip.upcase.split("-")
  end

  def validate_combination(combination)
    correct_picks = combination.select {|colour| (@colours.join).include?(colour)}
    if correct_picks.size == 4
      true
    else
      puts "You have typed incorrect pattern. Please provide correct colour combination guess."
    end
  end


end

#======================

class ComputerCodebreaker < HumanCodebreaker

  def initialize(colours, board) #testing
    super(colours, board)
    @stored_guesses = []
    @probability_storage = { "R" => 1,
                             "B" => 1,
                             "G" => 1,
                             "P" => 1,
                             "Y" => 1,
                             "O" => 1 }
  end

  protected

  def ask_for_combination
    combination = []
    4.times do |colour_index|
      random_colour = @probability_storage.
      if validate_combination(random_colour)
        if 
      combination << random_colour
    end
    combination
  end

  def probability_increaser(chosen_colour)
    if chosen_colour
    @probability_storage.map {|key, value| }
  end

  def add_to_probability_storage
    points = 0
    @board.score_provider.each do |x| 
      if x == "-"
        points -= 1
      elsif x == "b"
        points += 2
      elsif x == "w"
        points += 1
      end
    end
    points
  end

  def validate_combination(combination)
    true if @stored_guesses.select {|colour| colour == combination}.empty?
  end

end


#=========================================

class HumanCodemaker

  def initialize(colours)
    @colours = colours
  end

  def get_combination
    guess = []
    loop do
      guess = ask_for_combination #i.e. ["R", "O", "B", "G"]
      if validate_combination(guess)#it's true
        break
      end
    end
    guess
  end

  private

  def ask_for_combination
    puts
    puts
    puts "Create a code, a secret combination of the colours for the codebreaker?"
    puts "Please choose 4 colours from the following... you can duplicate some of them if you choose:"
    puts "RED BLUE GREEN PURPLE YELLOW ORANGE"
    puts "You can make a guess by typing the first letter of each colour in the following pattern: R-G-B-B"
    puts
    puts
    gets.strip.upcase.split("-")
  end

  def validate_combination(combination)
    correct_picks = combination.select {|colour| (@colours.join).include?(colour)}
    if correct_picks.size == 4
      true
    else
      puts "You have typed incorrect pattern. Please provide correct colour combination guess."
    end
  end

end

#=========================================




