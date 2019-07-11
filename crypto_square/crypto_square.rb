#class Crypto
#  def initialize(input)
#    @input = input
#    @plaintext = normalize_plaintext
#  end
#
#  def normalize_plaintext
#    @input.downcase.gsub(/[^a-z0-9]/, '') 
#  end
#
#  # the size of the square is the number of columns
#  # if the message length is a perfect square, use that
#  # message.size sq rt ceil
#  def size
#    Math.sqrt(@plaintext.size).ceil
#  end
#
#  # operates on @plaintext
#  # returns an array of strings, each string of size
#  # @plaintext.scan(/#{. * size}/)
#  # scan for a size, but include the remainder
#  def plaintext_segments
#    @plaintext.scan(/#{'.' * size}|.+/)
#  end
#
#  # returns one big encoded string
#  # calls plaintext_segments
#  # size.times
#  def ciphertext
#    build_ciphertext_data_structure.join
#  end
#
#  # If I put ciphertext into a datastructure, then this method is just joining
#  # that data structure
#  def normalize_ciphertext
#    build_ciphertext_data_structure.join(' ')
#  end
#
#  private
#
#  # What data structure do I want? array of strings
#  def build_ciphertext_data_structure
#    ciphertext_segments = []
#    size.times do |idx|
#      ciphertext_segment = ''
#      plaintext_segments.each { |plaintext_segment| ciphertext_segment << plaintext_segment[idx] if plaintext_segment[idx] }
#      ciphertext_segments << ciphertext_segment
#    end
#    ciphertext_segments
#  end
#end

class Crypto
  def initialize(input)
    @plaintext = input.downcase.gsub(/\W/, '')
  end

  def normalize_plaintext
    @plaintext
  end

  def size
    Math.sqrt(@plaintext.size).ceil
  end

  def plaintext_segments
    @plaintext.scan(/.{1,#{size}}/)
  end

  def ciphertext
    build_arr_of_ciphertext_segments.join
  end

  def normalize_ciphertext
    build_arr_of_ciphertext_segments.join(' ')
  end

  private

  def build_arr_of_ciphertext_segments
    ciphertext_segments = []

    size.times do |idx|
      ciphertext_segment = ''
      plaintext_segments.each do |plaintext_segment| 
	ciphertext_segment << plaintext_segment[idx] if plaintext_segment[idx]
      end
      ciphertext_segments << ciphertext_segment
    end

    ciphertext_segments
  end
end
