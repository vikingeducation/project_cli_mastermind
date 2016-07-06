class Board
  attr_reader :guesses
  def initialize
    @key=[]
    @display=[]
    @guesses = 0
  end

  def render
  end

  def get_key(key)
    @key=key
  end

  def correct?(guess)
    guess==@key
  end

  # @display << guess

  def check_accuracy(guess)
    puts "You have #{exact_check(guess)} exact guesses."
    puts "You have #{close_check(guess)} close guesses."
    @guesses += 1
  end

  def exact_check(guess)
    exacts=0
    (0..3) each do |i|
      exacts +=1 if @key[i]==guess[i]
    end
    exacts
  end

  def color_check(guess)
    match = 0
    dup_key = @key.dup
    guess.each do |i|
      if dup_key.include?(i)
        dup_key.delete_at(dup_key.index(i))
        match += 1
      end
    end
    match
  end

  def close_check
    color_check - exact_check
  end

end