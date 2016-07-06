class Board

  def initialize
    @key=[]
    @display=[]
  end

  def render
  end

  def get_key(key)
    @key=key
  end

  def correct?(guess)
    guess==@key
  end

  def check_accuracy(guess)
    puts "You have #{check_position} exact guesses."
    check_color
  end

  def check_position(guess)
    exacts=0
    (0..3) each do |i|
      exacts +=1 if @key[i]==guess[i]
    end
    exacts
  end

  def check_color(guess)
    
  end


end