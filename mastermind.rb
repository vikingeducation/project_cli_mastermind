
COLORS = ["green","red","blue","purple","orange","yellow"]
PEGS =["white","black"]

class Game

  def initialize
    @@code = []
  end
#define variables
#randomly choosen code
codemaker = Codemaker.new
@@code=codemaker.generate

#Game loop started (12 times)
player=Player.new

12.times do
  @@board << player.guess
  puts @@board
end

#render a board

#player tries to guess
#gives a feedback
#player want to exit or wins?

#After loop ends player loses
#show the code

end

class Player
  def guess
    puts "Enter 4 colors from #{COLORS} (like this #{green red blue purple})"
    gets.chomp.split(" ")
  end

end

class Codemaker < Player
  def initialize

  end

  def generate
    4.times do 
      @@code << COLORS.sample
    end
    @@code
  end
end

class Codebreaker < Player


end

class Board
  def initialize

    @@board=[]
    #[[4 colors, 4 pegs],[]...12]
  end



end