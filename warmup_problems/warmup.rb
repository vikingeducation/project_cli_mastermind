num_dice=1
def roll_dice(num_dice)
	sum=0
	num_dice.times do
		number=rand(1..6)
		puts number
		sum+=number
	end
	puts "The total is #{sum}."
end

roll_dice(3)