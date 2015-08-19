require_relative 'code.rb'
require_relative 'ai.rb'

class Board
	ROWS = 12
	COLORS = 6

	include Enumerable

	attr_accessor :code, :role, :debug
	attr_reader :rows

	def initialize(options={})
		@debug = options[:debug]
		@role = options[:role]
		@rows = (1..ROWS).to_a.map {Row.new}
		self.code = options[:code]
	end

	def code=(value)
		@code = Code.new(:colors => value)
	end

	def each(proc=nil)
		@rows.each do |item|
			if block_given?
				yield(item)
			else
				proc.call(item)
			end
		end
	end

	def [](index)
		@rows[index]
	end

	def <<(value)
		row = unresolved.first
		if row
			row << value
		end
		row
	end

	def to_s
		rows = []
		each_with_index do |r, i|
			rows << "#{i + 1}. "
			rows << r.to_s
			rows << '-' * Row::WIDTH
		end
		rows << @code.to_s if show_code?
		rows.join("\n")
	end

	def resolve
		row = unresolved.first
		code_dup = @code.dup
		row_dup = row.dup
		exacts = exactness!(row_dup, code_dup)
		wrongs = wrongness!(row_dup, code_dup)
		wrongs -= exacts
		closes = closeness!(row_dup, code_dup)
		closes -= exacts
		results = {
			:exact => exacts,
			:close => closes,
			:wrong => wrongs
		}
		proximitize!(row, results)
		results
	end

	def unresolved
		select {|r| r.unresolved?}
	end

	def resolved
		select {|r| r.resolved?}
	end

	def exactness!(row, code)
		exacts = row.select do |c|
			exact = (c == code[c.position])
			if exact
				code[c.position] = nil
			end
			exact
		end
		row -= exacts
		exacts
	end

	def closeness!(row, code)
		closes = row.select do |row_color|
			included = code.include?(row_color)
			if included
				removed = false
				code = code.map do |code_color|
					if code_color == row_color && ! removed
						code_color = nil 
						removed = true
					else
						code_color
					end
				end
			end
			included
		end
	end

	def wrongness!(row, code)
		wrongs = row.select {|c| ! code.include?(c)}
		row -= wrongs
		wrongs
	end

	def proximitize!(row, results)
		results.each do |key, value|
			value.each do |color|
				row[color.position].proximity = key
			end
		end
		row = row.map {|c| c.proximity = :wrong unless c.proximity}
	end

	def code?
		@code.select {|c| c.number.nil?}.empty?
	end

	def code_cracked?
		row = resolved.last
		row ? @code == row : false
	end

	def without_guesses?
		unresolved.empty? && ! code_cracked?
	end

	def resolve_ready?
		row = unresolved.first
		row ? row.normalize.length == 4 && code? : false
	end

	private
		def show_code?
			return true if @debug
			if @role == :codebreaker
				return true if win? || lose?
			elsif @role == :codemaker
				return true
			end
			return false
		end
end