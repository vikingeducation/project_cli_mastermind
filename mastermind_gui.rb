class Gui
  def self.welcome(player_1, player_2)
    puts "Welcome to Mastermind #{player_1}!!" if player_2 == 'CPU'
    puts "Welcome to Mastermind #{player_2}!!" if player_1 == 'CPU'
  end

  def self.breaker_or_maker
    puts 'Do you want to be the codebreak or codemaker?'
    puts '1. Codebreaker'
    puts '2. Codemaker'
    game_type = gets.chomp
    return game_type.to_i
  end

  def self.player_created_code
    puts "Please enter a code for the CPU to break"
  end

  def self.game_over(correct_guess)
    puts 'You lost the game!'
    puts 'Here was the answer: '
    puts correct_guess
  end

  def self.good_game(correct_guess)
    puts 'You got the correct answer!'
    puts 'Here was the answer: '
    puts correct_guess
  end

  def self.get_player
    puts 'Please enter your name'
    print '> '
    player_name = gets.chomp
    player_name
  end

  def self.print_assist(assist, turn)
    print "\t W: #{assist[turn][0]}, B: #{assist[turn][1]}"
  end

  def self.make_chocie
    puts 'Please enter your choice'
    puts 'Choose from B, G, O, P, R, Y:'
    print '> '
    player_choice = gets.chomp.upcase.gsub(/\W+/, '')
    player_choice.split('').map!(&:strip)
  end

  def self.redo_selection
    puts 'It looks like you peg input is invalid'
    puts 'Please enter only 4 options from the list'
    puts 'Please try again'
  end

  def self.turn_display(turn)
    puts "Turn #:#{turn}"
  end
end
