class Mastermind

  def initialize
    @code = Code.new
    @board = Board.new(turn, @code, guess_colours)
    @player = Player.new(@board)
  end

  def instruction_display
    puts "About the game"
    puts "The computer has selected a secret combination of 4 colored pegs /
          and you have to guess that combination in 12 tries to win."
    puts
    puts "How to play . . ."
    puts "To create your guess you will be asked to choose combination of 4."
    puts "Each time you submit a guess the machine will use score pegs to let /
          you know how close that guess is."
    puts "For each guess a black score peg indicates that one of your pegs is /
          the right color in the right position."
    puts "A white score peg indicates that one of your pegs is the right color /
          in the wrong position."
  end

  def welcome_display
    puts "Hello and Welcome to Mastermind game"
    puts "Please type 'i' to remind the rules of the game or 's' to start the game"
  end

  def start_or_instruction
    loop do
      s_or_i = gets.chomp
      if s_or_i == "i"
        instruction_display
        break
      elsif s_or_i == "s"
        break
      else
        puts "This is not the value we have asked for. We asked for 's' or 'i'"
      end
    end
  end

  def play
    welcome_display
    start_or_instruction
    turn = 0
    while turn <= 12
      @board.render
      @player.get_combination
      break if is_code_guessed?
       n += 1
    end
    @board.render
    loosing
    @code.render
  end

  def is_code_guessed?
    if @player.get_combination == @code.get_combination
      puts "Congratulations!!! You have guessed the secret colour code."
      true
    else
      false
    end
  end

  def loosing
    puts "You didn't guess the right combination in 12 turns."
    puts "The right combination you didn't guess is #{@code.render}"
  end

end

#============================================
class Board
  COLOURS = ["R","B","G","P","Y","O"]
  PEGS = ["w","b"]

  def initialize(turn, code, picked_colours)
    @turn = turn
    @board = [[nil,nil,nil,nil],[nil,nil,nil,nil]]
    @code = code
    @stored_scores = {}
  end

  def add_pegs(picked_colours)
    @board[0] = picked_colours
  end

  def add_turn_to_storage(turn)
    @stored_scores[turn] = @board
  end

  def check_in_storage(turn)
    @stored_scores[turn]
  end

  def guessed_colour_on_position
    feedback = []
    4.times do |position|
      feedback << PEGS[1] if code[position] == @board[0][position]
    end
    feedback
  end

  def guessed_colour
    feedback = []
    code_as_string = @code.join(",")
    4.times do |position|
      if code_as_string.include?(@board[0][position]) \
                          && @code[position] != @board[0][position]
        feedback << PEGS[0]
        code_as_string.delete! @board[0][position]
      end
    end
    feedback
  end

  def feedback_provider
    final_feedback = guessed_colour_on_position + guessed_colour
    final_feedback.size == 4 ? final_feedback : \
                              (4-final_feedback).size.times {|iterator| final_feedback << nil}
  end

  def winnig_condition
    @board[0] == @code
  end

  def render(turn)
    turn.times do |turn_number|
      board_colours_and_feedback = check_in_storage(turn_number) #ie. [["R", "O", "B", "Y"], ["w","b", nil, nil]]
      puts "TURN NUMBER #{turn_number}"
      puts "|*|*|*|*
            | * * |
             #{board_colours_and_feedback[1][0]}
            |#{board_colours_and_feedback[1][1]}|"
      puts "|#{board_colours_and_feedback[0][0]}
            |#{board_colours_and_feedback[0][1]}
            |#{board_colours_and_feedback[0][2]}
            |#{board_colours_and_feedback[0][3]}
            | * * |
             #{board_colours_and_feedback[1][2]}
            |#{board_colours_and_feedback[1][3]}|"
    end
  end

end

#=======================================
class Code
  COLOURS = ["R","B","G","P","Y","O"]

  def initialize
    @combination = COLOURS.sample(4)
  end

  def render
    puts "#{@combination[0]} - #{@combination[1]} - #{@combination[2]} - #{@combination[3]}"
  end
end

#=========================================
class Player
  COLOURS = ["R","B","G","P","Y","O"]

  def initialize
    @board
  end

  def ask_for_combination
    puts "Take a guess of the combination of the following colours:"
    puts "RED BLUE GREEN PURPLE YELLOW ORANGE"
    puts "Please make a guess by typing first letter of colours in the following pattern:"
    puts "R-G-B-B"
    puts
    gets.strip.upcase.split("-")
  end

  def validate_combination(combination)
    combination.each do |colour|
      if colour.incldue? (COLOURS)
        true
      else
        puts "You have typed incorrect pattern. Please provide correct colour combination guess."
      end
    end
  end

  def get_combination
    loop do
      guess = ask_for_combination #i.e. ["R", "O", "B", "G"]
      if validate_combination(guess)
        break
      end
    end
  end

end
