# Your code here!
def roll_dice(input=1)
  roll_set = []
  input.times { roll_set << rand(1..6) }
  roll_set.reduce(:+)
end

def dice_outcomes(n, roll)


end

def fibonacci(n)
  initial = [1, 1]
  i = 0
  loop do
    initial[i+2] = initial[i] + initial[i+1]
    i += 1
    break if i > n
  end
  print initial
end

def stock_picker(arr)
  pairs = []
  profit = []
  arr.each_with_index do |buy, day|
    arr[day, arr.last.index].each do 
      |sell| if buy < sell
        pairs<< [buy, sell]
      end
    end
  end
  pairs.each {|pair| profit<<(pair[1] - pair[0])}
  return optimum = pairs[profit.max.index]
end