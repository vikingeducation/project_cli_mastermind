module Mastermind
  module Players
    class Human < Player
      def make_code(board)
        board.add_secret_code(ask_for_pegs)
      end

      def guess(board)
        board.add_guess(ask_for_pegs)
      end

      def feedback(board)
        say "Please give your feedback!"
        board.add_feedback(ask_for_feedback)
      end

      def ask_for_pegs
        answer = ask("Place pegs like so (order matters): blue, magenta, green, yellow", lambda {|str| str.split(/,?\s+/)})
        answer.map(&:to_sym)
      end

      def ask_for_feedback
        answer = ask('Enter the peg colors (e.g. red white)')
        answer.split(/,?\s+/).map(&:to_sym)
      end

      private

      def set_name
        @name = ask "What's your name?"
      end
    end
  end
end
