require 'colorize'

# row = [:blue, :red, :green, :yellow]

class Game
  attr_reader :board, :hints, :guesses
  def initialize(player)
    @board = Array.new(12, [:white]*4)
    @hints = Array.new(12, [:yellow]*4)
    @guesses = 0
    if !player.human?
      @code = player.ask_input
    else
      @code = []
      4.times { @code += ([:blue, :red, :green, :yellow, :cyan, :magenta].sample(1)) }
    end
  end

  def render_a_row(row)
    out = ""
    row.each { |x| out += " " + x.to_s.center(12).colorize(:background => x, :color=> :black) }
    out
  end

  def render
    to_put = "\n\t"
    row_number = 1
    @board.each_with_index {
      |row, i|
      stars = ""
      to_put += render_a_row(row)
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

  def manage_guess(player)
    self.render
    guess = player.guess(self)
    @guesses +=1
    set_row(@guesses, guess)
  end


  def over?
    if @hints[@guesses - 1] == [:red, :red, :red, :red]
      puts "Congrats Codebreaker, you won in #{@guesses}"
      true
    elsif @guesses == 12
      puts "The Codemaker won!"
      puts(render_a_row(@code))
      true
    else
      false
    end
  end

end

class Codebreaker
  def initialize
    puts("Do you want to play as Codebreaker, Y/n")
    answer = gets.downcase.chomp
    if answer == "n"
      @type = :computer
    else
      @type = :human
    end
  end

  def human?
    @type == :human
  end

  def ask_input
    my_colors = {:b => :blue, :r => :red, :g => :green,
                 :c => :cyan, :y => :yellow, :m => :magenta}

    puts("Choose four colors by typing its initials, like this: brgc")
    puts("Remember, there are six colors in this game: b_lue, r_ed, g_reen, c_yan, y_ellow, and m_agenta")
    raw_guess = gets.chomp.split("")
    if raw_guess.length != 4
      ask_input
    else
      guess = []
      raw_guess.each {|x| guess.push(x.to_sym)}
      if guess.all? {|color| my_colors.include?(color)}
        value_array = []
        guess.each {|char| value_array.push(my_colors[char])}
        puts(value_array)
        value_array
      else
        puts("Sorry, there's at least a color I don't know about")
        ask_input
      end
    end
  end

  def generate_guess(game)
      guess = []
      4.times { guess += ([:blue, :red, :green, :yellow, :cyan, :magenta].sample(1)) }
      guess
  end

  def guess(game)
    if self.human?
      ask_input
    else
      generate_guess(game)
    end
  end


end



player = Codebreaker.new
puts(player.human?)
game = Game.new(player)


until game.over? do
  game.manage_guess(player)
end
