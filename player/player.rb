#all human interaction needs to be validated here
class Player
  attr_accessor :role
  
  def initialize(role=nil)
    @role = role
  end


  #factory methods
  def self.build_codemaker
    new( :codemaker )
  end

  def self.build_codebreaker
    new( :codebreaker )
  end

  #set player 2 role based on other player's role
  def set_role(opposing_player_role)
    if opposing_player_role == "codemaker"
      @role = "codebreaker"
    else
      @role = "codemaker"
    end
  end

  def get_color_pegs
    code_peg_colors = ["red", "navy", "green", "blue", "yellow", "violet", "pink", "brown"]
    print "Enter your 4 colors from #{code_peg_colors} : "
    user_input = gets.chomp.split(" ")

    until user_input.length == 4 &&\
          user_input.all? { |item| code_peg_colors.include?(item) }
      print "Enter your 4 colors from #{code_peg_colors} : "
      user_input = gets.chomp.split(" ")
    end
    user_input

  end

end
