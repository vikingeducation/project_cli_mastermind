module Mastermind
  class Game
    def initialize
      @board = Board.new
    end

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
      Formatador.display_line "Game over! #{winner.name} won! secret #{@board.secret_code}" if over?

      Formatador.display_table(@board.data)
    end

    def winner
      @board.code_cracked? ? @codebreaker : @codemaker
    end

    def over?
      @board.full? || @board.code_cracked?
    end

    def play
      say "Welcome to Mastermind!!!"
      set_players_roles
      codemaker_make_code

      play_round until over?
    end
  end
end
