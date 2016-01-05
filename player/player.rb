#all human interaction needs to be validated here
class Player
  attr_accessor :role

  def initialize(role)
    @role = role
  end

  private_class_method :new

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
      self.role = "codebreaker"
    else
      self.role = "codemaker"
    end
  end
end
