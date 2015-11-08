class Codebreaker

  def initialize(name, board)
    @name = name
    @board = board
  end

  def get_guess
    loop do
      current_guess = ask_guess

      # TODO:  allow for quitting

      if valid_guess?(current_guess)
        break if @board.place_guess(current_guess)
      end
    end
  end

  private

  def ask_guess
    puts "Enter move (options: r, b, g, y, p, o)"
    print " > "
    gets.chomp.split(',')
  end

  def valid_guess? guess
    if guess.is_a?(Array) && guess.size == 4
      true
    else
      puts "Your guess is improperly formatted"
    end
  end
end