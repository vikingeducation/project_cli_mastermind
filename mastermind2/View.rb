require 'pry'

class Board

	def self.render_board( m_mind ) #BOARD

		string = create_string( m_mind )

			string.each do |x|

			print x.split('')[0..3].join

			print "  Hint: #{x.split('')[4..(x.length-1)].join}"

			puts ""

		end

	end



	def self.create_string( m_mind )

		arr = []

		m_mind.board.each { | k, v | arr << v.join }

		return arr

	end



	def self.message( message )

		puts ""
		puts message
		puts ""

	end







end