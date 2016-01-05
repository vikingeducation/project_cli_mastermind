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

  def create_autogenerate_solution 
    solution = []
    4.times do
      solution << Peg::COLORS.sample
    end
    create_solution( solution )
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
      str << "Guess number #{guess_num}: #{@guesses[guess_num].to_s} #{@responses[guess_num].join}\n"
    end
    str
  end
end