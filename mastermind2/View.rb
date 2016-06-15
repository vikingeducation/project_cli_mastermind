require 'pry'

class Board

	def self.render( m_mind ) #BOARD


		string = create_string( m_mind )

			string.each do |x|


			print x.split('')[0..3].join

			print "  Hint: #{x.split('')[4..(x.length-1)].join}" unless x[4] == nil

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