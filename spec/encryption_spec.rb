require 'spec_helper'
require './encryption'


describe " encryption instance" do

	it "sets the user input phrase to input phrase variable" do
		test_phrase = "I am a words"
		input_phrase = Encryption.new(test_phrase)
		expect(input_phrase.phrase).to eq("I am a words")
	end

	it "sets phrase to and empty string if no phrase give" do
		no_phrase = Encryption.new()
		expect(no_phrase.phrase).to eq("")
	end

end
