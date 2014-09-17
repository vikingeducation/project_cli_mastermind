num_dice=1 #defaultnumber of dice

def roll_dice(num_dice)
	sum=0
	num_dice.times do
		number=rand(1..6)
		puts number
		sum+=number
	end
	puts "The total is #{sum}."
	return sum
end

def dice_outcomes(num_dice, num_rolls)
	#create hash of combos (num_dice up to num_dice*6)
	combo_hash={}
	(num_dice..num_dice*6).each do |num|
	#    combo_hash[num]=0
		combo_hash[num]=0
	end

	#roll dice and tally
	num_rolls.times do
		sum=roll_dice(num_dice)
		combo_hash[sum]+=1
	end

	combo_hash.each do |key, value|
		puts "#{key}: " + "#"*value
	end
end

dice_outcomes(3,100)