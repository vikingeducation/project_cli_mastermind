class Game

  def initialize
    @board = Board.new
  end

  def play
    puts "Welcome to Mastermind!!"
    assign_players
    @codemaker.set_master_code
    12.times do
      turn
      break if win?
    end
    final_message
  end

  def turn
    @board.render(@codemaker.master_code)
    @codebreaker.guess_code
    @board.enter_guess(@codebreaker.code)
    @board.add_keys(@codemaker.master_code, @codebreaker.code)
  end

  def assign_players
    until @codemaker
      puts "Would you like to play as Codemaker(m) or Codebreaker(b)? "
      choice = gets.chomp
      if choice == "m"
        @codemaker = Human.new
        @codebreaker = Computer.new
      elsif choice == "b"
        @codemaker = Computer.new
        @codebreaker = Human.new
      end
    end
  end
end

def win?
  @codemaker.master_code == @codebreaker.code
end

class Player

  attr_accessor :code, :master_code

  def valid_code?(code)
    return false unless code.length == 4 && valid_chars?(code.chars)
    true
  end

  def valid_chars?(chars)
    valid_chars = %w(R B G Y O P)
    chars.all?{ |char| valid_chars.include?(char) }
  end
end

class Human < Player

  def guess_code
    puts "Codebreaker enter your code: e.g. brgo"
    @code = get_code_input
  end

  def set_master_code
    puts "Choose your master code (e.g. brgo): "
    @master_code = get_code_input
  end

  def get_code_input
    colors = nil
    loop do
      colors = gets.chomp.upcase
      break if valid_code?(colors)
      puts "That wasn't a valid code! Enter in 'bgor' format!"
    end
    colors
  end


end

class Computer < Player

  def guess_code
    @code = generate_code
  end

  def set_master_code
    @master_code = generate_code
  end

  def generate_code
    code = ""
    valid_chars = %w(R B G Y O P)
    4.times do {code << valid_chars.sample}
    code
end

class Board

  def initialize
    @game_board = []
  end

  def enter_guess(code)
    @game_board << [code]
  end

  def add_keys(master_code, code)
    return_string = ''
    @blacks = count_black_keys(master_code, code)
    @whites = count_white_keys(master_code, code)
    @blacks.times { return_string += 'b' }
    @whites.times { return_string += 'w' }
    @game_board.last << return_string
  end

  def count_white_keys(master_code, code)
    num_of_whites = 0
    code.chars.each do |char|
      num_of_whites += 1 if master_code.include?(char)
    end
    num_of_whites - @blacks
  end

  def count_black_keys(master_code, code)
    num_of_blacks = 0
    code.chars.each_with_index do |char, index|
      num_of_blacks += 1 if master_code[index] == char
    end
    num_of_blacks
  end

  def render(master_code)
    @game_board.each do |line|
      line.first.chars.each { |char| print char + ' ' }
      print '*|* '
      line.last.chars.each  { |char| print char + ' ' }
      print "\n"
    end

  end




end
