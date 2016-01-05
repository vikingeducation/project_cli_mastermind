require_relative './player.rb'

class Human < Player

  def get_and_set_role
    print "Enter Player1 role (codemaker or codebreaker): "
    user_input = gets.chomp
    
    while !["codemaker","codebreaker"].include?(user_input)
      user_input = gets.chomp
    end
    self.role = user_input	  
  end

end
