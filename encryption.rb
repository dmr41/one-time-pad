
class Encryption
	attr_accessor :starting_phrase, :one_time_phrase, :encrypted_message

## Encryption class initializes phrase instance variable provided by user
## Default state is an empty string
	def initialize (phrase_to_encode="")
		@starting_phrase = phrase_content(phrase_to_encode)
		@one_time_phrase = ""
		@encrypted_message = ""
	end

## phrase_content takes user input and tests if it is a string and
## if it only contains a string with only A-Z input
	def phrase_content(phrase_to_encode)
		if (phrase_to_encode.is_a?(String) && phrase_to_encode != "" )
			phrase_to_encode.gsub!(/\s+/, "")
			if(phrase_to_encode[/[a-zA-Z]+/] == phrase_to_encode)
				@starting_phrase = phrase_to_encode.upcase
			end
		else
			puts "Your code is not a string between A-Z"
		end
			@starting_phrase ||= ""
	end

## Generates one-time pad!
	def randomize_phrase
		if(@starting_phrase.length)
			for letter in  1..@starting_phrase.length
				letter_roulet = (65 + rand(25)).chr
				@one_time_phrase += letter_roulet
			end
		else
			puts "Phrase is empty. Please try again!"
		end
		@one_time_phrase
	end

## Encrypts starting message with one time pad value
	def encrypt_phrase
		unencoded_array = @starting_phrase.split('').map{|v| v.ord - 65}
		one_time_array  = @one_time_phrase.split('').map{|v| v.ord - 65}
		unencoded_array.each_with_index do |starting_value, index|
			encoding_value = starting_value + one_time_array[index] - 1
			@encrypted_message += ((encoding_value % 26) + 65).chr
		end
		##These output statements will be removed  - For testing only!
		puts "Starting phrase: #{@starting_phrase}"
		puts "One time:        #{@one_time_phrase}"
		puts "encrypted:       #{@encrypted_message}"
	end

	## Decrypts starting message with one time pad value and encrypted message
	def decrypt_phrase(encrypted_message, one_time_pad)
		@encrypted_message = encrypted_message
		@one_time_phrase   = one_time_pad
		encrypted_array    = @encrypted_message.split('').map{|v| v.ord - 65}
		one_time_array     = @one_time_phrase.split('').map{|v| v.ord - 65}
		@starting_phrase   = ""
		encrypted_array.each_with_index do |encrypted_value, index|
			decoding_value = encrypted_value - one_time_array[index] +1
			if(decoding_value >= 0)
				@starting_phrase += (decoding_value + 65 ).chr
			else
				@starting_phrase += ((decoding_value+26) + 65 ).chr
			end
		end
		##These output statements will be removed  - For testing only!
		puts "Starting phrase: #{@starting_phrase}"
		puts "One time:        #{@one_time_phrase}"
		puts "Encrypted:       #{@encrypted_message}"

	end

end
