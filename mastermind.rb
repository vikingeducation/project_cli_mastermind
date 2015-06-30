
COLORS = ["green","red","blue","purple","orange","yellow"]
PEGS =["o","*"]


class Game

  def initialize ()
    @code = []
    @play_board = Board.new
  end

  def new_game?
    puts "Do you want to start a new game or open a saved game (n/s)"

    if gets.chomp = "s"
      @saved_game
    end
  end

  def create_players
    puts "Do you want to be a codemaker? (y/n)"
    if gets.chomp == "n" 
      @codemaker = Computer.new
      @codebreaker = Human.new
    else
      @codemaker = Human.new
      @codebreaker = Computer.new
    end
  end

    
  def play
    create_players

    @code = @codemaker.generate

    12.times do |x|

      puts "\n"
      puts "This is your turn #{x+1}" 

      answer = @codebreaker.guess  
      check_win(answer)

      @play_board.add_to_board(answer)
      puts "#{answer} - your guess"

      @play_board.add_to_board(@codemaker.feedback(answer, @code))
      puts "Our board"
      @play_board.display_board

    end

    end_game
  end

  def end_game
    puts "\n"
    if @codemaker.is_a? Human
      puts "Computer lost. You won. The answer is #{@code}"
    else
      puts "You lost. The answer is #{@code}"
    end
  end
  def check_win(input)
    if @code == input 
      puts "You won!" 
      exit
    end
  end

end

class Player

  def feedback(answer, code)  
    
    pegs=[]
    
    for i in (0..3) do
      if answer[i]==code[i] 
        pegs << PEGS[1] 
      elsif code.any? {|color| color==answer[i]}
        pegs << PEGS[0] 
      else
        pegs << "-"
      end
    end

    puts "#{pegs} - pegs"
    pegs.shuffle
  end
  
end

class Human < Player

  def generate
    puts "Please enter the code"
    gets.chomp.split(" ")
  end

  def guess
    puts "Enter 4 colors from #{COLORS} (like this green red blue purple)"
    gets.chomp.split(" ")
  end

end

class Computer < Player

  def generate
    new_code = []

    4.times do 
      new_code.push(COLORS.sample) 
    end
    new_code    
  end


  def guess   
    gets
    self.generate
  end

end

class Board

  attr_reader :current_board

  def initialize
    @current_board=[]
    #[[4 colors, 4 pegs],[]...12]
  end

  def add_to_board (input)
    @current_board << input
  end

  def display_board 

    for i in (0..@current_board.size)
      if i.odd? 
        @current_board[i].each {|el| print "#{el} "}
        puts
      else
        print("#{@current_board[i]}")
      end
    end

  end

end

g=Game.new

g.play