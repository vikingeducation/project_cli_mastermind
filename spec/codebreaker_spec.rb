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
			expect{codebreaker.render}.to output("||_______________|| E C\n").to_stdout
		end

		it "displays partial board" do
			codebreaker = Codebreaker.new
			codebreaker.make_guess(['r','y','b','y'])
			codebreaker.make_pegs(['g','y','r','y'])

			codebreaker.make_guess(['r','r','r','r'])
			codebreaker.make_pegs(['g','y','r','y'])
			expect{codebreaker.render}.to output("|| r , r , r , r || 1 0\n|| r , y , b , y || 2 1\n||_______________|| E C\n").to_stdout
		end
	end

	describe '#make_guess' do
		it "adds 1 guess to guess board" do
			guess_arr = ['r','r','r','r']
			codebreaker = Codebreaker.new
			codebreaker.make_guess(guess_arr)
			expect(codebreaker.guesses_board).to eq([guess_arr])
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

	describe '#make_pegs' do
		it "returns an array of exact & close pegs" do
			codebreaker = Codebreaker.new
			codebreaker.make_guess(['r','y','b','y'])
			codebreaker.make_pegs(['g','y','r','y'])
			expect(codebreaker.pegs[-1]).to eq([2,1])
		end
	end
end
