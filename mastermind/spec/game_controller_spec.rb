require 'spec_helper'

require_relative '../src/lib/app.rb'
require_relative '../src/game_controller.rb'
require_relative '../src/game_model.rb'

describe GameController do
	let(:router){Router.new(:controller => 'GameController', :model => 'GameModel')}
	let(:game_controller){GameController.new(:model => GameModel.new, :router => router)}
	let(:model){game_controller.model}

	after do
		Input.clear
	end

	describe '#select_role' do
		let(:role_codebreaker){Input.class_variable_set(:@@data, '1')}
		let(:role_codemaker){Input.class_variable_set(:@@data, '2')}
		let(:role_invalid){Input.class_variable_set(:@@data, 'asdf')}

		it 'sets model role to :codebreaker when user input is 1' do
			role_codebreaker
			game_controller.select_role
			expect(model.board.role).to eq(:codebreaker)
		end

		it 'sets model role to :codemaker when user input is 2' do
			role_codemaker
			game_controller.select_role
			expect(model.board.role).to eq(:codemaker)
		end

		it 'sets a notice when the model role is not set successfully' do
			role_invalid
			game_controller.select_role
			expect(Input.notice).to be_kind_of(String)
		end

		it 'sets the router action to play when role set is successful' do
			role_codebreaker
			game_controller.select_role
			expect(router.action).to eq(:play)
		end

		it 'sets the router action to menu when role set is insuccessful' do
			role_invalid
			game_controller.select_role
			expect(router.action).to eq(:menu)
		end
	end

	describe '#select_code' do
		let(:code_1234){Input.class_variable_set(:@@data, '1234')}
		let(:code_invalid){Input.class_variable_set(:@@data, 'asdf')}

		before do
			Input.class_variable_set(:@@data, '2')
			game_controller.select_role
		end

		it 'sets the model code' do
			code_1234
			game_controller.select_code
			expect(model.board.code.normalize).to eq('1234')
		end

		it 'sets a notice when the input is invalid' do
			code_invalid
			game_controller.select_code
			expect(model.board.code.normalize).to eq('')
		end

		it 'sets the next route action to play' do
			code_1234
			game_controller.select_code
			expect(router.action).to eq(:play)
		end
	end

	describe '#select_guess' do
		let(:guess_1234){Input.class_variable_set(:@@data, '1234')}
		let(:guess_invalid){Input.class_variable_set(:@@data, 'asdf')}
		let(:guess_1111){Input.class_variable_set(:@@data, '1111')}

		before do
			Input.class_variable_set(:@@data, '1')
			game_controller.select_role
		end

		it 'sets the model guess' do
			guess_1111
			game_controller.select_guess
			expect(model.board.resolved.first.normalize).to eq('1111')
		end

		it 'sets a notice when input is invalid' do
			guess_invalid
			game_controller.select_guess
			expect(Input.notice).to be_kind_of(String)
		end

		it 'sets the route to play if the game is not over' do
			guess_1111
			game_controller.select_guess
			expect(router.action).to eq(:play)
		end

		it 'sets the route to over when the game is over' do
			guess_1111
			12.times {game_controller.select_guess}
			expect(router.action).to eq(:over)
		end
	end
end


