def anagrams(word)
	letters = word.upcase.split(//)
end

def check_file
	file = 'TWL06.txt'
	f = File.open(file, "r")
	f.each_line do |line|
		# puts line
	end
end

check_file
