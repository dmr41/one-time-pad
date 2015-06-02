
This program is for encrypting and decrypting messages using the one time pad
strategy.


### Encryption Algorithm
  * Encryption Class takes a string value
  * Initializer evaluates string for right type and absence of non A-Z values
  * Valid strings are randomized to create a one time pad
  * Starting string and one time pad are used in encryption
  * Used ASCII character encoding where 65 = A and 90 = Z
  * Adjusted values down to 1-26.
  * encryption_value = original_char_value + random_char_value - 1
  * Find remainder out of 26 and then adjusted to ASCII values
    * -----> ((encryption_value) % 26 + 65)
  * numeric values converted to character values


### Decryption Algorithm
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
