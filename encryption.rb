
class Encryption
	attr_accessor :phrase

## Encryption class initializes phrase instance variable provided by user
## Default state is an empty string
	def initialize (phrase_to_encode="")
		phrase_content(phrase_to_encode)
		@phrase = phrase_to_encode
	end

	def phrase_content(phrase_to_encode)

	end

end
