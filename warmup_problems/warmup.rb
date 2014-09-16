# Your code here!

#returns result of a random d6 dice roll with a specified 
#number of dice. defaults to 1.
def roll_dice( dice = 1 )
  total = 0
  die = [ 1, 2, 3, 4, 5, 6 ]

  dice.times { total += die.sample }

  total
end

def dice_outcomes (dice, rolls)

  frequency = Hash.new(0)

  rolls.times do
    result = roll_dice(dice)
    frequency[result] += 1
  end

  (1..18).each do |number|
    print "#{number}\:"
    puts "\#" * frequency[number]
  end

end

def fibonacci(digits)
  return 0 if digits < 1
  return [1] if digits == 1

  sequence = [1, 1]
  while sequence.length < digits
    sequence << sequence[-1] + sequence [-2]
  end

  sequence
end

def stock_picker(prices)

  buy_day, sell_day = nil, nil

  max_return = 0

    prices.each_with_index do |price_a, day_a|
      prices.each_with_index do |price_b, day_b|
        current_return = price_b - price_a

        if day_b > day_a && current_return > max_return
          max_return = current_return
          buy_day, sell_day = day_a, day_b
        end

      end
    end

  [buy_day, sell_day]
end



#NOT WORKING YET
def anagrams(word)
  results = []

  dictionary = File.readlines("TWL06.txt") #load scrabble dictionary

  letters = word.upcase.split

  frequency = Hash.new(0)
  letters.each { |letter| frequency[letter] += 1 }

  dictionary.each do |test_word|
    test_letters = test_word.split
    test_frequency = Hash.new(0)
    test_letters.each { |test_letter| test_frequency[test_letter] +=1 }

    results << test_word.chomp if test_frequency.values == frequency.values
  end

  results
end