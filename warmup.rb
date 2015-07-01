def deep_dup(array)

  dupe_arr = []

  array.each do |inner_arr|
    dupe_inner_arr = []
    dupe_inner_arr = inner_arr.dup
    dupe_arr.push(dupe_inner_arr)
  end

  dupe_arr
end

# arr = [ [1, [1,2], 3], [3,4]]
# p "#{arr[0].object_id}"
# dup_arr = deep_dup(arr)
# p " dupe: #{dup_arr[1][0].object_id}"

class Twitter 
  include Enumerable

  def initialize
    @tweets = []
  end

  def tweet(message)
    @tweets.push(message)

  end

  def each(proc = nil)
    @tweets.each do |tweet|
      if block_given?
        yield(tweet)
      else
        proc.call(tweet)
      end
    end
  end

end

# t = Twitter.new
# t.tweet("first message")
# t.tweet("second message")

# t.each{|msg| puts msg}

# p t.map{|msg| msg.upcase}











