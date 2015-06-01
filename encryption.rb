
class Encryption
	attr_accessor :phrase, :one_time_phrase

## Encryption class initializes phrase instance variable provided by user
## Default state is an empty string
	def initialize (phrase_to_encode="")
		@phrase = phrase_content(phrase_to_encode)
		@one_time_phrase = ""
	end

## phrase_content takes user input and tests if it is a string and
## if it only contains a string with A-Z input
	def phrase_content(phrase_to_encode)
		if (phrase_to_encode.is_a?(String) && phrase_to_encode != "" )
			phrase_to_encode.gsub!(/\s+/, "")
			if(phrase_to_encode[/[a-zA-Z]+/] == phrase_to_encode)
				@phrase = phrase_to_encode.upcase
			end
		else
			puts "Your code is not a string between A-Z"
		end
			@phrase ||= ""
	end

## Generate random phrase from user phrase input
	def randomize_phrase

		if(@phrase.length)
			for letter in  1..@phrase.length
				letter_roulet = (65+ rand(25)).chr
				@one_time_phrase += letter_roulet
			end
			puts "Starting phrase: #{@phrase}"
			puts "One time:        #{@one_time_phrase}"
		else
			puts "Phrase is empty. Please try again!"
		end
		@one_time_phrase
	end

end
