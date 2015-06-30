class Twitter
    #include Enumerable

    def initialize
        @tweets = []
    end

    def tweet(message)
        # fill this in. it should add the first 144 characters
        # of any message to the @tweets array
        @tweets<<message[0..144]
    end

    def each
      i=0
      while i < @tweets.length
      yield(@tweets[i])
      i+=1
      end
      @tweets
    end


    # def map
    #   arr=[]
    #   i=0
    #   while i < @tweets.length
    #     arr << yield(self[i])
    #   end
    #   arr
    # end
end



t = Twitter.new
t.tweet("first message")
t.tweet("second message")
