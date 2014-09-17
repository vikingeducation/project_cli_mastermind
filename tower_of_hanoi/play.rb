require './player.rb'
require './board.rb'
require './hanoi.rb'

puts "###################################################"
puts "Welcome to the Tower of Hanoi!"
puts "There is a story about an Indian temple\
 in Kashi Vishwanath which contains a large room\
 with three time-worn posts in it surrounded by 64 golden disks.\
 Brahmin priests, acting out the command of an ancient prophecy,\
 have been moving these disks, in accordance with the\
 immutable rules of the Brahma, since that time.\
 According to the legend, when the last move \
 of the puzzle is completed, the world will end."
puts "\nWill YOU be the one to make the world end? Let's find out!"
puts "\n(At any time you may press 'q' to quit)"
puts "###################################################"
puts "\nChoose the tower height:"
height=gets.chomp.to_i
h=Hanoi.new(height)
h.play