
class Encryption
	attr_accessor :phrase, :holding

## Encryption class initializes phrase instance variable provided by user
## Default state is an empty string
	def initialize (phrase_to_encode="")
		@phrase = phrase_content(phrase_to_encode)
		@holding = false
	end

	def phrase_content(phrase_to_encode)
		@holding = phrase_to_encode.is_a?(String)
		if (@holding)
			@phrase = phrase_to_encode
		else
			puts "Your code is not a string"
			@phrase = ""
		end
	end

end
