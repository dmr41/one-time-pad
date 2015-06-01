require 'spec_helper'
require './encryption'


describe "encryption initialization" do

	it "sets the user input phrase to input phrase variable" do
		test_phrase = "I am a word"
		input_phrase = Encryption.new(test_phrase)
		expect(input_phrase.starting_phrase).to eq("IAMAWORD")
	end

	it "sets phrase to and empty string if no phrase give" do
		no_phrase = Encryption.new()
		expect(no_phrase.starting_phrase).to eq("")
	end

end

describe "phrase content analysis" do

	it "tests if phrase is a string" do
		test_phrase = "I am a word"
		input_phrase = Encryption.new(test_phrase)
		expect(input_phrase.starting_phrase).to eq("IAMAWORD")
	end

	it "sets phrase to empty string if it is an Array or Number" do
		test_phrase = ["I am a words", "so am I"]
		input_phrase = Encryption.new(test_phrase)
		expect(input_phrase.starting_phrase).to eq("")

		test_phrase = 23423
		input_phrase = Encryption.new(test_phrase)
		expect(input_phrase.starting_phrase).to eq("")
	end

	it "sets phrase to empty string if input contains non-A and Z characters" do
		test_phrase = "I am words ! am N0t word5"
		input_phrase = Encryption.new(test_phrase)
		expect(input_phrase.starting_phrase).to eq("")
	end

end

describe "making a random phrase" do

	it "randomizes input phrase" do
		test_phrase = "I am a word"
		input_phrase = Encryption.new(test_phrase)
		input_phrase.randomize_phrase
		#Check that letters have been added to one-time-phrase
		expect(input_phrase.one_time_phrase).not_to eq(nil)
		#Check that letters do NOT match original input string
		expect(input_phrase.one_time_phrase).not_to eq("IAMAWORD")
		#Check that length of original string equals length of one-time-phrase
		expect(input_phrase.one_time_phrase.length).to eq(input_phrase.starting_phrase.length)
	end

	it "null user input returns empty string" do
		test_phrase = "I am a word"
		input_phrase = Encryption.new()
		input_phrase.randomize_phrase
		expect(input_phrase.one_time_phrase).to eq("")
	end

end

describe "encryption of phrase with one-time-pad" do

	it "encrypted message not empty and different than input and one time pad" do
		test_phrase = "I am a word"
		input_phrase = Encryption.new(test_phrase)
		input_phrase.randomize_phrase
		input_phrase.encrypt_phrase
		expect(input_phrase.encrypted_message).not_to eq("")
		expect(input_phrase.encrypted_message).not_to eq(test_phrase)
		expect(input_phrase.encrypted_message).not_to eq(input_phrase.one_time_phrase)
		expect(input_phrase.encrypted_message.length).to eq(test_phrase.length)
	end

end
