class Twitter
	include Enumerable

	def initialize
		@tweets = []
	end

	def [](index)
		@tweets[index]
	end

	def <<(message)
		tweet(message)
	end

	def tweet(message)
		@tweets << message[0...144]
	end

	def each(proc=nil)
		@tweets.length.times do |i|
			item = @tweets[i]
			if block_given?
				yield(item)
			else
				proc.call(item)
			end
		end
	end
end