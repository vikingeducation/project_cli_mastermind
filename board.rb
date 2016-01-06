class Board
  attr_accessor :solution_row, :guesses
  def initialize
    @solution_row = Row.new
    @guesses = []
    @responses = []
  end

  def create_solution ( solution )
    @solution_row.populate_row ( solution )
  end

  def add_guess_row( guess )
    guess_row = Row.new
    guess_row.populate_row(guess)
    @guesses << guess_row
  end

  def add_response(response)
    @responses << response
  end

  def to_s
    str = ""
    (0...guesses.length).each do |guess_num|
      str << "\nGuess number #{guess_num+1}: #{@guesses[guess_num].to_s}\nFull matches: #{@responses[guess_num][:full_match]}\nColor matches: #{@responses[guess_num][:color_match]}\n\n"
    end
    str
  end
end