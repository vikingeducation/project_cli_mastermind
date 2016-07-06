class Board
  attr_reader :guesses
  def initialize
    @key=[]
    @display=[]
    @guesses = 0
    @guess=[]
  end

  def render
    check_accuracy
    #draw the board
  end

  def get_key(key)
    @key=key
  end

  def set_key(key)
    @key=key
  end 

  def correct?
    @guess==@key
  end

  def update_display(guess)
    @display << guess
    @guess=guess
  end

  def check_accuracy
    puts "You have #{exact_check} exact guesses."
    puts "You have #{close_check} close guesses."
    @guesses += 1
  end

  def exact_check
    exacts=0
    (0..3).each do |i|
      if @key[i]==@guess[i] 
        exacts +=1 
      end
    end
    exacts
  end

  def color_check
    match = 0
    dup_key = @key.dup
    @guess.each do |i|
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