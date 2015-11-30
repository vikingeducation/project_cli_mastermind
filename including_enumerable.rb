=begin
  Warmup 3: Including Enumerable
=end
module Enumerable
  def each
    i = 0
    while i < self.size
      yield(self[i])
      i += 1
    end
    self
  end
end

class Twitter
  include Enumerable

  attr_reader :tweets

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

t = Twitter.new
t.tweet("first message")
t.tweet("second message")
t.tweets.each{|msg| puts msg}
print t.tweets.map{|msg| msg.upcase}