class Board
	attr_accessor :board
	
	def initialize
		@board = Array.new(12){Array.new(4)}
	end

	def render
		@board.each do |row|
			row.each do |column|
				if column.nil?
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

	def rerender(counter, gh, fh)
		@board = Array.new(12){Array.new(4)}
		(12-gh.count).times do
			print "----\n"
		end
		i=0
		gh.count.times do
			print "#{ntd(gh[i])}\t#{ntd(fh[i])}"
			i+=1
		end
	end
end