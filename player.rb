class Player

  attr_accessor :name

  # initialize
  def initialize(board)
    @board = board
  end

  # get_input
  def get_input(turn)
    # loop infinitely
    loop do
      # ask_for_input
      usr_input = ask_for_input

      # IF validate_input is true
      if @board.input_valid?(usr_input)
        # break loop
        @board.add_peg(usr_input, turn)
          break
      end
    end

  # ask_for_input
  def ask_for_input
   # Display message asking for input
   puts "Please enter move: "
   # pull input form command line
   input = gets.chomp.upcase.split('')
  end
end