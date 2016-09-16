require './player.rb'

describe Player do
  context 'Human Player' do
    before do
      @human = Human.new
    end
    describe 'getting a code guess' do
      it 'accepts a guess' do
        allow(@human).to receive(:ask_input).and_return('1, 2, 3, 4')
        expect(@human.guess).to eq([1, 2, 3, 4])
        allow(@human).to receive(:ask_input).and_return('4, 3, 2, 1')
        expect(@human.guess).to eq([4, 3, 2, 1])
        allow(@human).to receive(:ask_input).and_return('7, 6, 5, 4')
        expect(@human.guess).to eq([7, 6, 5, 4])
        allow(@human).to receive(:ask_input).and_return('5, 6, 7, 8')
        expect(@human.guess).to eq([5, 6, 7, 8])
      end
    end
    describe 'getting a code to break' do
      it 'accepts a code' do
        allow(@human).to receive(:ask_input).and_return('1, 2, 3, 4')
        expect(@human.code).to eq([1, 2, 3, 4])
      end
    end
  end
  context 'Computer Player' do
    before do
      @computer = Computer.new
    end
    describe 'getting a code to break' do
      it 'gives a code to break' do
        code = @computer.code
        4.times { |i| expect(code[i]).to be_within(5).of(5) }
      end
    end
    describe 'giving a guess' do
      it 'gives a guess' do
        guess = @computer.guess
        4.times { |i| expect(guess[i]).to be_within(5).of(5) }
      end
    end
  end
end
