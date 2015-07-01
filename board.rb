require 'yaml'

# Board represents the game state internally.
class Board

  attr_reader :guesses, :hints, :winning_condition

  def init_with(code)
    @guesses = code['guesses']
    @hints = code['hints']
    @winning_condition = code['winning_condition']
  end

  def initialize(condition = [])
    @guesses = []
    @hints = []
    @winning_condition = condition
  end

  def check_win?
    @guesses[-1] == @winning_condition
  end

  def set_win_condition(condition)
    @winning_condition = condition
  end

  def num_guesses
    @guesses.length
  end

  def accept_guess(guess)
    new_hint = calculate_hint(guess)
    @guesses << guess
    @hints << new_hint
  end

  def save_game
    save_string = YAML.dump(self)
    game_file = File.new("./save.yaml", "w")
    game_file.write(save_string)
    game_file.close
    puts "saving game"
  end

  private

    def calculate_hint(guess)
      black_pegs, white_pegs = count_pegs(guess)

      generate_hint(black_pegs, white_pegs)
    end

    def generate_hint(black, white)
      hint = []

      black.times {hint << "B"}
      white.times {hint << "W"}

      hint << " " until hint.length > 3
      return hint
    end

    def count_pegs(guess)
      black_pegs = white_pegs = 0
      sort_guess = guess.sort
      sorted_win_condition = @winning_condition.sort

      guess.each_with_index do |val, index|
        if val == @winning_condition[index]
          black_pegs += 1
        end
      end

      sort_guess.each_with_index do |val, index|
        if val == sorted_win_condition[index]
          white_pegs += 1
        end
      end

      white_pegs = white_pegs - black_pegs

      return black_pegs, white_pegs
    end
end