require_relative "../lib/game.rb"

describe Game do
=begin REDUNENT
  	it "is a Codemaker" do
		expect(subject).to be_a(Game)
	end
=end
	it 'accepts a no parameters' do
		expect{Game.new}.not_to raise_error
	end
end