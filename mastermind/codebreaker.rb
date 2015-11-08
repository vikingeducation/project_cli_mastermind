class Codebreaker
  include DataIO

  def initialize(name, board)
    @name = name
    @board = board
  end

  def get_guess
    loop do
      current_guess = get_input("Enter move (options: r, b, g, y, p, o)")

      # TODO:  allow for quitting

      if valid_entry_format?(current_guess)
        break if @board.place_guess(current_guess)
      end
    end
  end

end