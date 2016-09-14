class Guess

  attr_reader :exact, :close

  def initialize(guess_num, guess)
    @guess_num = guess_num
    @guess = guess
    @feedback = []
    @exact = 0
    @close = 0
    @latest = []
    calculate_feedback
  end
  
  def latest
    @latest = [@guess_num, [@guess, @feedback]]
    @latest
  end

  def num_exact
    @guess.each_with_index do |color, position| 
      @exact += 1 if color == $winning[position]
    end
    @exact
  end

  def num_close
    overlapping = $winning & @guess
    @close = overlapping.size - @exact
    @close
  end

  def calculate_feedback
    num_exact.times { @feedback << "!" }
    num_close.times { @feedback << "*" }
    @feedback << "X" until @feedback.size == 4
  end

  def winning?
    winning_elements = @feedback.select { |item| item == "!" }
    winning_elements.size == 4
  end

end