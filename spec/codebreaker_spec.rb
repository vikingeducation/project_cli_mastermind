require_relative "../lib/codebreaker.rb"

describe Codebreaker do
	it "is a Codemaker" do
		expect(subject).to be_a(Codebreaker)
	end

	it 'accepts a user name upon creation' do
		expect{Codebreaker.new("Conor")}.not_to raise_error
	end

	it 'accepts no parameters upon creation' do
		expect{Codebreaker.new()}.not_to raise_error
	end
end