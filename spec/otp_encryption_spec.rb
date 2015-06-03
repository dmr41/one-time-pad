require 'spec_helper'
require './otp_encryption'

describe "words in input gets put in array" do

	describe "encryption initialization" do

		it "sets the user input phrase to input phrase variable" do
			test_phrase = "I am a word"
			input_phrase = OneTimePad.new(test_phrase)
			expect(input_phrase.starting_phrase).to eq("I am a word")
		end

		it "sets phrase to and empty string if no phrase give" do
			no_phrase = OneTimePad.new()
			expect(no_phrase.starting_phrase).to eq("")
		end

	end

	describe "phrase content analysis" do

		it "tests if phrase is a string" do
			test_phrase = "I am a word"
			input_phrase = OneTimePad.new(test_phrase)
			expect(input_phrase.starting_phrase).to eq("I am a word")
		end

		it "sets phrase to empty string if it is an Array or Number" do
			test_phrase = ["I am a words", "so am I"]
			input_phrase = OneTimePad.new(test_phrase)
			expect(input_phrase.starting_phrase).to eq("")

			test_phrase = 23423
			input_phrase = OneTimePad.new(test_phrase)
			expect(input_phrase.starting_phrase).to eq("")
		end

		it "sets phrase to empty string if input contains non-A and Z characters" do
			test_phrase = "I am words am N0t word5"
			input_phrase = OneTimePad.new(test_phrase)
			expect(input_phrase.starting_phrase).to eq("I am words am N0t word5")
		end

	end

	describe "making a random phrase" do

		it "randomizes input phrase" do
			test_phrase = "I am a word"
			input_phrase = OneTimePad.new(test_phrase)
			input_phrase.randomize_phrase
			#Check that letters have been added to one-time-phrase
			expect(input_phrase.one_time_phrase).not_to eq(nil)
			#Check that letters do NOT match original input string
			expect(input_phrase.one_time_phrase).not_to eq("I am a word")
			#Check that length of original string equals length of one-time-phrase
			expect(input_phrase.one_time_phrase.length).to eq(input_phrase.starting_phrase.length)
		end

		it "null user input returns empty string" do
			test_phrase = "I am a word"
			input_phrase = OneTimePad.new()
			input_phrase.randomize_phrase
			expect(input_phrase.one_time_phrase).to eq("")
		end

	end

	describe "encryption of phrase with one-time-pad" do

		it "encrypted message not empty and different than input and one time pad" do
			test_phrase = "I am a word"
			input_phrase = OneTimePad.new(test_phrase)
			input_phrase.randomize_phrase
			input_phrase.encrypt_phrase
			expect(input_phrase.encrypted_message).not_to eq("")
			expect(input_phrase.encrypted_message).not_to eq(test_phrase)
			expect(input_phrase.encrypted_message).not_to eq(input_phrase.one_time_phrase)
			expect(input_phrase.encrypted_message.length).to eq(test_phrase.length)
		end

		it "handles empty input" do
			input_phrase = OneTimePad.new()
			input_phrase.randomize_phrase
			input_phrase.encrypt_phrase
			expect(input_phrase.encrypted_message).to eq("")
		end

	end

	describe "decryption" do

		it "converts encryption to decyrpted message with one-time pad" do
			input_message = "decryptionworked"
			input_phrase = OneTimePad.new(input_message)
			input_phrase.randomize_phrase
			input_phrase.encrypt_phrase
			starting_message  = input_phrase.starting_phrase
			one_time_pad      = input_phrase.one_time_phrase
			encrypted_message = input_phrase.encrypted_message
			decrypt_test = OneTimePad.new()
			decrypt_test.decrypt_phrase(encrypted_message, one_time_pad)
			expect(decrypt_test.starting_phrase).to eq(starting_message)
		end

		it "empty string returns empty dycryption" do
			input_phrase = OneTimePad.new()
			input_phrase.randomize_phrase
			input_phrase.encrypt_phrase
			starting_message  = input_phrase.starting_phrase
			one_time_pad      = input_phrase.one_time_phrase
			encrypted_message = input_phrase.encrypted_message
			decrypt_test = OneTimePad.new()
			decrypt_test.decrypt_phrase(encrypted_message, one_time_pad)
			expect(decrypt_test.starting_phrase).to eq(starting_message)
		end

	end

	it "stores all words in starting array" do
		input_phrase = "I am four words"
		single_instance = OneTimePad.new()
	 	single_instance.phrase_content(input_phrase)
		expect(single_instance.starting_phrase).to eq("I am four words")
		expect(single_instance.starting_array).to eq(["I", "am", "four", "words"])
	end

	it "empty starting array if any words have numbers or punctuation" do
		input_phrase = "I am 4 words"
		single_instance = OneTimePad.new()
		single_instance.phrase_content(input_phrase)
		expect(single_instance.starting_phrase).to eq("I am 4 words")
		expect(single_instance.starting_array).to eq(["I", "am", "4", "words"])
	end

	it "null input returns empty array " do
		input_phrase = ""
		single_instance = OneTimePad.new()
		single_instance.phrase_content(input_phrase)
		expect(single_instance.starting_phrase).to eq("")
		expect(single_instance.starting_array).to eq([])
	end

	it "array input returns empty array " do
		input_phrase = ["I", "am", "words"]
		single_instance = OneTimePad.new()
		single_instance.phrase_content(input_phrase)
		expect(single_instance.starting_phrase).to eq("")
		expect(single_instance.starting_array).to eq([])
	end

	it "number input returns empty array " do
		input_phrase = 42
		single_instance = OneTimePad.new()
		single_instance.phrase_content(input_phrase)
		expect(single_instance.starting_phrase).to eq("")
		expect(single_instance.starting_array).to eq([])
	end

end
