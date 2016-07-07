require_relative 'player'
class Human < Player

  def get_secret_code
    puts "What is your secret code?"
    @guess = gets.chomp.split(' ').map { |color| color.downcase }
  end
end
