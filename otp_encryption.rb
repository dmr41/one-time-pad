
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
				@starting_array = phrase_to_encode.upcase.split()
				@starting_phrase = phrase_to_encode
		else
			puts "Your code is not a string between A-Z"
		end
		@starting_phrase
	end

#Boolean test for phrase validity - returns true or false
	def validate_input(phrase_to_encode)
		validate_state = false
		if (phrase_to_encode.is_a?(String) && phrase_to_encode != "" )
			valid_content = phrase_to_encode.gsub(/\s+/, "")
			if(valid_content[/[a-zA-Z]+/] == valid_content)
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
				letter_roulet = (65 + rand(25)).chr
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
			unencoded_array = word.split('').map{|v| v.ord - 65}
			one_time_array  = @one_time_array[outer_index].split('').map{|v| v.ord - 65}
			unencoded_array.each_with_index do |starting_value, inner_index|
				encoding_value = starting_value + one_time_array[inner_index] - 1
				encrypted_word += ((encoding_value % 26) + 65).chr
			end
			@encrypted_array << encrypted_word
		end
		@encrypted_message = @encrypted_array.join(" ")
		##These output statements will be removed  - For testing only!
		puts "Starting phrase: #{@starting_phrase}"
		puts "One time:        #{@one_time_phrase}"
		puts "encrypted:       #{@encrypted_message}"
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
		##These output statements will be removed  - For testing only!
		puts "Starting phrase: #{@starting_phrase}"
		puts "One time:        #{@one_time_phrase}"
		puts "Encrypted:       #{@encrypted_message}"
	end



def single_word_decryption(word, outer_index)
	encrypted_array    = word.split('').map{|v| v.ord - 65}
	one_time_array     = @one_time_array[outer_index].split('').map{|v| v.ord - 65}
	decoded_word = ""
	encrypted_array.each_with_index do |encrypted_value, inner_index|
		decoding_value = encrypted_value - one_time_array[inner_index] +1
		if(decoding_value >= 0)
			decoded_word += (decoding_value + 65 ).chr
		else
			decoded_word += ((decoding_value+26) + 65 ).chr
		end
	end
	@starting_array << decoded_word
end

end
jimmy = OneTimePad.new("I am text")
jimmy.randomize_phrase
