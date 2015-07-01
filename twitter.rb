class Twitter

  include Enumerable

  def each
    index = 0
    while index < @tweets.length
      yield(@tweets[index])
      index += 1
    end
    @tweets
  end


  def initialize
    @tweets = []
  end


  def tweet(message)
    @tweets << message[0..143]
  end

end


t = Twitter.new
t.tweet("first message")
t.tweet("second message")

t.each{|msg| puts msg}

p t.map{|msg| msg.upcase}