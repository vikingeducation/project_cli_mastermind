require_relative './codecolor.rb'

class Codemaker
	include Codecolor

	attr_reader :code

	def initialize(code=[])
		@code = code
		generate_code if code.empty?

	end

	private
	def generate_code
		NUM_COLORS.times{ @code << COLORS.sample }
	end

end