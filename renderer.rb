class Renderer

  def initialize(board)
    @guesses = board.guesses
    @hints = board.hints
  end

  def draw
    puts (" " * 16) + "The  Board"
    puts (" " * 7) + ("Choice") + (" " * 17) + ("Hint")
    @guesses.length.times do |val|
      puts "#{@guesses[val]}  #{@hints[val]}"

    end
  end

end