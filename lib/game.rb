module Mastermind
  class Game
    def initialize
      @board = Board.new
    end

    def play
      say "Welcome to Mastermind!!!"
      set_players_roles
      display_game_rules
      codemaker_make_code

      play_round until over?
    end

    private

    def set_players_roles
      human = Players::Human.new
      computer = Players::Computer.new

      answer = ask("What do you like to be? codebreaker(1) or codemaker(2)")

      if answer == '1'
        @codemaker, @codebreaker = computer, human

        say 'You are set as the codemaker'
      else
        @codemaker, @codebreaker = human, computer

        say 'You are set as the codebreaker'
      end
    end

    def codemaker_make_code
      @codemaker.make_code(@board)
    end

    def codebreaker_guess
      @codebreaker.guess(@board)
    end

    def codemaker_give_feedback
      @codemaker.feedback(@board)
    end

    def play_round
      codebreaker_guess
      display_board
      codemaker_give_feedback
      display_board
    end

    def display_board
      system 'clear'
      Formatador.display_line "secret: #{@board.secret_code}" if @codemaker.human? || over?
      Formatador.display_line "Game over! #{winner.name} won!" if over?

      Formatador.display_table(@board.data)
    end

    def winner
      @board.code_cracked? ? @codebreaker : @codemaker
    end

    def over?
      @board.full? || @board.code_cracked?
    end

    def display_game_rules
      sleep 0.3
      system 'clear'

      say <<~RULES
        Here is the game rules:
        1. Each row must and only have 4 pegs.
        2. You can use the folowing colors: #{Board::COLORS.join(', ')}.
        3. You may use a color more than once.
      RULES
    end
  end
end
