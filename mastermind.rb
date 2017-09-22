PEGS = %w(R G B Y O T).freeze

class Board
  attr_accessor :guess_number
  def initialize
    @board = []
    @hints = []
    @guess_number = 0
  end

  def increment_guess_number
    @guess_number += 1
  end

  def display_board
    @board.each_with_index { |row, i| print row, @hints[i], "\n" }
  end

  def prompt_for_guess
    if @guess_number.zero?
      puts '**Welcome to Mastermind!**'
      puts ''
      puts '>>Enter your first guess.'
      puts ">>If it matches the code maker's code, you win!"
      puts '>>Otherwise, the code maker will give you clues to help you along.'
      puts '>>You have 12 tries to crack the code.'
    else
      puts 'Nope! Try again!'
    end
  end

  def add_guess(guess)
    @board << guess
  end

  def create_hint(guess, code)
    hint = [0, 0]
    code.each_with_index do |peg, i|
      if peg == guess[i]
        hint[0] += 1
      elsif guess.include?(peg) && hint[1] < guess.count(peg)
        hint[1] += 1
      end
    end
    @hints << " Exact matches: #{hint[0]}, Color matches: #{hint[1]}"
  end
end

class CodeMaker
  attr_reader :code

  def initialize
    @code = []
    4.times { @code << PEGS.sample }
  end
end

class CodeBreaker
  def make_guess
    @guess = gets.chomp.upcase.split('')
    validate_guess
    @guess
  end

  def validate_guess
    until @guess.length == 4 && @guess.all? { |peg| PEGS.include?(peg) }
      puts 'Not a valid guess - try again!'
      make_guess
    end
  end
end

class Game
  def initialize
    @codemaker = CodeMaker.new
    @codebreaker = CodeBreaker.new
    @board = Board.new
    @code = @codemaker.code
    @guess_number = @board.guess_number
  end

  def guess_sequence
    @board.prompt_for_guess
    @guess = @codebreaker.make_guess
    @board.add_guess(@guess)
    @board.increment_guess_number
  end

  def update_board
    @board.create_hint(@guess, @code)
    @board.display_board
  end

  def play
    while @guess != @code && @guess_number <= 12
      guess_sequence
      update_board
    end
    @guess == @code ? (puts 'Good Job! You win!') : (puts 'Sorry, no more guesses!')
  end
end

game = Game.new
game.play
