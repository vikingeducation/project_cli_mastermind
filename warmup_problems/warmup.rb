
class Dice

  def self.throw(quantity=1, sides=6)
    total = 0
    quantity.times { total += rand(sides)+1 }
    total
  end

  def self.outcomes(iterations, quantity=1, sides=6)
    outcomes = {}

    # Create a hash with keys for every possible total
    (quantity..quantity*sides).to_a.each do |outcome|
      outcomes[outcome] = 0 # All values start at 0
    end

    # throw the dice, total values, and add to key-value pair
    iterations.times do
      outcomes[Dice.throw(quantity, sides)] += 1
    end

    outcomes
  end

end


def fibonacci_sequence(sequence_place)
  sequence = [1, 1] # starts with two places for simplicity

  if sequence_place > 2
    (sequence_place-2).times do
      sequence << sequence[-1] + sequence[-2]
    end
  elsif sequence_place == 1 # in case they only want the first value
    sequence = [1]
  end

  sequence # return the sequence as an array
end

def nth_fibonacci(n) # separate method returns the nth value
  fibonacci_sequence(n).last
end


def stock_picker(stock_prices)
  max_gain = 0 # variable for comparing outcomes
  ideal_trade_days = [] # array holds local maximum

  stock_prices.each_with_index do |price, buy_date|
    sell_date = buy_date

    while sell_date < stock_prices.length
      if stock_prices[sell_date] - price > max_gain
        max_gain = stock_prices[sell_date] - price
        ideal_trade_days = [buy_date, sell_date] # overwrites if a better pair is found
      end
      sell_date += 1
    end
  end

  ideal_trade_days
end
