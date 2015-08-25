require 'spec_helper'

require_relative '../src/game_validation.rb'

describe GameValidation do
	let(:game_validation){GameValidation.new}

	describe '#valid_role?' do
		it 'returns true if the value is the string 1 or 2' do
			expect(game_validation.valid_role?('1')).to eq(true)
			expect(game_validation.valid_role?('2')).to eq(true)
		end

		it 'returns false if the value is not the string 1 or 2' do
			expect(game_validation.valid_role?('asdf')).to eq(false)
		end

		it 'sets an error message when validation fails' do
			game_validation.valid_role?('asdf')
			expect(game_validation.error).to be_kind_of(String)
		end
	end

	describe '#valid_color?' do
		it 'returns true if the value is between 1 and 6' do
			expect(game_validation.valid_color?('1')).to eq(true)
			expect(game_validation.valid_color?('2')).to eq(true)
			expect(game_validation.valid_color?('3')).to eq(true)
			expect(game_validation.valid_color?('4')).to eq(true)
			expect(game_validation.valid_color?('5')).to eq(true)
			expect(game_validation.valid_color?('6')).to eq(true)
		end

		it 'returns false if the value is not between 1 and 6' do
			expect(game_validation.valid_color?('asdf')).to eq(false)
		end

		it 'sets an error message when validation fails' do
			game_validation.valid_color?('asdf')
			expect(game_validation.error).to be_kind_of(String)
		end
	end

	describe '#valid_code?' do
		it 'returns true if the value is four digits each between 1 and 6' do
			expect(game_validation.valid_code?('1234')).to eq(true)
		end

		it 'returns false if the value is not four digits each between 1 and 6' do
			expect(game_validation.valid_code?('0123')).to eq(false)
		end

		it 'sets an error message when validation fails' do
			game_validation.valid_code?('asdf')
			expect(game_validation.error).to be_kind_of(String)
		end
	end
end