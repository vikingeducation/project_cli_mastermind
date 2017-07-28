module Mastermind
  module Players
    class Computer < Player
      def make_code(board)
        pegs = Board::ROW_SIZE.times.map { Board::COLORS.sample }
        board.add_secret_code(pegs)
      end

      def guess(board)
        @ai ||= AIGuesser.new
        board.add_guess(@ai.guess(board.last_row))
      end

      def feedback(board)
        analyzer = GuessAnalyzer.new(board.secret_code, board.last_row[:guess])
        board.add_feedback(analyzer.feedback)
      end

      private

      def set_name
        @name = %w(RX450 WA2056 QO3245 LK6464).sample
      end
    end
  end
end
