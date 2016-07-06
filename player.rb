class Player
  def initialize(name)
    @name = name
  end 

  def get_move(board)
    puts "Let's get your next move."
    input_code(board)
  end

  def make_answer(board)
    puts "Let's set up the secret answer."
    input_code(board)
  end

  def self.create_player(name)
    input = ""

    until %w[ human h computer c].include?(input)
      puts "Will #{name} be a computer or a human?"
      input = gets.chomp.downcase
    end

    if %w[ human h ].include?(input)
      Human.new(name)
    else
      Computer.new(name)
    end
  end

end