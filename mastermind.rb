require './board.rb'
require './player.rb'
require './renderer.rb'
require './serializer.rb'

class Game

  def initialize
    @board = Board.new
    @renderer = Renderer.new(@board)
    @player1 = Human.new(1)
    @player2 = AI.new("COMPUTER")
    @players = [@player1, @player2]
  end

  def play

    start_play
    get_win_condition
    play_round

  end

  private

    def play_round
      until(game_won || game_lost)
        # Get a guess from the breaker player
        new_guess = breaker.play
        @board.accept_guess(new_guess)
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
        return true
      end
    end

    def game_won
      if @game_won
        puts "Player #{breaker.player_num} won!"
        return true
      end
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