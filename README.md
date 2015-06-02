
### Code Details
* Encryption is a single class for A-Z encryption and decryption using one-time-pads.
* Written in Ruby-2.2.0
* Tests were written using rspec 3.2.3
* To run tests
* Download repository
* Install rspec if not installed
* $ rspec


#### Usage
* This program only accepts string values between A-Z.
* It can handle whitespace and case differences.
* It does not work with punctuation or stringified numbers, by design.
* Any input values that do not fall within these parameters is returned as an empty string.
* Code Snippets - can be called by requiring the encryption.rb file into your project.

  Example code to encrypt a string
  ``` ruby
    text_to_encrypt = "Encrypt me please"
    encryption_instance = Encryption.new(text_to_encrypt)
    encryption_instance.randomize_phrase
    encryption_instance.encrypt_phrase

    one_time_pad = encryption_instance.one_time_phrase
    encrypted_message = encryption_instance.encrypted_message
    ```

    Example code to decrypt a string
    ```ruby
    encrypted_message = "LPWSFUKPVSFSOMZA"
    one_time_pad = "JMVCIGSIIGKFYDWY"
    encryption_instance = Encryption.new()
    encryption_instance.decrypt_phrase(encrypted_message, one_time_pad)
    decrypted_message = encryption_instance.starting_phrase
    ```


#### Encryption Algorithm
* Takes an input string value
* Initializer evaluates string for right type and absence of non A-Z values
* Valid strings are randomized to create a one time pad
* Starting string and one time pad are used in encryption
* Used ASCII character encoding where 65 = A and 90 = Z
* Adjusted values down to 1-26
* encryption_value = original_char_value + random_char_value - 1
* Find remainder out of 26 and then adjusted to ASCII values
  * -----> ((encryption_value) % 26 + 65)
* numeric values converted to character values


#### Decryption Algorithm
  * Takes encrpyted_message and one_time_pad as input
  * Both encrypted_message and one_time_pad are converted to 1-26 values
  * decrypt_start = encrypted_value - one_time_pad value + 1
  * decrypt_start values > 0
    1. decrypt_value = decrypt_start + 65
    2. decrypt_value converted to character value
  * decrypt_start values < 1
    1. decrypt_value = decrypt_start + 26 + 65
    2. decrypt_value converted to character value


---------------------------------------------------
Right now functionality causes text to ignore spacing completely.
This might be good for better encryption but harder for users to read.
Considering building a word array based method that returns and array of
1. unencoded
2. one-time-pad
3. encrypted values
