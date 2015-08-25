require 'spec_helper'

require_relative '../src/ai.rb'

describe AI do

	describe '#color' do
		it 'returns a string digit that is always between 1 and 6' do
			100.times {expect(AI.color.to_i).to be_between(1, 6)}
		end
	end

	describe '#guess' do
		it 'returns a valid code string' do
			100.times do
				guess = AI.guess
				guess.chars.each do |c|
					expect(c.to_i).to be_between(1, 6)
				end
			end
		end
	end

	describe '#code' do
		it 'returns a valid code string' do
			100.times do
				code = AI.code
				code.chars.each do |c|
					expect(c.to_i).to be_between(1, 6)
				end
			end
		end
	end
end
