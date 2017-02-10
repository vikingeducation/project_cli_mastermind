require_relative 'board'
require_relative 'player'
require_relative 'computer'

class Mastermind
  CODE_COLORS = [:red, :blue, :yellow, :green, :orange, :purple]
  QUIT_OPTIONS = ["q", "quit", "exit"]

  attr_reader :code, :current_turn, :turns, :board, :player, :computer

  def initialize(turns = 12)
    @code = nil
    @turns = turns
    @current_turn = 1
    @board = Board.new
    @player = Player.new
    @computer = nil
  end

  # main game loop
  def play
    display_instructions

    player.set_role

    if player.role == :codebreaker
      self.code = generate_secret_code

      player_breaks_code
    else
      # player sets the code
      self.code = player.get_next_move

      computer_breaks_code
    end
  end

  private

  def code
    @code
  end

  def code=(value)
    @code = value
  end

  # computer breaks the code
  def computer_breaks_code
    @computer = Computer.new

    loop do
      computer.make_guess

      computer_victory if computer_won?

      feedback = give_feedback(computer.guess)

      board.update_board(current_turn, computer.guess)
      board.update_feedback(current_turn, feedback)

      board.display_gameboard(current_turn)

      computer_defeat if current_turn == turns

      @current_turn += 1
    end
  end

  # loop for player to break code
  def player_breaks_code
    loop do
      begin
        player.get_next_move

        quit_game if QUIT_OPTIONS.include?(player.move)

        player_victory if player_won?

        feedback = give_feedback(player.move)

        board.update_board(current_turn, player.move)
        board.update_feedback(current_turn, feedback)

        board.display_gameboard(current_turn)

        player_defeat if current_turn == turns        
        
        @current_turn += 1
      rescue Interrupt
        quit_game
      end
    end
  end

  # generates random secret code
  def generate_secret_code
    code = []
    4.times { code << CODE_COLORS.sample }
    
    code
  end

  # checks if the computer made a correct guess
  def computer_won?
    computer.guess == code
  end

  # checks if the player made a correct guess
  def player_won?
    player.move == code
  end

  # gives feedback on a guess
  def give_feedback(guess)
    feedback = {}
    remaining_code = code.dup
    remaining_guess = guess.dup

    # first determine the black pegs
    guess.each_with_index do |guess_peg, i| 
      if guess_peg == remaining_code[i]
        feedback[i] = :black 
        remaining_code[i] = nil
        remaining_guess[i] = nil
      end
    end
    
    # now determine the white pegs
    remaining_guess.each_with_index do |guess_peg, i|
      next if guess_peg.nil?

      if remaining_code.include?(guess_peg)
        feedback[i] = :white
        remaining_code.delete_at(remaining_code.index(guess_peg))
      end
    end

    feedback
  end

  # prints instructions/rules for game,
  # e.g. valid input format for guess, how to quit
  def display_instructions
    puts "Welcome to Mastermind!"
    puts "You have #{turns} turns to guess a code consisting of 4 colored pegs."
    puts "Each peg can be any of the following colors: #{CODE_COLORS.map(&:to_s).join(", ")}."
    puts "If your guess is incorrect, you will get feedback in the form of black and white pegs."
    puts "A black peg indicates your guess includes a peg which is correct in both color and position."
    puts "A white peg indicates your guess includes a peg which is correct in color, but in the wrong position."
    puts
    puts "Please enter your guess in the format: color, color, color, color"
    puts "For example: red, green, blue, orange"
    puts
    puts "Enter (q)uit to quit at any time."
    puts
    puts "Good luck!"
    puts
  end

  def quit_game
    puts
    puts "Goodbye!"
    exit
  end

  def player_victory
    puts
    puts "Congratulations, you won!"
    exit
  end

  def computer_victory
    puts
    puts "It's only a matter of time before Skynet is born."
    puts
  end

  def player_defeat
    puts
    puts "Sorry, you failed to crack the code!"
    puts "The secret code was: #{board.process_guess(code)}."
    puts "Better luck next time!"
    exit
  end

  def computer_defeat
    puts
    puts "Whew, looks like the machines can't take over the world yet."
    puts "The secret code was: #{board.process_guess(code)}."
    puts "We live another day!"
    exit
  end
end

if $0 == __FILE__
  m = Mastermind.new
  m.play
end