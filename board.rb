class Board

  attr_reader :guesses, :key, :VALID_COLORS
  def initialize
    @key=[]
    @display=[]
    @guesses = 0
    @guess=[]
    @VALID_COLORS=[:r,:b,:y,:g]
  end

  def render
    puts "_______"
    @display.each do |row|
      row.each do |piece|
        print "#{piece.capitalize} "
      end
    puts
    puts "_______"
    end
  end

  def set_key(key)
    if valid?(key)
      @key = key
    else
      puts "please enter a valid code"
    end
  end

  def correct?
    @guess == @key
  end

  def update_display(guess)
      @guess=guess
    if valid?(@guess)
      @display << guess
      check_accuracy
    else
      puts "please enter valid guess"
    end
  end

  def valid?(entry)
    entry.length == 4 && entry.all?{ |color| @VALID_COLORS.include?(color)}
  end

  def check_accuracy
    puts "You have #{exact_check} exact guesses."
    puts "You have #{close_check} close guesses."
    @guesses += 1
  end

  def exact_check
    exacts = 0
    @guess.length.times do |i|
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