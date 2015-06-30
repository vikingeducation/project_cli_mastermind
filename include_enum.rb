class Twitter
include Enumerable
	def initialize
		@tweets = []
	end

	def tweet(message)
		@tweets << message.slice(0,144)
	end

	def each
		count = 0
		while count < @tweets.length
		 	yield(@tweets[count])  # yield (@tweets[count]) will not work as there is an extra space its either yield() or yield @tweets...
		 	count += 1
		end
	end
end