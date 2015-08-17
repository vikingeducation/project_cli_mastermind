class Input
	@@data = nil

	def self.data
		@@data
	end

	def self.data=(value)
		@@data = value
	end

	def self.prompt
		print "\n> "
		@@data = gets.chomp
	end

	def self.reset?
		['r', 'reset'].include?(@@data)
	end

	def self.quit?
		['q', 'quit', 'exit'].include?(@@data)
	end
end