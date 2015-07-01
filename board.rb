class Board #Board and history of mastermind.rb

  def initialize
    @board = Array.new(12) { |row| row = ["-","-","-","-"] }
    @pegs =[]
  end

  def add_to_match_history(hint)
    @pegs << hint
  end

  def render
    puts
    @board.each_with_index do |row, index|
      print row
      print @pegs[index]
      print "\n"
    end
    puts
  end

  def update(guess, attempts_left)
    @board[12 - attempts_left]= guess
  end

end