require_relative '../../tweet/tweet.rb'

describe Twitter do
	before do
		@twitter = Twitter.new
		@message = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sit iusto fugit dolor ipsa minima sapiente assumenda dolorum sunt obcaecati non consequatur deleniti laboriosam blanditiis laudantium, ea sequi! Nesciunt, aliquid, aliquam. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat quia animi debitis dolore ullam, deleniti mollitia eos, ad natus ratione quae temporibus iure veritatis cum rerum commodi illo iste maxime!"
	end

	it 'includes the Enumerable module' do
		included = Twitter.included_modules.include?(Enumerable)
		expect(included).to eq(true)
	end

	describe '#[]' do
		it 'provides access to tweets via array index syntax' do
			@twitter.tweet("Hello")
			expect(@twitter[0]).to eq("Hello")
		end
	end

	describe '#<<' do
		it 'appends a tweet to the tweet array via #tweet' do
			@twitter << "Hello"
			expect(@twitter.first).to eq("Hello")
		end
	end

	describe '#tweet' do
		it 'trims a tweeted message to 144 char max' do
			@twitter.tweet(@message)
			expect(@twitter.first.length).to eq(144)
		end

		it 'appends a message onto the tweet array' do
			expect(@twitter.each {}).to eq(0)
			@twitter.tweet(@message)
			expect(@twitter.each {}).to eq(1)
			expect(@message[0...144]).to eq(@twitter.first)
		end
	end

	describe '#each' do
		it 'iterates the tweets in a Twitter object' do
			@twitter.tweet("Hi")
			@twitter.tweet("Bye")
			tweets = @twitter.tweet("Hi again")
			results = []
			i = 0
			@twitter.each do |t|
				results << (t.object_id == tweets[i].object_id)
				i += 1
			end
			expect(results.include?(false)).to eq(false)
		end
	end
end