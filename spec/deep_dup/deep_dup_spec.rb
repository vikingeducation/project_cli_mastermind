require_relative '../../deep_dup/deep_dup.rb'

describe Array do
	before do
		@array = [
			[1, 
				[2, 3]
			],
			[4, 5, 6],
			[
				[7, 8,
					[9, 10]
				],
				[11, 12]
			],
		]
	end

	describe '#deep_dup' do
		it 'duplicates an array recursively' do
			duplicated = @array.deep_dup
			expect(duplicated).to eq(@array)
		end

		it 'allocates new arrays instead of referencing' do
			duplicated = @array.deep_dup
			expect(duplicated[0].object_id).to_not eq(@array[0].object_id)
		end

		it 'duplicates an empty array' do
			duplicated = [].deep_dup
			expect(duplicated).to eq([])
		end
	end
end