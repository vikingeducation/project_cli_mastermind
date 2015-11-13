require_relative '../lib/board.rb'

describe Board do

  let(:board){ Board.new }

  describe '#initialize' do

    it 'should give you a board' do
      expect(board).to be_a(Board)
    end

    it 'should have an empty array of guesses' do
      expect(board.guesses).to eq([])
    end

    it 'should have an empty array of feedbacks' do
      expect(board.feedbacks).to eq([])
    end
  end

end