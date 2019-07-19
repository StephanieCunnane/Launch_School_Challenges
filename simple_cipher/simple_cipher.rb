# Implement a simple shift cipher (like Caesar's); the LS version ISN'T doing
# the second part, the substitution cipher
#
# Given the key "aaaaaaaaaaaaaaaaaa", encoding the string "iamapandabear" would return the original "iamapandabear".

# Given the key "ddddddddddddddddd", encoding our string "iamapandabear" would return the obscured "ldpdsdqgdehdu"
# 
# Each letter of the key will be "added" to the corresponding char in the
# plaintext in order to get the encoded text.
# It's a letter-by-letter "adding" operation
#
# Original Caesar Cipher: add 3 to each letter
# a simple shift cipher
# the key determines the shift distance
# so the only relevant bit of info is the first letter of the key?
#
# "allow us to specify a key and use that key for the shift distance"
      #require 'pry'; binding.pry
#
# So my key is generated correctly and I'm correctly encoding
# Now I need to get decoding working
#
#class Cipher
#  OFFSETS_FROM_A = [*'a'..'z']
#
#  attr_reader :key
#
#  def initialize(key=nil)
#    validate(key) if key
#    @key = key || generate_random_key
#  end
#
#  def encode(plaintext)
#    plaintext.chars.map.with_index do |char, idx|
#      original_ascii = char.ord + OFFSETS_FROM_A.index(@key[idx])
#      normalized_ascii = original_ascii > 122 ? original_ascii - 26 : original_ascii
#
#      normalized_ascii.chr
#    end.join 
#  end
#
#  def decode(ciphertext)
#    ciphertext.chars.map.with_index do |char, idx|
#      original_ascii = char.ord - OFFSETS_FROM_A.index(@key[idx])
#      normalized_ascii = original_ascii < 97 ? original_ascii + 26 : original_ascii
#
#      normalized_ascii.chr
#    end.join 
#  end
#
#  private
#
#  def validate(key)
#    unless key.match(/\A[a-z]+\z/)
#      raise ArgumentError, "Key must only contain lowercase letters"
#    end
#  end
#
#  def generate_random_key
#    key = ''
#    100.times { key << [*'a'..'z'].sample }
#    key
#  end
#end

#class Cipher
#  attr_reader :key
#
#  def initialize(key=nil)
#    validate(key) if key
#    @key = key || generate_random_key
#  end
#
#  def encode(plaintext)
#    plaintext.chars.map.with_index do |char, idx|
#      distance_from_a = @key[idx].ord - 'a'.ord
#      original_ascii = char.ord + distance_from_a
#      normalized_ascii = original_ascii > 122 ? original_ascii - 26 : original_ascii
#
#      normalized_ascii.chr
#    end.join 
#  end
#
#  def decode(ciphertext)
#    ciphertext.chars.map.with_index do |char, idx|
#      distance_from_a = @key[idx].ord - 'a'.ord
#      original_ascii = char.ord - distance_from_a
#      normalized_ascii = original_ascii < 97 ? original_ascii + 26 : original_ascii
#
#      normalized_ascii.chr
#    end.join 
#  end
#
#  private
#
#  def validate(key)
#    unless key.match(/\A[a-z]+\z/)
#      raise ArgumentError, "Key must only contain lowercase letters"
#    end
#  end
#
#  def generate_random_key
#    key = ''
#    100.times { key << [*'a'..'z'].sample }
#    key
#  end
#end

class Cipher
  OFFSETS_FROM_A = [*'a'..'z'].freeze

  def self.generate_random_key
    key = ''
    100.times { key << [*'a'..'z'].sample }
    key
  end

  attr_reader :key

  def initialize(key=nil)
    validate(key) if key
    @key = key || Cipher.generate_random_key
  end

  def encode(plaintext)
    transform(plaintext, :right)
  end

  def decode(ciphertext)
    transform(ciphertext, :left)
  end

  private

  def transform(text, shift_direction)
    operator = shift_direction == :right ? :+ : :-

    text.chars.map.with_index do |char, idx|
      ascii_num = char.ord.send(operator, OFFSETS_FROM_A.index(@key[idx]))
      normalize(ascii_num).chr
    end.join
  end

  def validate(key)
    msg = "Key must only contain lowercase letters"
    raise ArgumentError, msg unless key.match(/\A[a-z]+\z/)
  end

  def normalize(ascii_num)
    beyond_z = 123
    below_a = 96

    case ascii_num
    when beyond_z..Float::INFINITY then ascii_num - 26
    when 0..below_a then ascii_num + 26
    else ascii_num
    end
  end
end
