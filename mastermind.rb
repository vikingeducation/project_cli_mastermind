
COLORS = ["green","red","blue","purple","orange","yellow"]
PEGS =["white","black"]

class Game

  def initialize
    @code = []
    @play_board = Board.new
  end

  def create_players
    @codemaker = Computer.new
    @codebreaker = Human.new
  end
    
  def play
    create_players

    @code = @codemaker.generate
    print "#{@code} - Code generated"
    12.times do
      answer = @codebreaker.guess
      
      check_win(answer)

      @play_board.add_to_board(answer)
      p @play_board.board

      @play_board.add_to_board(@codemaker.feedback(answer, @code))
      p @play_board.board
    end

  end

  def check_win(input)
    if @code == input 
      puts "You won!" 
      exit
    end
  end

end

    #render a board

    #player tries to guess
    #gives a feedback
    #player want to exit or wins?

    #After loop ends player loses
    #show the code



class Player

  def feedback(answer, code)  
    #blacks
    pegs=[]
    
    for i in (0..3) do
      if answer[i]==code[i] 
        pegs << "black" 
      elsif code.any? {|color| color==answer[i]}
        pegs << "white" 
      else
        pegs << 0
      end
    end

    puts "#{pegs} - pegs"
    pegs
  end
  

end

class Human < Player
  def initialize

  end

  def generate

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
    puts "#{new_code} New code generated"
    new_code
    
  end


  def guess
  end

end

class Board

  attr_reader :board

  def initialize
    @board=[]
    #[[4 colors, 4 pegs],[]...12]
  end

  def add_to_board (input)
    @board << input
  end

  def display_board

  end

end

g=Game.new

g.play