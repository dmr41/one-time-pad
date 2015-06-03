
class OneTimePad
	attr_accessor :starting_phrase, :one_time_phrase,
								:encrypted_message, :starting_array,
								:one_time_array, :encrypted_array

## Encryption class initializes phrase instance variable provided by user
## Default state is an empty string
	def initialize (phrase_to_encode="")
		@starting_phrase = phrase_content(phrase_to_encode)
		@starting_array ||= []
		@one_time_phrase = ""
		@one_time_array ||= []
		@encrypted_message = ""
		@encrypted_array ||= []
	end

## phrase_content takes user input and tests if it is a string and
## if it only contains a string with only A-Z input
	def phrase_content(phrase_to_encode)
		@starting_phrase = ""
		phrase_valid = validate_input(phrase_to_encode)
		if (phrase_valid)
				@starting_array = phrase_to_encode.split()
				@starting_phrase = phrase_to_encode
		end
		@starting_phrase
	end

#Boolean test for phrase validity - returns true or false
	def validate_input(phrase_to_encode)
		validate_state = false
		if (phrase_to_encode.is_a?(String) && phrase_to_encode != "" )
			valid_content = phrase_to_encode.gsub(/\s+/, "")
			if(valid_content[/[A-Za-z0-9 \/_,\.\^\*\+\?\(\)\[\{\|\-\]\}~$#%!:;<>=`]+/] == valid_content)
				validate_state = true
			end
		end
		validate_state
	end

## Generates one-time pad!
	def randomize_phrase
		@starting_array.each do |word|
			random_word = ""
			for letter in  1..word.length
				spin = 33 + rand(93)
				letter_roulet = spin.chr
				random_word += letter_roulet
			end
			@one_time_array << random_word
		end
		@one_time_phrase = @one_time_array.join(" ")
	end


## Encrypts starting message with one time pad value
	def encrypt_phrase
		@starting_array.each_with_index do |word, outer_index|
			encrypted_word = ""
			unencoded_array = word.split('').map{|v| v.ord - 33}
			one_time_array  = @one_time_array[outer_index].split('').map{|v| v.ord - 33}
			unencoded_array.each_with_index do |starting_value, inner_index|
				encoding_value = starting_value + one_time_array[inner_index] - 1
				encrypted_word += ((encoding_value % 94) + 33).chr
			end
			@encrypted_array << encrypted_word
		end
		@encrypted_message = @encrypted_array.join(" ")
	end


## Decrypts starting message with one time pad value and encrypted message
	def decrypt_phrase(encrypted_message, one_time_pad)
		@encrypted_message = encrypted_message
		@encrypted_array = @encrypted_message.split()
		@one_time_phrase   = one_time_pad
		@one_time_array = @one_time_phrase.split()
		@encrypted_array.each_with_index do |word, outer_index|
			single_word_decryption(word, outer_index)
		end
		@starting_phrase = @starting_array.join(" ")
	end

	def output_values
		if (@starting_phrase != "")
			puts "Unencrypted: #{@starting_phrase}"
			puts "Pad:         #{@one_time_phrase}"
			puts "Encrypted:   #{@encrypted_message}"
		else
			puts "Your message is empty or contains unaccepted characters."
		end
	end



	def single_word_decryption(word, outer_index)
		encrypted_array    = word.split('').map{|v| v.ord - 33}
		one_time_array     = @one_time_array[outer_index].split('').map{|v| v.ord - 33}
		decoded_word = ""
		encrypted_array.each_with_index do |encrypted_value, inner_index|
			decoding_value = encrypted_value - one_time_array[inner_index] +1
			if(decoding_value >= 0)
				decoded_word += (decoding_value + 33 ).chr
			else
				decoded_word += ((decoding_value+94) + 33 ).chr
			end
		end
		@starting_array << decoded_word
	end

end
#"I a1m_ t!ext"
# jimmy = OneTimePad.new("/_,.^*+?[{|-]}~$#%!:;<>=`")
# jimmy.randomize_phrase
# jimmy.encrypt_phrase
#
jimmy = OneTimePad.new()
# jimmy.decrypt_phrase("aLuEY!g}B{1Z6-d)QCkXx5cSU", "n+!Q7)p<{v-eq*b+RFjp3O!n5")
jimmy.decrypt_phrase("n+!Q7)p<{v-eq*b+RFjp3O!n5","aLuEY!g}B{1Z6-d)QCkXx5cSU")
