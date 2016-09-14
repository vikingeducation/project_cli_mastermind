class Computer < Player

  #not that smart, not utterly dumb

  def initialize
    @current_guess = [ ]
    @poss_indices = [*0..3]
  end

  def guess(turn_num)
    if turn_num == 12
      puts "And now, for the computer's final guess!" 
    else
      puts "\nThe computer is guessing..."
    end
    compute(turn_num)
    $guess = Guess.new(turn_num, @current_guess)
  end

  def get_index
    index = @poss_indices.sample
    @poss_indices -= [index]
    return index
  end

  def compute(turn_num)
    if turn_num == 1
      4.times { @current_guess << POSS_PEGS.sample }
    else
      prev_guess = @current_guess
      @current_guess = Array.new(4)
      $guess.close.times do
        index = get_index
        rand_index = @poss_indices.sample
        @current_guess[rand_index] = prev_guess[index]
      end
      $guess.exact.times do
        index = get_index
        @current_guess[index] = prev_guess[index]
      end
      @current_guess.map! do |value|
        value.nil? ? value = POSS_PEGS.sample : value = value
      end
    end
    @poss_indices = [*0..3]
  end

end