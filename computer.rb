class Computer < Player
attr_reader :key

  def initialize(board)
    super(board)
    @key=[]
  end

  def gets_guess
    # rand
  end
  def input_colors
    4.times do 
     @key << @@VALID_COLORS.sample
    end
    @board.set_key(@key)
  end
end