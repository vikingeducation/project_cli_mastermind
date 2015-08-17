require_relative 'lib/app.rb'
require_relative 'game_controller.rb'
require_relative 'game_model.rb'

class Mastermind < App
	def initialize
		super(
			:controller => 'GameController',
			:model => 'GameModel',
			:views => 'views',
			:action => :menu
		)
	end
end