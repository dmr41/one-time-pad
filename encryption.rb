
class Encryption
	attr_accessor :phrase

## Encryption class initializes phrase instance variable provided by user
## Default state is an empty string
	def initialize (phrase_to_encode="")
		@phrase = phrase_content(phrase_to_encode)
	end

	def phrase_content(phrase_to_encode)
		if (phrase_to_encode.is_a?(String) && phrase_to_encode != "" )
			phrase_to_encode.gsub!(/\s+/, "")
			if(phrase_to_encode[/[a-zA-Z]+/] == phrase_to_encode)
				@phrase = phrase_to_encode
			else
				@phrase = ""
			end
		else
			puts "Your code is not a string between A-Z"
			@phrase = ""
		end
	end

end
