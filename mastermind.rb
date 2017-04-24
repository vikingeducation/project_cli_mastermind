require 'colorize'

# row = [:blue, :red, :green, :yellow]

class Game
  def initialize
    @board = Array.new(12, [:white]*4)
    @code = [:blue, :red, :green, :yellow]
    @hints = Array.new(12, [:yellow]*4)
    @guesses = 0
  end

  def render
    to_put = "\n\t"
    row_number = 1
    @board.each_with_index {
      |row, i|
      stars = ""
      row.each { |x| to_put += " " + " ".colorize(:background => x) }
      @hints[i].each {|element| stars += "*".colorize(:color =>element)}
      to_put +=  " " + stars + " " + (i+1).to_s + "\n\n\t"
    }
    puts to_put
  end

  def set_hints(row)
    h = []
    y = @code
    @board[row].each_with_index { |x, i|
      if x == y[i]
        h.push(:red) # it's on its right place
        y[i] == nil # so to remove duplicates on the white hints
      elsif y.include?(x)
        h.push(:white)
      else
        h.push(:yellow)
      end
    }
    h.sort!
  end

  def set_row(row, value_array)
    array_index = row - 1
    @board[array_index] = value_array
    @hints[array_index] = set_hints(array_index)
  end

  def make_a_guess
    self.render
    my_colors = {:b => :blue, :r => :red, :g => :green,
                 :c => :cyan, :y => :yellow, :m => :magenta}
    puts("Write your guess with your for colors initials as so brgc")
    puts("Remember, there are six colors in this game: b_lue, r_ed, g_reen, c_yan, y_ellow, and m_agenta")
    raw_player_guess = gets.chomp.split("")
    if raw_player_guess.length != 4
      make_a_guess
    else
      player_guess = []
      raw_player_guess.each {|x| player_guess.push(x.to_sym)}
      if player_guess.all? {|color| my_colors.include?(color)}
        value_array = []
        player_guess.each {|char| value_array.push(my_colors[char])} #no validation! are you crazy?!
        @guesses += 1
        set_row(@guesses, value_array)
      else
        puts("Sorry, there's at least a color I don't know about")
        make_a_guess
      end
    end
  end


  def over?
    if @hints[@guesses - 1] == [:red, :red, :red, :red]
      puts "Congrats Codebreaker, you won in #{@guesses}"
      true
    elsif @guesses == 12
      puts "Congrats Codemaker, you won!"
      true
    else
      false
    end
  end

end

game = Game.new



until game.over? do
  game.make_a_guess
end
