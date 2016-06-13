require 'pry'

class Board



	# Game Board is displayed (BOARD)
	# 12 rows _ _ _ _
	def self.render_board( m_mind ) #BOARD
		# hash or array for rows { 1 => [ _, _, _,  _] ...}
		m_mind.board.each do |x|
			print x
		end
	end

	def self.create_grid( m_mind )



	end

	def self.render_hint ( m_mind ) #PLAYER
		# array  [R,R,R,R]


	end


	def self.message( message )

		puts ""
		puts message
		puts ""

	end







end