require 'pry'

class Board



	# Game Board is displayed (BOARD)
	# 12 rows _ _ _ _
	def self.render_board( m_mind ) #BOARD
		# hash or array for rows { 1 => [ _, _, _,  _] ...}

		string = create_grid( m_mind )

		count = 0

		until string.length == count
			print string[ count ]
			count += 1
			puts "" if count % 4 == 0
		end


	end


	def self.create_grid( m_mind )

		arr = []
		m_mind.board.each { | k, v | arr << v.join }
		return arr.join

	end


	def self.render_hint ( hint ) #PLAYER
		# array  [R,R,R,R]
		count = 0
		Board.message(%q(Hint:))
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