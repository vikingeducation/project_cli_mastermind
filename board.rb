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