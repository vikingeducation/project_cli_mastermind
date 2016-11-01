class CodeBreaker
  COLORS = ["Red", "Grn", "Blu", "Yel", "Brn", "Ong", "Blk", "Wht"]
  def initalize(attrs)
    @ai_breaker = attrs[:ai] || false
  end
  def acquire_current_guess
    puts "Please enter 4 colors, 1 space apart."
    puts "Available colors: Red, Grn, Blu, Yel, Brn, Ong, Blk, Wht"
    input = gets.chomp.capitalize.split(" ")
    acquire_current_guess unless valid?(input)
    input
  end
  def valid?(input)
    unless @input.size != 4
      @input.all? { |color| COLORS.include?(color) }
    else
      puts "Please do it right."
      false
    end
  end
  def get_guess
    if @ai_breaker == false
      @current_guess = acquire_current_guess
    end
    @current_guess
  end
end