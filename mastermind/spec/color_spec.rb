require 'spec_helper'

require_relative '../src/color.rb'

describe Paint do
	describe '#color' do
		it 'returns a string' do
			expect(Paint.color(1)).to be_kind_of(String)
		end
	end
end

describe Proximity do
	let(:proximity){Proximity.new}
	let(:proximity_exact){Proximity.new(:type => :exact)}
	let(:proximity_close){Proximity.new(:type => :close)}
	let(:proximity_wrong){Proximity.new(:type => :wrong)}

	describe '#initialize' do
		it 'returns an instance of the Proximity class' do
			expect(proximity).to be_kind_of(Proximity)
		end

		it 'allows type to be set via options' do
			expect {proximity_exact}.to_not raise_error
		end
	end

	describe '#type' do
		it 'is an accessor' do
			expect do
				proximity.type
				proximity.type = :wrong
			end.to_not raise_error
		end
	end

	describe '#==' do
		it 'compares one proximity to another by the type' do
			expect(Proximity.new(:type => :exact)).to eq(:exact)
		end
	end

	describe '#to_s' do
		it 'returns a string' do
			expect(proximity.to_s).to be_kind_of(String)
		end
	end

	describe '#<=>' do
		it 'returns 0 if the types are the same' do
			expect(proximity_exact <=> proximity_exact).to eq(0)
		end

		context 'the proximities are not the same' do
			it 'returns -1 if the type is exact' do
				expect(proximity_exact <=> proximity_wrong).to eq(-1)
			end

			it 'returns -1 if the type is close and the other is wrong' do
				expect(proximity_close <=> proximity_wrong).to eq(-1)
			end

			it 'returns 1 if the type is close and the other is exact' do
				expect(proximity_close <=> proximity_exact).to eq(1)
			end

			it 'returns 1 if the type is wrong' do
				expect(proximity_wrong <=> proximity_exact).to eq(1)
			end
		end
	end
end

describe Color do
	let(:color){Color.new}
	let(:color_number){Color.new(:number => 1)}
	let(:color_position){Color.new(:position => 1)}

	describe '#initialize' do
		it 'returns an instance of the Color class' do
			expect(color).to be_kind_of(Color)
		end

		it 'allows setting the number via options' do
			expect do
				color_number
			end.to_not raise_error
		end

		it 'allows setting the positiong via options' do
			expect do
				color_position
			end.to_not raise_error
		end
	end

	describe '#position' do
		it 'is an accessor' do
			expect do
				color.position
				color.position = 0
			end.to_not raise_error
		end
	end

	describe '#number' do
		it 'is an accessor' do
			expect do
				color.number
				color.number = 0
			end.to_not raise_error
		end
	end

	describe '#==' do
		it 'compares the number of the color to another' do
			expect(Color.new(:number => 1)).to eq(color_number)
		end
	end

	describe '#to_s' do
		it 'returns a string' do
			expect(color.to_s).to be_kind_of(String)
		end
	end

	describe '#to_i' do
		it 'returns an integer' do
			expect(color_number.to_i).to be_kind_of(Integer)
		end
	end
end

describe Guess do
	let(:guess){Guess.new}
	let(:guess_exact){g = Guess.new(:number => 1, :position => 0); g.proximity = :exact; g}
	let(:guess_close){g = Guess.new(:number => 1, :position => 0); g.proximity = :close; g}
	let(:guess_wrong){g = Guess.new(:number => 1, :position => 0); g.proximity = :wrong; g}

	describe '#initialize' do
		it 'returns an instance of the Guess class' do
			expect(guess).to be_kind_of(Guess)
		end

		it 'allows position to be set via options' do
			expect do
				guess.position
				guess.position = 1
			end.to_not raise_error
		end

		it 'allows number to be set via options' do
			expect do
				guess.number
				guess.number = 1
			end.to_not raise_error
		end
	end

	describe '#exact?' do
		it 'returns true if the proximity is exact' do
			expect(guess_exact.exact?).to eq(true)
		end
	end
	describe '#close?' do
		it 'returns true if the proximity is close' do
			expect(guess_close.close?).to eq(true)
		end
	end
	describe '#wrong?' do
		it 'returns true if the proximity is wrong' do
			expect(guess_wrong.wrong?).to eq(true)
		end
	end
end
