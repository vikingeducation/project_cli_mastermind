


class Twitter 

  include Enumerable


  def initialize
    @tweets = []

  end


  # Tweet only takes the first 140 characters
  def tweet(message)
    if message.length <= 144
      @tweets << message
    else
      @tweets << message.chars[0...144].join 
    end
  end


  def tweets
    @tweets
  end

  def each

  @tweets.length.times do |i|
    yield @tweets[i]
  end

  end

end





# small = "Small Tweet"

# big = "BigTWeetBigTWeetBigTWeetBigTWeetBigTWeeBigTWeetBigTWeetBigTWeetBigTWeeigTWeetBigTWeetBigTWeetBigTWeettBigTWeetBigTWeetBigTWeetBigTWeetBigTWeetBigTWeetBigTWeetBigTWeetBigTWeetBigTWeetBigTWeetBigTWeet"



# t = Twitter.new


# t.tweet(small)

# t.tweet(big)


# t.each{|big| puts big}

# p t.map{|small| small.upcase}

