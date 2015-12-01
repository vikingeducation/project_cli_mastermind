

class Twitter
  include Enumerable

  attr_reader :tweets

  def each
    i = 0
    while i < tweets.size
      yield(tweets[i])
      i += 1
    end
    self
  end

  def initialize
    @tweets = []
  end

  def tweet(message)
    new_message = []
    message.split('').each_with_index do |letter, index|
      if index < 144
        new_message << letter
      end
    end
    @tweets << new_message.join('')
  end
end

# THESE ARE DIFFERENT FROM THE EXAMPLES, NOT SURE IF IT CAN BE DONE OTHER WAY.

t = Twitter.new
t.tweet("first message")
t.tweet("second message")
t.each{|msg| puts msg}
print t.map{|msg| msg.upcase}