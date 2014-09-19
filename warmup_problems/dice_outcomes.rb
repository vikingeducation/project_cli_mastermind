# def roll_dice dice=1 
# 	nums = Array.new(dice)
# 	nums.length.times do |x|
# 		nums[x] = (rand(6)+1)
# 	end
# 	return nums.reduce(:+)
# end

def dice_outcomes(dice=1, rolls=1)
	all_rolls = []
	possibles = (dice..(dice*6)).to_a
	record = Hash[possibles.map {|x| [x, 0]}] # look into why this works.

	rolls.times do
		dice_rolls = Array.new(dice){rand(6)+1}
		roll_sum = dice_rolls.reduce(:+)
		all_rolls << roll_sum
	end
	
	all_rolls.each do |roll|
		record[roll] += 1
	end

	record.each do |k,v|
		puts "#{k}: " + "#"*v + "\n"
	end
end



puts "number of dice?"
num = gets.chomp.to_i
puts "number of rolls?"
rolls = gets.chomp.to_i
dice_outcomes num, rolls

# counts = Hash.new 0

# words.each do |word|
#   counts[word] += 1
# end

# 1 to 6 for each die

# (1..6) * number of dice
# 1*number of dice to 6*number of dice





