# board has ROWS for data pegs
  # each ROW has an attached row for key pegs

# public methods
  # #last returns the last row of the table
  # # place_code_peg which takes an color and a position
module Mastermind
  class Board
    COLORS = [:blue, :magenta, :green, :yellow].freeze
    ROW_SIZE = 4
    ROUNDS = 12

    attr_reader :secret_code, :data

    def initialize
      @data = []
    end

    def add_guess(array)
      @data << {guess: array}
    end

    def add_secret_code(array)
      @secret_code = array
    end

    def add_feedback(array)
      last_row[:feedback] = array
    end

    def code_cracked?
      return false unless last_row && last_row[:feedback]
      last_row[:feedback].size == ROW_SIZE && last_row[:feedback].all? { |peg| peg == :red }
    end

    def full?
      @data.size == ROUNDS && last_row[:guess]
    end

    def last_row
      data.last
    end
  end
end
