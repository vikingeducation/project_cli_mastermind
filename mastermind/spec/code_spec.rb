require 'spec_helper'

require_relative '../src/code.rb'

describe Code do
	let(:code){Code.new}
	let(:code_1234){Code.new(:colors => [1,2,3,4])}
	let(:code_4321){Code.new(:colors => [4,3,2,1])}

	describe '#initialize' do
		it 'returns a new instance of the Code class' do
			expect(code).to be_kind_of(Code)
		end

		it 'allows :colors to be passed as an option' do
			expect{code_1234}.to_not raise_error
		end
	end

	describe '#clear' do
		it 'unsets all of the colors it the code' do
			code_1234.clear
			expect(code_1234[0].number).to be_nil
		end
	end

	describe '#==' do
		it 'returns true when the code is the same as the other' do
			expect(code_1234).to eq(Code.new(:colors => [1,2,3,4]))
		end

		it 'returns false when the code is different than the other' do
			expect(code_1234).to_not eq(code_4321)
		end
	end

	describe '#normalize' do
		it 'converts the code into a comparable string' do
			expect(code_1234.normalize).to eq('1234')
		end
	end

	describe '#[]' do
		it 'returns an instance of the Color class' do
			expect(code[0]).to be_kind_of(Color)
		end

		it 'returns the color at the index provided' do
			expect(code_1234[0].number).to eq(1)
		end
	end

	describe '#[]=' do
		it 'sets the color at the given index' do
			color = Color.new
			code[0] = color
			expect(code[0].object_id).to eq(color.object_id)
		end
	end

	describe '#<<' do
		it 'sets the number of the first unset color' do
			code << 1
			expect(code[0].number).to eq(1)
		end

		it 'does nothing if all colors in the array have number values' do
			[1,2,3,4,5,6,7,8,9].each {|i| code << i}
			expect(code[3].number).to eq(4)
		end
	end

	describe '#-' do
		it 'subtracts the given value from the colors array' do
			value = [code_1234[0], code_1234[1]]
			result = code_1234 - value
			expect(result).to eq([code_1234[2], code_1234[3]])
		end
	end

	describe '#dup' do
		it 'returns a new instance of the Code class with the same code' do
			expect(code_1234).to eq(code_1234.dup)
			expect(code_1234.object_id).to_not eq(code_1234.dup.object_id)
		end
	end

	describe '#colors' do
		it 'returns an array of colors' do
			code.colors.each do |c|
				expect(c).to be_kind_of(Color)
			end
		end
	end

	describe '#colors=' do
		it 'populates colors with Color instances from the given array' do
			code.colors = [1,1,1,1]
			expect(code.normalize).to eq('1111')
		end
	end

	describe '#each' do
		it 'iterates the colors array' do
			code_1234.each do |c|
				expect(c).to be_kind_of(Color)
			end
		end
	end

	describe '#to_s' do
		it 'returns a string' do
			expect(code.to_s).to be_kind_of(String)
		end
	end

	describe '#to_a' do
		it 'returns an array with integer values representing the number of each color' do
			expect(code_1234.to_a).to eq([1,2,3,4])
		end
	end
end

describe Row do
	let(:row){Row.new}
	let(:row_1234){Row.new(:colors => [1,2,3,4])}
	let(:row_4321){Row.new(:colors => [4,3,2,1])}
	let(:proximities){[:wrong, :wrong, :close, :exact]}
	let(:row_resolved) do
		r = Row.new(:colors => [1,2,3,4])
		r.each do |c|
			c.proximity = :exact
		end
		r
	end

	describe '#initialize' do
		it 'returns an instance of the Row class' do
			expect(row).to be_kind_of(Row)
		end

		it 'allows colors to be set in the options parameter' do
			expect do
				row_1234
			end.to_not raise_error
		end
	end

	describe '#colors=' do
		it 'populates colors with Guess instances with number values from the given array' do
			row.colors = [1,1,1,1]
			row.each do |c|
				expect(c).to be_kind_of(Guess)
				expect(c.number).to eq(1)
			end
		end
	end

	describe '#sort_by_proximity' do
		it 'sorts the colors in the row by their proximity values exact to wrong' do
			proximities.each_with_index do |p, i|
				row_1234[i].proximity = p
			end
			sorted = row_1234.sort_by_proximity
			proximities.reverse.each_with_index do |p, i|
				expect(row_1234[i].proximity.type).to eq(proximities[i])
			end
		end
	end

	describe '#to_s' do
		it 'returns a string' do
			expect(row.to_s).to be_kind_of(String)
		end
	end

	describe '#resolved?' do
		it 'returns true if the rows colors all have proximity values' do
			expect(row_resolved.resolved?).to eq(true)
		end

		it 'returns false if the rows colors do not all have proximity values' do
			expect(row.resolved?).to eq(false)
		end
	end

	describe '#unresolved?' do
		it 'returns false if the rows colors all have proximity values' do
			expect(row_resolved.unresolved?).to eq(false)
		end

		it 'returns true if the rows colors do not all have proximity values' do
			expect(row.unresolved?).to eq(true)
		end
	end
end
