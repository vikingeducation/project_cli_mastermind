# Rolling Dice

def roll_dice(n=1)
	 Array.new(n) { rand(7) }.reduce(&:+)
end

p roll_dice(3)

# Rolling Dice Outcomes

def dice_outcomes(dice, rolls)
	results = Hash.new(0)
	rolls.times do
		results[roll_dice(dice)] += 1
	end
	
	keys = results.keys.sort

	keys.each do |key|
		puts "#{key} #{"#" * results[key]}"
	end
end

dice_outcomes(3, 100)

# Fibonacci

def fibonacci(arg)
	return [1] if arg == 1
	return [1, 1] if arg == 2
	
	fib_array = [1, 1]

	until fib_array.size == arg
		fib_array.push(fib_array[-2] + fib_array[-1])
	end
	
	fib_array
end

p fibonacci(7)

# Stock Picker

def stock_picker(stock_prices)
  buy_day = 0
  sell_day = 0
  max_profit = 0 

  stock_prices.each_with_index do |buy, i|
    stock_prices[i+1..-1].each_with_index do |sell, j|
      if(sell - buy > max_profit)
        max_profit = sell - buy
        buy_day = i
        sell_day = j+i+1 # inner array indices start at i+1 of the original array
      end
    end
  end
  puts "[#{buy_day}, #{sell_day}]"
end

p stock_picker([44, 30, 24, 32, 35, 30, 40, 38, 15])

# Anagram Testing

def anagrams(word)
	scrabble_words = File.readlines("TWL06.txt")
	stripped_words = scrabble_words.map { |w| w.strip }

	letters = word.upcase.split('')
	
	anagrams = []

	stripped_words.each do |word|
		scrab_letters = word.split('')
		if letters.sort == scrab_letters.sort
			anagrams << word
		end
	end

	anagrams

end

p anagrams("looter")

