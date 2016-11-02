class Board
  attr_reader :colors
  attr_accessor :turns, :maker_sequence

  def initialize(args={})
    @colors = args[:colors] || DEFAULT_COLORS
    @maker_sequence = nil
    @turns = 0
  end

  DEFAULT_COLORS = ['r', 'g', 'b', 'o', 'y', 'p']

  def check_guess(sequence)
    matches = check_exact(sequence)
    exact_matches = matches[:exact]
    near_matches = check_near(matches[:secret],matches[:guess])
    { near: near_matches, exact: exact_matches }
  end

  def check_exact(sequence)
    secret = maker_sequence.dup
    guess = []
    exact_matches = 0
    sequence.each_with_index do |color, i|
      if color == secret[i]
        secret[i] = nil
        exact_matches += 1
      else
        guess << color
      end
    end
    { exact: exact_matches, secret: secret, guess: guess }
  end

  def check_near(secret, guess)
    near_matches = 0
    guess.each do |color|
      i = secret.find_index(color)
      if i
        near_matches += 1
        secret.delete_at(i)
      end
    end
    near_matches
  end

  def turn
    @turns += 1
  end
end