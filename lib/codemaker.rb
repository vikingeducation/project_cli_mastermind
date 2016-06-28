require_relative './codecolor.rb'

class Codemaker
	include Codecolor

	attr_reader :code

	def initialize(code=[])
		if code.empty?
			@code = code
			generate_code
		else
			@code = code
		end
	end

	private

	def generate_code
		NUM_COLORS.times{ @code << COLORS.sample }
	end

end