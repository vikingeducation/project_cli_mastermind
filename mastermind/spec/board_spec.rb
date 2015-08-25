require 'spec_helper'

require_relative '../src/board.rb'

describe Board do
	let(:board){Board.new}
	let(:board_debug){Board.new(:debug => true)}
	let(:board_codebreaker){Board.new(:role => :codebreaker)}
	let(:board_code){Board.new(:code => [1,2,3,4])}
	let(:code){Code.new(:colors => [1,2,3,4])}
	let(:numbers){[1,2,3,4]}

	describe '#initialize' do
		it 'returns a instance of the Board class' do
			expect(board).to be_an_instance_of(Board)
		end

		it 'allows and sets a role in the options' do
			expect(board_codebreaker.role).to eq(:codebreaker)
		end

		it 'allows and set debug in the options' do
			expect(board_debug.debug).to eq(true)
		end

		it 'allows and sets a code from the options' do
			expect(board_code.code).to eq(code)
		end

		it 'populates the instance with empty rows' do
			board.each do |r|
				expect(r.normalize).to eq('')
			end
		end
	end

	describe '#code' do
		it 'returns an instance of the Code class' do
			expect(board_code.code).to be_kind_of(Code)
		end

		it 'returns a Code instance with the value from initialization' do
			expect(board_code.code).to eq(code)
		end

		it 'allows the code to be set via an array' do
			board.code = code
			expect(board.code).to be_an_instance_of(Code)
		end

		it 'is readable and writable' do
			expect do
				board.code
				board.code = code
			end.to_not raise_error
		end
	end

	describe '#role' do
		it 'returns the role value set from initialization' do
			expect(board_codebreaker.role).to eq(:codebreaker)
		end

		it 'is readable and writable' do
			expect do
				board.role
				board.role = :codebreaker
			end.to_not raise_error
		end
	end

	describe '#debug' do
		it 'returns the value from initialization' do
			expect(board_debug.debug).to eq(true)
		end

		it 'is readable and writable' do
			expect do
				board.debug
				board.debug = false
			end.to_not raise_error
		end
	end

	describe '#rows' do
		it 'returns an array of all rows' do
			rows = board.rows
			rows.each do |r|
				expect(r).to be_kind_of(Row)
			end
		end
	end

	describe '#[]' do
		it 'returns an instance of the Row class' do
			expect(board[0]).to be_kind_of(Row)
		end
	end

	describe '#<<' do
		it 'appends a color value to the first available slot on the current row' do
			board << 1
			row = board[0]
			expect(row[0].number).to eq(1)
		end
	end

	describe '#to_s' do
		it 'returns a string suitable for output' do
			expect(board.to_s).to be_kind_of(String)
		end
	end

	describe '#resolve' do
		let(:results){board.resolve}
		let(:results_code){board_code.resolve}

		it 'returns a hash' do
			expect(results).to be_kind_of(Hash)
		end

		it 'returns a hash with an :exact key' do
			expect(results).to have_key(:exact)
		end

		it 'returns a hash with an :close key' do
			expect(results).to have_key(:close)
		end

		it 'returns a hash with an :wrong key' do
			expect(results).to have_key(:wrong)
		end

		context 'the guess has all wrong colors' do
			it 'returns a hash where the :wrong key is the only not empty' do
				4.times{board_code << 5}
				expect(results_code[:exact]).to be_empty
				expect(results_code[:close]).to be_empty
				expect(results_code[:wrong]).to_not be_empty
			end
		end

		context 'the guess has all exact colors' do
			it 'returns a hash where the :exact key is not empty' do
				numbers.each {|i| board_code << i}
				expect(results_code[:exact]).to_not be_empty
				expect(results_code[:close]).to be_empty
				expect(results_code[:wrong]).to be_empty
			end
		end
		context 'the guess has all close colors' do
			it 'returns a hash where the :close key is not empty' do
				[4,3,2,1].each {|i| board_code << i}
				expect(results_code[:exact]).to be_empty
				expect(results_code[:close]).to_not be_empty
				expect(results_code[:wrong]).to be_empty
			end
		end
		context 'the guess has mixed results' do
			it 'returns a hash with only the valid keys filled' do
				[1,3,4,5].each {|i| board_code << i}
				expect(results_code[:exact]).to_not be_empty
				expect(results_code[:close]).to_not be_empty
				expect(results_code[:wrong]).to_not be_empty
			end
		end
	end

	describe '#unresolved' do
		it 'returns an array of the unresolved rows' do
			board.unresolved.each do |r|
				expect(r.resolved?).to eq(false)
			end
		end
	end

	describe '#resolved' do
		it 'returns an array of the resolved rows' do
			numbers.each {|i| board_code << i}
			board_code.resolve
			board_code.resolved.each do |r|
				expect(r.resolved?).to eq(true)
			end
		end
	end

	describe '#code?' do
		it 'returns true when a code is set' do
			expect(board_code.code?).to eq(true)
		end

		it 'returns false when a code is not set' do
			expect(board.code?).to eq(false)
		end
	end

	describe '#code_cracked?' do
		it 'returns true when the code has been guessed correctly' do
			numbers.each {|i| board_code << i}
			board_code.resolve
			expect(board_code.code_cracked?).to eq(true)
		end

		it 'returns false if the code has not been guessed correctly' do
			numbers.reverse.each {|i| board_code << i}
			board_code.resolve
			expect(board_code.code_cracked?).to eq(false)
		end
	end

	describe '#without_guesses?' do
		it 'returns true when there are no unresolved rows and the code is not cracked' do
			12.times do
				numbers.reverse.each {|i| board_code << i}
				board_code.resolve
			end
			expect(board_code.without_guesses?).to eq(true)
		end
	end

	describe '#resolve_ready?' do
		it 'returns true if the current row is ready to be resolved' do
			numbers.each {|i| board_code << i}
			expect(board_code.resolve_ready?).to eq(true)
		end
	end
end
