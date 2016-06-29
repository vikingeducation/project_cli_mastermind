require_relative "../lib/codebreaker.rb"

describe Codebreaker do
	it "is a Codemaker" do
		expect(subject).to be_a(Codebreaker)
	end

	it 'accepts a user name upon creation' do
		expect{Codebreaker.new("Conor")}.not_to raise_error
	end

	it 'accepts no parameters upon creation' do
		expect{Codebreaker.new()}.not_to raise_error
	end

	describe '#render' do
		it "displays initial board" do
			codebreaker = Codebreaker.new
			expect{codebreaker.render}.to output("||_______________||\n").to_stdout
		end

		it "displays partial board" do
			codebreaker = Codebreaker.new
			codebreaker.make_guess(['r','r','r','r'])
			codebreaker.make_guess(['b','b','b','y'])
			expect{codebreaker.render}.to output("|| b , b , b , y ||\n|| r , r , r , r ||\n||_______________||\n").to_stdout
		end
	end

	describe '#make_guess' do
		it "adds 1 guess to guess board" do
			codebreaker = Codebreaker.new
			codebreaker.make_guess(['r','r','r','r'])
			expect(codebreaker.guesses_board).to eq([['r','r','r','r']])
		end

		it "adds multiple guesses to guess board" do
			codebreaker = Codebreaker.new
			codebreaker.make_guess(['r','r','r','r'])
			codebreaker.make_guess(['b','b','b','y'])
			expect(codebreaker.guesses_board).to eq([['r','r','r','r'],['b','b','b','y']])
		end
	end

	describe '#won' do
		it 'returns true if game is won' do
			codebreaker = Codebreaker.new
			codebreaker.make_guess(['r','r','r','r'])
			expect(codebreaker.won?(['r','r','r','r'])).to eq(true)
		end

		it 'returns false if game is not won' do
			codebreaker = Codebreaker.new
			codebreaker.make_guess(['r','r','r','r'])
			expect(codebreaker.won?(['r','r','r','b'])).to eq(false)
		end
	end
end
