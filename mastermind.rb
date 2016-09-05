
class Mastermind
    #initalize the different classes
 
  def initialize
    @board = Board.new
    @computer = Computer.new      
    @codebreaker = Codebreaker.new(@board, @computer.generate_code)  

  end
    
  #play
  def play
  #test
    sequence = @computer.generate_code
    loop do
      @board.render
      @codebreaker.get_guess
      break if check_game_over
    end
  end
  
  def check_game_over
    #check for victory
    #check for 12th input
  end
    
    

end
############################################
class Codebreaker
  def initialize(board, code_sequence)
    @board = board      
    @code_sequence = code_sequence
    @turns = 0
  end
  
  def get_guess

    colors = ask_for_guess
    if valid_input?(colors)
       feedback = give_feedback(colors)
      
       if check_win(colors)
         puts "You win!"
         exit
       else
         print feedback
       end
        
       if @turns ==11
         puts "Sorry, you lose"   
         exit    
       end
       @board.add_colors(colors)
       @turns+=1
       
    end
      
    
  end
  
  
  ##Validation of length and Colors    
  def valid_input?(colors)
    valid_colors = %w(r b g o y w)
    if colors.length == 4 && valid_colors?(colors)
      true
    else
      puts "!!!Invalid format and/or Invalid Colors - colors not added!!!"
    end
  end
    
  def valid_colors?(colors)
    valid_colors = %w(r b g o y w)
    colors.each do |color|
      if !valid_colors.include?(color)
        return false        
      end
    end
  end
  ##End Validation
    
  def ask_for_guess
    puts "Enter your 4 colors (r b g o y w) separated by commas"
    gets.strip.split(",").map(&:to_s)
  end
    
  def give_feedback(colors)
    exactarr = []
    exact = 0
    near = 0
    miss = 0
    for i in 0..3
      if colors[i] == @code_sequence[i]
        exact+=1
        exactarr << colors[i]
        next
      
      elsif @code_sequence.include?(colors[i]) && !exactarr.include?(colors[i])
        near+=1
        next
      else
        miss+=1  
      end
    end
    "exact: " + exact.to_s + " " + "near: " + near.to_s + " " +"missed: " + miss.to_s

  end
    
  def check_turns
  end
    
  def check_win(colors)
    for i in 0..3
      if colors[i] != @code_sequence[i]
        return false         
      end
    end
    true   
  end
    
end

############################################
class Board
  def initialize
    @board = Array.new(12){Array.new(4)}
    @feedback = Array.new(12)
    @current_row = 0
  end

  def add_colors(colors)
    @board[@current_row] = colors
    @current_row+=1

  end
    
  def render
    puts
    @board.each do |row|
      row.each do |cell|
        cell.nil? ? print("-") : print(cell.to_s)
      end
      #print feedback here before newline
      puts
    end
    puts  
  end

end
############################################
class Computer
  def generate_code
    @colors = %w(r b g o y w).shuffle
    @code_sequence =[]
    4.times do
      @code_sequence <<  @colors.pop     
    end
    @code_sequence  
  end
end

game = Mastermind.new
game.play