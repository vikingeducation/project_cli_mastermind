module Mastermind
  module Players
    class Computer < Player
      # make_code
      # break_code

      # make_Code takes a CodeRow object and places random colors

      def make_code(board)
        pegs = Board::ROW_SIZE.times.map { Board::COLORS.sample }
        board.add_secret_code(pegs)
      end

      def guess(board)
        # code here
      end

      def feedback(board)
        analyzer = GuessAnalyzer.new(board.secret_code, board.last_row[:guess])

        pegs = []
        analyzer.exact_matches_count.times { pegs << :red }
        analyzer.inexact_matches_count.times { pegs << :white }

        board.add_feedback(pegs)
      end

      private

      def set_name
        @name = %w(RX450 WA2056 QO3245 LK6464).sample
      end
    end
  end
end
