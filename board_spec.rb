require './board.rb'

describe Board do
  before do
    @board = Board.new
  end

  context 'initialization' do
    it 'renders an empty board' do
      expected_output = [
        'Board | C S',
        '------+-----',
        *(Array.new(12) { ' #### | - -' }),
        ''
      ].join("\n")
      expect { @board.render }.to output(expected_output).to_stdout
    end
  end

  context 'guessing' do
    before do
      @board.make_code([5, 8, 4, 7])
    end

    it 'accepts a guess' do
      expected_output = [
        'Board | C S',
        '------+-----',
        *(Array.new(11) { ' #### | - -' }),
        ' 1236 | 0 0',
        ''
      ].join("\n")
      @board.guess([1, 2, 3, 6])
      expect { @board.render }.to output(expected_output).to_stdout
    end

    it 'accepts a repetitive guess' do
      expected_output = [
        'Board | C S',
        '------+-----',
        *(Array.new(11) { ' #### | - -' }),
        ' 5555 | 1 0',
        ''
      ].join("\n")
      @board.guess([5, 5, 5, 5])
      expect { @board.render }.to output(expected_output).to_stdout
    end

    it 'correctly shows a guess with no correct values' do
      expected_output = [
        'Board | C S',
        '------+-----',
        *(Array.new(11) { ' #### | - -' }),
        ' 1236 | 0 0',
        ''
      ].join("\n")
      @board.guess([1, 2, 3, 6])
      expect { @board.render }.to output(expected_output).to_stdout
    end

    it 'correctly shows a guess with all correct but in wrong places' do
      expected_output = [
        'Board | C S',
        '------+-----',
        *(Array.new(11) { ' #### | - -' }),
        ' 7485 | 0 4',
        ''
      ].join("\n")
      @board.guess([7, 4, 8, 5])
      expect { @board.render }.to output(expected_output).to_stdout
    end

    it 'correctly shows a guess will all correct in correct places' do
      expected_output = [
        'Board | C S',
        '------+-----',
        *(Array.new(11) { ' #### | - -' }),
        ' 5847 | 4 0',
        ''
      ].join("\n")
      @board.guess([5, 8, 4, 7])
      expect { @board.render }.to output(expected_output).to_stdout
    end

    it 'correctly shows a guess will some in correct places' do
      expected_output = [
        'Board | C S',
        '------+-----',
        *(Array.new(11) { ' #### | - -' }),
        ' 5874 | 2 2',
        ''
      ].join("\n")
      @board.guess([5, 8, 7, 4])
      expect { @board.render }.to output(expected_output).to_stdout
    end

    it 'accepts multiple guesses' do
      expected_output = [
        'Board | C S',
        '------+-----',
        *(Array.new(10) { ' #### | - -' }),
        ' 1234 | 0 1',
        ' 5847 | 4 0',
        ''
      ].join("\n")
      @board.guess([5, 8, 4, 7])
      @board.guess([1, 2, 3, 4])
      expect { @board.render }.to output(expected_output).to_stdout
    end
  end

  context 'game over conditions' do
    before do
      @board.make_code([5, 8, 4, 7])
    end

    it 'returns correctly that too many attempts have been had' do
      12.times { @board.guess([1, 2, 3, 4]) }
      expect(@board.no_attempts?).to be_truthy
    end

    it 'returns correctly when not enough attempts have been had' do
      11.times { @board.guess([1, 2, 3, 4]) }
      expect(@board.no_attempts?).to be_falsey
    end

    it 'when given the correct code, gives victory condition' do
      @board.guess([5, 8, 4, 7])
      expect(@board.check_victory?).to be_truthy
    end

    it 'when given the incorrect code, gives the no-victory condition' do
      @board.guess([1, 2, 3, 4])
      expect(@board.check_victory?).to be_falsey
    end
  end
end
