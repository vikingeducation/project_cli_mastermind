require 'pry'

class Board



	# Game Board is displayed (BOARD)
	# 12 rows _ _ _ _
	def self.render_board( m_mind ) #BOARD
		# hash or array for rows { 1 => [ _, _, _,  _] ...}

		string = create_grid( m_mind )

			string.each do |x|

			print x.split('')[0..3].join

			print "Hint: #{x.split('')[4..(string.length)].join}"

			puts ""

			binding.pry
		end


	end



	def self.create_grid( m_mind )

		arr = []
		m_mind.board.each { | k, v | arr << v.join }

		return arr

	end


	def self.render_hint ( hint ) #PLAYER
		# array  [R,R,R,R]
		count = 0
		print "Hint:"
		until hint.length == count
			print hint[ count ]
			count += 1
		end
		puts ""
	end


	def self.message( message )

		puts ""
		puts message
		puts ""

	end







end