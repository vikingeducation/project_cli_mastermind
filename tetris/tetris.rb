# Your code here!

require 'yaml'
require 'io/wait' #nonblocking i/o

require './board.rb'
require './player.rb'
require './game.rb'



g = Game.new
g.start