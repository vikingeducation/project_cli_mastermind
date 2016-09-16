# The Board class is responsible for maintaining the board state of the
# Mastermind game.
class Board
  MAX_ATTEMPTS = 12
  attr_reader :code

  def initialize
    @board = Array.new(MAX_ATTEMPTS) { Row.new }
    @attempts = 0
    @code = nil
  end

  def render
    puts 'Board | C S'
    puts '------+-----'
    @board.reverse.each(&:render)
  end

  def guess(attempt)
    current_row.update_information(attempt)
    current_row.check_guess(@code)
    @attempts += 1
  end

  def no_attempts?
    @attempts >= 12
  end

  def make_code(code)
    @code ||= code
  end

  def check_victory?
    @board[@attempts - 1].check_row?(@code)
  end

  private

  def current_row
    @board[@attempts]
  end

  # Class Row is responsible for handing the individual rows of the board
  class Row
    def initialize
      @data = [nil, nil, nil, nil]
      @correct = 0
      @semi = 0
      @set = false
    end

    def render
      if @set
        puts data_str
      else
        puts ' #### | - -'
      end
    end

    def data_str
      str = ' '
      4.times { |times| str << @data[times].to_s }
      str << " | #{@correct} #{@semi}"
    end

    def update_information(attempt)
      @data = attempt
      @set = true
    end

    def check_guess(code)
      tempc = code.clone
      tempd = @data.clone
      count_complete!(tempc, tempd)
      count_semi!(tempc, tempd)
    end

    def count_complete!(code, data)
      4.times do |index|
        next unless data[index] == code[index] && code[index] != '#'
        @correct += 1
        code[index] = '#'
        data[index] = '#'
      end
    end

    def count_semi!(code, data)
      4.times do |index|
        next unless data.include?(code[index]) && code[index] != '#'
        @semi += 1
        data[data.index(code[index])] = '#'
        code[index] = '#'
      end
    end

    def check_row?(code)
      @data == code
    end
  end
end
