class Twitter
  include Enumerable

  def initialize
    @tweets = []
  end

  def tweet(message)
    # fill this in. it should add the first 144 characters
    # of any message to the @tweets array
    @tweets << message[0, 144]
  end

  def each(&block)
    @tweets.each(&block)
  end
end