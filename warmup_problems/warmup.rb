# Your code here!

# returns result of a random d6 roll. defaults to one die.
# roll_dice => 2
# roll_dice => 4
# roll_dice(3) => 15
# roll_dice(3) => 11

def roll_dice( dice = 1 )
  total = 0
  die = [ 1, 2, 3, 4, 5, 6 ]

  dice.times { total += die.sample }

  total
end


# returns a visual representation of the frequency results of
# rolling a specified number of dice a specified number of times.

# dice_outcomes(3, 128)
# 3:
# 4:###
# 5:####
# 6:##
# 7:####
# 8:#########
# 9:#################
# 10:#################
# 11:##################
# 12:######################
# 13:#########
# 14:#######
# 15:########
# 16:#####
# 17:#
# 18:##
# => nil

def dice_outcomes (dice, number_of_rolls)

  frequency = Hash.new(0)

  number_of_rolls.times do
    result = roll_dice(dice)
    frequency[result] += 1
  end

  (dice..dice * 6).each do |number|
    print "#{number}\:"
    puts "\#" * frequency[number]
  end

  nil
end

# returns an array of Fibonacci numbers of digits length
# fibonacci(1) => [1]
# fibonacci(2) => [1, 1]
# fibonacci(13) => [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233]

def fibonacci(digits)
  return 0 if digits < 1
  return [1] if digits == 1

  sequence = [1, 1]
  while sequence.length < digits
    sequence << sequence[-1] + sequence [-2]
  end

  sequence
end

# Given an array of stock prices on consecutive days,
# returns an array of the best days to buy and sell

# stock_picker([99, 3, 4, 45, 33, 43, 23, 80, 55, 66]) => [1, 7]

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


# Returns an array of the anagrams of a single-word string.
# anagrams("politics") => ["COLPITIS", "PSILOTIC"]
# anagrams("relief")  => ["FERLIE", "LIEFER", "REFILE"]

def anagrams(word)
  results = []
  dictionary = []

  file = File.readlines("TWL06.txt")
  file.each { |line| dictionary << line.strip }

  frequency = Hash.new(0)
  letters = word.upcase.split(//)
  letters.each { |letter| frequency[letter] += 1 }


  dictionary.each do |entry_word|
    next if word.strip.upcase == entry_word.strip
    next unless entry_word.length == word.length

    entry_letters = entry_word.strip.split(//)
    entry_frequency = Hash.new(0)
    entry_letters.each { |entry_letter| entry_frequency[entry_letter] +=1 }

    results << entry_word.chomp if entry_frequency == frequency

  end

  results
end