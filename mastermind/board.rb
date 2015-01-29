class Board
	attr_accessor :board
	
	def initialize
		@board = Array.new(12){Array.new(4)}
	end

	def render
		@board.each do |row|
			row.each do |column|
				if column==nil
					print "-"
				else
					print(column.to_s)
				end
			end
			puts
		end
	end

	def give_feedback(fb)
		fb.each { |val| print fb}
		puts
	end

	def ntd(val) # ntd = nils to dash
		if val==nil
			print "-"
		else
			print val
		end
	end

	def rerender(counter, gh, fh, guess, feedback)
		@board = Array.new(12){Array.new(4)}
		j=1
		(12-gh.count).times do
			print "#{j}\t------\t------\t------\t------\n"
			j+=1
		end
		i=0
		(gh.count-1).times do
			print "#{j}\t#{ntd(gh[i])}\t#{ntd(fh[i])}\n"
			j+=1
			i+=1
		end
		print "#{j}\t"
		guess.each do |g|
			print "#{g[0].upcase}\t"
		end
		feedback.each do |f|
			print "#{f} "
		# print "#{j}\t#{guess}\t#{feedback}\n"
		end
		puts
	end
end