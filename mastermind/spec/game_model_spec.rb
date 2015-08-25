require 'spec_helper'

require_relative '../src/lib/app.rb'
require_relative '../src/game_model.rb'

describe GameModel do
	let(:game_model){GameModel.new}

	describe '#initialize' do
		it 'returns an instance of the GameModel class' do
			expect(game_model).to be_an_instance_of(GameModel)
		end

		it 'initializes the board by calling clear' do
			expect(game_model.board).to be_an_instance_of(Board)
		end

		it 'initializes validation to an instance of GameValidation' do
			expect(game_model.validation).to be_an_instance_of(GameValidation)
		end
	end

	describe '#board' do
		it 'is an accessor' do
			expect do
				game_model.board
				game_model.board = Board.new
			end.to_not raise_error
		end
	end

	describe '#last_guess' do
		it 'is a reader' do
			expect {game_model.last_guess}.to_not raise_error
		end
	end

	describe '#clear' do
		it 'sets board equal to a new instance of the Board class' do
			expect(game_model.board).to be_an_instance_of(Board)
		end
	end

	describe '#clear_code' do
		it 'clears the code on the board object' do
			game_model.code = '1234'
			game_model.clear_code
			expect(game_model.board.code.normalize).to eq('')
		end
	end

	describe '#clear_guesses' do
		it 'clears the first unresolved row of the board class' do
			game_model.color = '1'
			game_model.clear_guesses
			expect(game_model.board.unresolved.first.normalize).to eq('')
		end
	end

	describe '#code=' do
		context 'the input passes validation' do
			it 'sets the value of the board code' do
				game_model.code = '1234'
				expect(game_model.board.code.normalize).to eq('1234')
			end
		end
	end

	describe '#role=' do
		context 'the input passes validation' do
			it 'sets the value of the board role' do
				game_model.role = '1'
				expect(game_model.board.role).to eq(:codebreaker)
			end
		end
	end

	describe '#color=' do
		context 'the input passes validation' do
			it 'appends a color to the code of the board' do
				game_model.color = '1'
				expect(game_model.board.code.normalize).to eq('1')
			end
		end
	end

	describe '#guess=' do
		context 'the input passes validation' do
			it 'appends a full row to the board' do
				game_model.guess = '1234'
				expect(game_model.board.resolved.first.normalize).to eq('1234')
			end
		end
	end

	describe '#to_s' do
		it 'returns a string' do
			expect(game_model.to_s).to be_kind_of(String)
		end
	end

	describe '#role?' do
		it 'returns true when a role is set on the board' do
			game_model.board.role = :codemaker
			expect(game_model.role?).to_not eq(true)
		end
	end

	describe '#code?' do
		it 'returns true when a code is set on the board' do
			game_model.code = '1234'
			expect(game_model.code?).to eq(true)
		end
	end

	describe '#guess?' do
		it 'returns true when the guess was resolved on the board' do
			game_model.guess = '1234'
			expect(game_model.guess?).to eq(true)
		end
	end

	describe '#win?' do
		it 'returns true if the player wins' do
			game_model.role = '1'
			game_model.code = '1234'
			game_model.guess = '1234'
			expect(game_model.win?).to eq(true)
		end
	end

	describe '#lose?' do
		it 'returns true if the player loses' do
			game_model.role = '1'
			game_model.code = '1234'
			game_model.guess = '1234'
			expect(game_model.win?).to eq(true)
		end
	end

	describe '#codebreaker?' do
		it 'returns true if the player is a codebreaker' do
			game_model.role = '1'
			expect(game_model.codebreaker?).to eq(true)
		end
	end

	describe '#codemaker?' do
		it 'returns true if the player is a codemaker' do
			game_model.role = '2'
			expect(game_model.codemaker?).to eq(true)
		end
	end
end

