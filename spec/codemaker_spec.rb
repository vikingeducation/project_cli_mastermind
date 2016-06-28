require_relative "../lib/codemaker.rb"

describe Codemaker do
	it "is a Codemaker" do
		expect(subject).to be_a(Codemaker)
	end

	it 'accepts a code upon creation' do
		expect(Codemaker.new(['red','blue','yellow','orange']))to be_valid
	end

	it 'accepts no parameters upon creation' do
		expect(Codemaker.new()).to be_valid
	end
end