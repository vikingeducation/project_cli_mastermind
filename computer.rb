class Computer
  include Correctitudable

  attr_reader :space

  def initialize
    @space = all_guesses
  end

  def all_guesses
    @all_guesses ||= (1111..6666).map do |number|
      array = number.to_s.chars.map(&:to_i)
      if valid_range?(array)
        Code.from_array(array)
      end
    end.compact
  end

  def valid_range?(array)
    array.all?{ |i| (1..6) === i }
  end

  def purge_space(results)
    @space.select! do |solution|
      if determine_correctitude(@guess, solution) == results
        true
      end
    end
  end

  def minimax
    space.max_by do |guess|
      answer_combinations.map do |answer|
        all_guesses.map do |solution|
          determine_correctitude(guess, solution) != answer ? 1 : 0
        end.inject(:+)
      end.min
    end
  end

  def answer_combinations
    (0..4).to_a.repeated_permutation(2).to_a.select { |combo| combo.inject(:+) <= 4}
  end

  def next_guess
    unless @guess
      @guess = Code.from_array([1,1,2,2])
    else
      @guess = minimax
    end
  end
end
# ~> -:2:in `<class:Computer>': uninitialized constant Computer::Correctitudable (NameError)
# ~> 	from -:1:in `<main>'
