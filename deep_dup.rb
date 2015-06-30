=begin
1. start with duplicating 2 dimensional array
2. loop through each dimension / object at that dimension subsequently to duplicate it
=end


class Array
	def deep_dup
		result = []
		self.each do |item|
			if item.is_a?(Array)
				result << item.deep_dup    #Recursively calling deep_dup to get into subarrays
			else
				result << item   #Fixnum has a static reference and doesn't need to be duplicated, as changing a number changes the reference as well
			end
		end
		return result
	end
end