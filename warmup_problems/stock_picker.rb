def stock_picker(stocks=[])
	count = 0
	pick = []
	stocks.each do |first_number|
		stocks.each do |other_number| 
			if (other_number - first_number) > count && stocks.index(other_number) > stocks.index(first_number)
				count = other_number - first_number
				pick = [stocks.index(first_number), stocks.index(other_number)]
			end
		end
	end
	puts count
	print "#{pick}"
end

puts "What are the stocks that you want to check?"
ticker = gets.chomp
ticker = ticker.split(',')
ticker.map! do |num|
	num.to_i
end
print stock_picker(ticker)

# 44, 30, 24, 32, 35, 30, 40, 38, 15
