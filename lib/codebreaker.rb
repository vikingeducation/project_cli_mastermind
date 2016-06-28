require_relative './codecolor.rb'

class Codebreaker
	include Codecolor

	attr_reader :name

	def initialize(name="Player 1")
		@name = name
	end

end