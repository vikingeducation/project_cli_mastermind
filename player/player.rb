#all human interaction needs to be validated here
class Player
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
end
