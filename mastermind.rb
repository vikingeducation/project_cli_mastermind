## CODEBREAKER
# The game board is rendered between turns
# => class: Board, Public-Action: render

# The player only gets 12 turns to crack the code
# => Class: MasterMind, Public-Action: play(while or until)

# The player wins if the code is correctly guessed by the last turn
# => Class: MasterMind, Private-Action: player_win?

# The rendered board displays the number of "close" pegs (correct color, wrong position)
# => class: Board, Private-Action: close_feedback

# The rendered board displays the number of "exact" pegs, e.g. those which exactly match the color and position of the computer's code
# => class: Board, Private-Action: exact_feedback

# The player loses after the 12th turn if the code hasn't been broken
# => class: MasterMind, Private-Action: player_lose?

# When losing, the code is displayed to the player
# => class: Board, Private-Action: show_hidden_code

## CODEMAKER
# The game now asks whether the player wants to be the "codebreaker" or "codemaker" upon startup
# => class: Player, Public-Action: pick_character

# The codemaker player is prompted to enter a code
# => class: Player, Public-Action: initialize_code

# Once the code is entered, the computer AI "plays" the game, rendering the board between turns and displaying the final result (win/loss)
# => class: ComputerAi, Public-Action: autoplay


class MasterMind

  def initilize
    @player   = Player.new("Bran")
    @board    = Board.new
    @computer = ComputerAi.new
  end

  def play
    welcome
    if @player.pick_codebreaker?
      playing(@computer, @player)
    else
      playing(@player, @computer)
    end
    show_hidden_code
  end

  # Attention! Following methods are private.
  private

  def welcome
    puts "Welcome to the CLI version MasterMind"
    puts "It is a very challenging game, so be prepared and have fun."
  end

  def playing(maker, coder)
    code = maker.initialize_code
    12.times do |i|
      break if game_over?
      guess = coder.make_guess
      @border.display guess, i
      @border.feedback(code, guess)
    end
  end

  def game_over?
  end

  def show_hidden_code
  end

end


# Player class
class Player
  attr_accessor :name

  def initilize(name)
    @name = name
  end

  def pick_codebreaker?
    true if pick_character == 1
  end

  def make_guess
    guess_instruction
    guess = gets.chomp
    until valid_guess? guess
      guess_warning
      guess = gets.chomp
    end
    guess_format guess
  end



  # Attention! The Following methods are private
  private

  def guess_format guess
    result = []
    guess.split(",").each { |color| result << color.strip }
    result
  end

  def guess_warning
    puts "Wrong guess input"
    puts "Availble colors are as follows, four colors should be inserted."
    puts "red, blue, green, yellow, white, black"
  end

  def valid_guess? guess
    valid_guess_color?(guess) && valid_guess_length?(guess)
  end

  def valid_guess_color? guess
    color_collection = ['red', 'blue', 'green', 'yellow', 'white', 'black']
    guess.split(",").all? { |color| color_collection.include? color}
  end

  def valid_guess_length? guess
    true if guess.split(",").length == 4
  end

  def guess_instruction
    puts "Make a guess in the format 'color1, color2, color3, color4'"
    puts "For Example, 'red, green, blue, white'"
    puts "Colors above are from left to right in association with the board position"
  end

  def pick_character
    puts "Please choose your character. Enter 1 for codebreaker, 2 for codemaker."
    character = gets.chomp
    until character_valid? character
      puts "Wrong input, please enter 1 for codebreaker, 2 for codemaker"
      character = gets.chomp
    end
    character
  end

  def character_valid? character
    true if character == 1 || character == 2
  end
end


# Board class is here
class Board

  def initilize
    @array = Array.new(12){ Array.new(4, 0) }
  end

  def feedback code, guess
    result = {}
    result[:black] = exact_guess code, guess
    result[:white] = close_guess code, guess
    puts "There are/is #{result[:black]} exact guess and #{result[:white]} close result"
  end

  def display guess, i
    modify_array guess, i
    @array.each do |row|
      row.each do |element|
        print element.center(8)
      end
      puts ""
    end
  end


  # Attention! Methods below are all private
  private

  def modify_array guess, i
    4.times do |index|
      @array[i][index] = guess[index]
    end
  end

  def exact_guess code, guess
    result = 0
    4.times do |i|
      result += 1 if guess[i] == code[i]
    end
    result
  end

  def close_guess code, guess
    result = 0
    code_index_mark = []
    guess_index_mark = []
    4.times do |i|
      if guess[i] == code[i]
        code_index_mark << i
        guess_index_mark << i
      end
    end
    code.each_with_index do |code_color, code_index|
      guess.each_with_index do |guess_color, guess_index|
        if (code_color == guess_color) && (!code_index_mark.include? code_index) && (!guess_index_mark.include? guess_index)
          result += 1
          code_index_mark << code_index
          guess_index_mark << guess_index
        end
      end
    end
    result
  end

end
