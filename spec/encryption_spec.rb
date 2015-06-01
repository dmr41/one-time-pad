require 'spec_helper'
require './encryption'


describe "encryption initialization" do

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

describe "phrase content analysis" do

	it "tests if phrase is a string" do
		test_phrase = "I am a words"
		input_phrase = Encryption.new(test_phrase)
		expect(input_phrase.phrase).to eq("I am a words")
	end

	it "sets phrase to empty string if it is an Array or Number" do
		test_phrase = ["I am a words", "so am I"]
		input_phrase = Encryption.new(test_phrase)
		expect(input_phrase.phrase).to eq("")

		test_phrase = 23423
		input_phrase = Encryption.new(test_phrase)
		expect(input_phrase.phrase).to eq("")
	end

	it "sets phrase to empty string any letters are not between A and Z" do
		test_phrase = "I am words ! am N0t word5"
		input_phrase = Encryption.new(test_phrase)
		expect(input_phrase.phrase).to eq("")

	end

end
