load 'configuration.rb'

class Code
  include Configuration
  attr_reader :code

  def initialize(string)
    @code = string.split(//)
  end

  def last_letter
    (64 + NUMBER_OF_POSSIBLE_LETTERS).chr
  end

  def code_length
    CODE_LENGTH
  end

  def to_s
    code.join('')
  end
end

class ManualCode < Code
  def initialize
    puts "Enter a #{code_length}-character code using the letters A through #{last_letter}."
    puts "Duplicates are not allowed."
    string = gets.chomp.upcase
    @code = string.split(//)
  end
end

class RandomCode < Code
  def initialize
    code = []
    until code.length == code_length do
      letter = generate_random_letter
      unless code.include? letter
        code << letter
      end
    end
    @code = code
  end

  def generate_random_letter
    available_letters = ("A"..last_letter).to_a
    available_letters[ rand available_letters.count ]
  end
end