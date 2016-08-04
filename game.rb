require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @player = Player.new
    @board = Board.new
    @colors = []
  end


  def play

    player_info
    @board.generate_pegs

    1.upto(12) do |game|
      get_colors
      if @colors == @board.ai_colors
        puts "#{@player.name}, you won this game after trying #{game} time(s)"
        puts "These were the colors #{p @board.ai_colors.join(" ")} "
        break
      else
        check_matches(@board.ai_colors, @colors)
        puts "#{@player.name}, you can try #{(game - 12)} more times."
      end
    end
    goodby_message
  end

  private

  def player_info
    puts "Please enter your name: "
    @player.ask_name
    puts "Hello #{@player.name}, welcome to Master Mind..."
  end

  def get_colors
    4.times do |i|
      puts "Enter the color number #{i + 1}: "
      user_input = gets.chomp.upcase
      @colors.push(user_input)
    end
  end

  def goodby_message
    puts "#{@player.name} it was nice playing with you."
    puts "We hope to see you again."
  end

  def check_matches(ai_colors, colors)
  existing = []
  exact_match = []

  ai_colors.each_with_index do |obj, ind|
    colors.each_with_index do |s_obj, s_ind|
      if obj == s_obj && ind == s_ind
        exact_match << s_obj
      elsif !(obj == s_obj) && ind == s_ind
        existing << s_obj
      end
    end
  end
  puts "You have #{exact_match.size} exact match(es)"
  puts "And #{existing.size} element(s) that exists"
  existing = []
  exact_match = []
end

end

game = Game.new
game.play
