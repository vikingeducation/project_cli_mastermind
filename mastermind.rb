require './board.rb'
require './player.rb'
require './renderer.rb'
# Game controls gameflow, also responsible for loading game.
class Game

  def initialize
    @board = Board.new
    @renderer = Renderer.new(@board)
    @player1 = Human.new(1)
    @player2 = AI.new("COMPUTER")
    @players = [@player1, @player2]
    @game_saved = false
  end

  def play

    load_or_new_game
    play_round

  end

  private

    def load_game
      game_file = File.new("./save.yaml", "r")
      yaml = game_file.read
      new_board = YAML.load(yaml)
      game_file.close
      return new_board
    end

    def load_or_new_game
      if File.exist?('./save.yaml')
        puts "There is a saved game! Type 'L' to load it!"
        choice = gets.chomp.upcase
        if choice == "L"
          load_saved_game
        else
          start_play
          get_win_condition
        end
      else
        start_play
        get_win_condition
      end
    end

    def load_saved_game
      @player1.set_role(true)
      @player2.set_role(false)
      @board = load_game
      @renderer = Renderer.new(@board)
      @renderer.draw
    end

    def check_if_save(input)
      if input.is_a? Array
        @board.accept_guess(input)
      elsif input.is_a? String
        @board.save_game
        @game_saved = true
      end
    end

    def play_round
      until(game_won || game_lost || game_saved?)
        # Get a guess from the breaker player
        new_guess = breaker.play

        check_if_save(new_guess)
        teach_if_ai
        check_breaker_win
        @renderer.draw
      end
    end

    # If an AI is the code breaker, teach the AI
    def teach_if_ai
      if breaker.is_a? AI
        breaker.learn(@board.hints[-1])
      end
    end

    def game_lost
      if @board.num_guesses > 11
        puts "Player #{breaker.player_num} lost!"
        puts "The solution was: #{@board.winning_condition}"
        return true
      end
    end

    def game_won
      if @game_won
        puts "Player #{breaker.player_num} won!"
        return true
      end
    end

    def game_saved?
      @game_saved
    end

    # Handles finding if the player won or not
    def check_breaker_win
      if @board.check_win?
        @game_won = true
      end
    end

    def start_play
      puts "Do you want to be the breaker, or the maker? Input Y to be the breaker."
      choice = gets.chomp.upcase
      if choice == "Y"
        @player1.set_role(true)
        @player2.set_role(false)
      else
        @player1.set_role(false)
        @player2.set_role(true)
      end
    end

    def get_win_condition
      new_code = maker.play

      @board.set_win_condition(new_code)
    end

    def breaker
      @players.select{|player| player.is_breaker?}[0]
    end

    def maker
      @players.reject{|player| player.is_breaker?}[0]
    end
end

game = Game.new

game.play