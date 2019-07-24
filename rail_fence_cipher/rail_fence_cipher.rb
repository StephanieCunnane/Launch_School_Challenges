class RailFenceCipher
  def self.encode(plaintext, rail_count)
    all_rails = Array.new(rail_count) { [] }
    oscillation_order = generate_oscillation_order_arr(plaintext, rail_count)

    plaintext.each_char.with_index do |char, idx|
      all_rails[oscillation_order[idx]] << char
    end

    all_rails.map(&:join).join
  end

  def self.decode(ciphertext, rail_count)
    return ciphertext if ciphertext.empty? || rail_count == 1

    decoded_msg = ''
    all_rails = []
    oscillation_order = generate_oscillation_order_arr(ciphertext, rail_count)
    chunk_size = rail_count * 2 - 2
    chunk_count, remainder = ciphertext.size.divmod(chunk_size)

    rail_fence_string_char_counts = (0...rail_count).map do |rail_idx|
                                      if rail_idx.zero? || (rail_idx == rail_count - 1)
					rail_idx < remainder ? chunk_count + 1 : chunk_count
        			      else
					rail_idx < remainder ? chunk_count * 2 + 1 : chunk_count * 2
        			      end
                                    end

    ciphertext_chars = ciphertext.chars
    rail_fence_string_char_counts.each do |rail_fence_string_char_count|
      all_rails << ciphertext_chars.shift(rail_fence_string_char_count)
    end

    oscillation_order.each do |rail_idx|
      decoded_msg << all_rails[rail_idx].shift
    end

    decoded_msg
  end

  def self.generate_oscillation_order_arr(text, rail_count)
    text_size = text.size
    chunk = (0...rail_count).to_a + (rail_count - 2).downto(1).to_a
    chunk_size = chunk.size

    chunk_count, remainder = text_size.divmod(chunk_size)
    chunk * chunk_count + chunk[0, remainder]
  end
end

# Let's work on encoding first
# input - one string, the plaintext
# output - one string of the same length as the given string, the ciphertext
#
# Notes:
# the rail fence cipher is a transposition cipher
#
#  W . . . E . . . C . . . R . . . L . . . T . . . E
# . E . R . D . S . O . E . E . F . E . A . O . C .
# . . A . . . I . . . V . . . D . . . E . . . N . .

# [0, 1, 2, 1, 0, 1, 2, 1, 0]
# WECRLTEERDSOEEFEAOCAIVDEN
#
# How do we represent a rail fence? an array
#
# What is the really high-level approach?
#
# create rail_count empty arrays - DONE
# peel off chars from the plaintext string - DONE
# push the next char to the appropriate rail fence array
#   oscillation order array
# join the char strings in each rail fence array
# join all the rail fence arrays
# 
#
    #require 'pry'; binding.pry

# What is the high-level approach for the decoding process?
# split the ciphertext into strings (one per rail)
#   how do I use the oscillation order to split the ciphertext string?
# read chars from the strings in the oscillation order, pushing to the result
# string
#

#str2 = 'WEAREDISCOVEREDFLEEATONCE'
#str1 = 'WECRLTEERDSOEEFEAOCAIVDEN' 
#p RailFenceCipher.encode(str1, 3)
#str1 = 'WECRLTEERDSOEEFEAOCAIVDEN'    



#str2 = 'WEAREDISCOVEREDFLEEATONCE'     

# string size: 25
# rail count: 3

# 6 chunks of 4, with 1 remaining letter

# string_size.divmod(chunk_size) -> chunk_count and remainder

# I need the chunk size: rail_count * 2 - 2

# 1) Get chunk size: (rail_count * 2) - 2
# 2) Make one chunk: [0, 1, 2, 1]
# 3) Get chunk_count and remainder: string_size.divmod(chunk_size) -> [chunk_count, remainder]
# 4) oscillating_arr is chunk * chunk_count + remainder


#############################################

#str1 = 'WECRLTEERDSOEEFEAOCAIVDEN'   

# Decrypting

# W . . . E . . . C . . . R . . . L . . . T . . . E   -> 7 chars
# . E . R . D . S . O . E . E . F . E . A . O . C .   -> 12 chars
# . . A . . . I . . . V . . . D . . . E . . . N . .   -> 6 chars

# Each full chunk gives us one char per outer row and 2 chars per inner row

# 1) Make rail_count empty arrays - DONE
# 2) Now split the ciphertext string into rail_count strings:
#      Get chunk_size: (rail_count * 2) - 2
#      Use chunk_size to split the ciphertext string:
#         outer arrays: (ciphertext_size / chunk_size) + remainder
#         inner arrays: (ciphertext_size / chunk_size) * 2 + remainder
#
#      BUT, I have to handle the remainder first in order to get the rail_count
#      array correct
# 3) Then read from the rail arrays in the oscillation order, pushing to a
# result string

# Work out step 2 here:
# The most important piece of information I need is the character count for that
# rail fence string.
# Subprocess - how to get rail fence string character counts:
#   create one array of rail fence string character counts
##########################
# How do I get the total remainder? ciphertext_size % chunk_size
# Then how do I distribute that remainder to make the rail fence string
# character counts correct?
# Build the array of rail fence string char counts WITHOUT remainders first -
# DONE
# Then use the first <remainder> elements of the oscillation order arr to
# determine which of the rail_fence_string_char_counts arr elements to increment
#
# Ok, I've got the rail_fence_string_char_counts arr correct WITHOUT remainders
# Now let me adjust to add in remainders
#
#class RailFenceCipher
#  def self.encode(plaintext, rail_count)
#    all_rails = Array.new(rail_count) { [] }
#    oscillation_order = generate_oscillation_order_arr(plaintext, rail_count)
#
#
#    plaintext.each_char.with_index do |char, idx|
#      all_rails[oscillation_order[idx]] << char
#    end
#
#    all_rails.map(&:join).join
#  end
#
#  def self.decode(ciphertext, rail_count)
#    return ciphertext if ciphertext.empty? || rail_count == 1
#
#    decoded_msg = ''
#    all_rails = []
#    oscillation_order = generate_oscillation_order_arr(ciphertext, rail_count)
#    chunk_size = rail_count * 2 - 2
#    chunk_count, remainder = ciphertext.size.divmod(chunk_size)
#
#    rail_fence_string_char_counts = (0...rail_count).map do |rail_idx|
#                                      if rail_idx.zero? || (rail_idx == rail_count - 1)
#					rail_idx < remainder ? chunk_count + 1 : chunk_count
#        			      else
#					rail_idx < remainder ? chunk_count * 2 + 1 : chunk_count * 2
#        			      end
#                                    end
#    # Now I need to split the ciphertext string up into arrays of char strs of the sizes
#    # given by my rail_fence_string_char_counts arr
#    # What do I want my output to be? an array of char strings
#    ciphertext_chars = ciphertext.chars
#    rail_fence_string_char_counts.each_with_index do |rail_fence_string_char_count, rail_idx|
#      #require 'pry'; binding.pry
#      #all_rails[rail_idx] << ciphertext_chars.shift(rail_fence_string_char_count)
#      all_rails << ciphertext_chars.shift(rail_fence_string_char_count)
#    end
#
#    # Now I need to read from all_rails in the oscillation order, pushing to
#    # result
#    # iterate through the oscillation_order_arr, that tells me which all_rails
#    # subarray I'm currently reading from
#    oscillation_order.each do |rail_idx|
#      decoded_msg << all_rails[rail_idx].shift
#    end
#
#    decoded_msg
#  end
#
#  def self.generate_oscillation_order_arr(plaintext, rail_count)
#    plaintext_size = plaintext.size
#    chunk = (0...rail_count).to_a + (rail_count - 2).downto(1).to_a
#    chunk_size = chunk.size
#
#    chunk_count, remainder = plaintext_size.divmod(chunk_size)
#    chunk * chunk_count + chunk[0, remainder]
#  end
#end
#  def self.encode(plaintext, rail_count)
#    all_rails = Array.new(rail_count) { [] }
#    oscillation_order = generate_oscillation_order_arr(plaintext, rail_count)
#
#
#    plaintext.each_char.with_index do |char, idx|
#      all_rails[oscillation_order[idx]] << char
#    end
#
#    all_rails.map(&:join).join
#  end
#
#  def self.decode(ciphertext, rail_count)
#    return ciphertext if ciphertext.empty? || rail_count == 1
#
#    decoded_msg = ''
#    all_rails = []
#    oscillation_order = generate_oscillation_order_arr(ciphertext, rail_count)
#    chunk_size = rail_count * 2 - 2
#    chunk_count, remainder = ciphertext.size.divmod(chunk_size)
#
#    rail_fence_string_char_counts = (0...rail_count).map do |rail_idx|
#                                      if rail_idx.zero? || (rail_idx == rail_count - 1)
#					rail_idx < remainder ? chunk_count + 1 : chunk_count
#        			      else
#					rail_idx < remainder ? chunk_count * 2 + 1 : chunk_count * 2
#        			      end
#                                    end
#
#    ciphertext_chars = ciphertext.chars
#    rail_fence_string_char_counts.each_with_index do |rail_fence_string_char_count, rail_idx|
#      all_rails << ciphertext_chars.shift(rail_fence_string_char_count)
#    end
#
#    oscillation_order.each do |rail_idx|
#      decoded_msg << all_rails[rail_idx].shift
#    end
#
#    decoded_msg
#  end
#
#  def self.generate_oscillation_order_arr(text, rail_count)
#    text_size = text.size
#    chunk = (0...rail_count).to_a + (rail_count - 2).downto(1).to_a
#    chunk_size = chunk.size
#
#    chunk_count, remainder = text_size.divmod(chunk_size)
#    chunk * chunk_count + chunk[0, remainder]
#  end
#end
#
## Let's work on encoding first
## input - one string, the plaintext
## output - one string of the same length as the given string, the ciphertext
##
## Notes:
## the rail fence cipher is a transposition cipher
##
##  W . . . E . . . C . . . R . . . L . . . T . . . E
## . E . R . D . S . O . E . E . F . E . A . O . C .
## . . A . . . I . . . V . . . D . . . E . . . N . .
#
## [0, 1, 2, 1, 0, 1, 2, 1, 0]
## WECRLTEERDSOEEFEAOCAIVDEN
##
## How do we represent a rail fence? an array
##
## What is the really high-level approach?
##
## create rail_count empty arrays - DONE
## peel off chars from the plaintext string - DONE
## push the next char to the appropriate rail fence array
##   oscillation order array
## join the char strings in each rail fence array
## join all the rail fence arrays
## 
##
#    #require 'pry'; binding.pry
#
## What is the high-level approach for the decoding process?
## split the ciphertext into strings (one per rail)
##   how do I use the oscillation order to split the ciphertext string?
## read chars from the strings in the oscillation order, pushing to the result
## string
##
#
##str2 = 'WEAREDISCOVEREDFLEEATONCE'
##str1 = 'WECRLTEERDSOEEFEAOCAIVDEN' 
##p RailFenceCipher.encode(str1, 3)
##str1 = 'WECRLTEERDSOEEFEAOCAIVDEN'    
#
#
#
##str2 = 'WEAREDISCOVEREDFLEEATONCE'     
#
## string size: 25
## rail count: 3
#
## 6 chunks of 4, with 1 remaining letter
#
## string_size.divmod(chunk_size) -> chunk_count and remainder
#
## I need the chunk size: rail_count * 2 - 2
#
## 1) Get chunk size: (rail_count * 2) - 2
## 2) Make one chunk: [0, 1, 2, 1]
## 3) Get chunk_count and remainder: string_size.divmod(chunk_size) -> [chunk_count, remainder]
## 4) oscillating_arr is chunk * chunk_count + remainder
#
#
##############################################
#
##str1 = 'WECRLTEERDSOEEFEAOCAIVDEN'   
#
## Decrypting
#
## W . . . E . . . C . . . R . . . L . . . T . . . E   -> 7 chars
## . E . R . D . S . O . E . E . F . E . A . O . C .   -> 12 chars
## . . A . . . I . . . V . . . D . . . E . . . N . .   -> 6 chars
#
## Each full chunk gives us one char per outer row and 2 chars per inner row
#
## 1) Make rail_count empty arrays - DONE
## 2) Now split the ciphertext string into rail_count strings:
##      Get chunk_size: (rail_count * 2) - 2
##      Use chunk_size to split the ciphertext string:
##         outer arrays: (ciphertext_size / chunk_size) + remainder
##         inner arrays: (ciphertext_size / chunk_size) * 2 + remainder
##
##      BUT, I have to handle the remainder first in order to get the rail_count
##      array correct
## 3) Then read from the rail arrays in the oscillation order, pushing to a
## result string
#
## Work out step 2 here:
## The most important piece of information I need is the character count for that
## rail fence string.
## Subprocess - how to get rail fence string character counts:
##   create one array of rail fence string character counts
###########################
## How do I get the total remainder? ciphertext_size % chunk_size
## Then how do I distribute that remainder to make the rail fence string
## character counts correct?
## Build the array of rail fence string char counts WITHOUT remainders first -
## DONE
## Then use the first <remainder> elements of the oscillation order arr to
## determine which of the rail_fence_string_char_counts arr elements to increment
##
## Ok, I've got the rail_fence_string_char_counts arr correct WITHOUT remainders
## Now let me adjust to add in remainders
##
##class RailFenceCipher
##  def self.encode(plaintext, rail_count)
##    all_rails = Array.new(rail_count) { [] }
##    oscillation_order = generate_oscillation_order_arr(plaintext, rail_count)
##
##
##    plaintext.each_char.with_index do |char, idx|
##      all_rails[oscillation_order[idx]] << char
##    end
##
##    all_rails.map(&:join).join
##  end
##
##  def self.decode(ciphertext, rail_count)
##    return ciphertext if ciphertext.empty? || rail_count == 1
##
##    decoded_msg = ''
##    all_rails = []
##    oscillation_order = generate_oscillation_order_arr(ciphertext, rail_count)
##    chunk_size = rail_count * 2 - 2
##    chunk_count, remainder = ciphertext.size.divmod(chunk_size)
##
##    rail_fence_string_char_counts = (0...rail_count).map do |rail_idx|
##                                      if rail_idx.zero? || (rail_idx == rail_count - 1)
##					rail_idx < remainder ? chunk_count + 1 : chunk_count
##        			      else
##					rail_idx < remainder ? chunk_count * 2 + 1 : chunk_count * 2
##        			      end
##                                    end
##    # Now I need to split the ciphertext string up into arrays of char strs of the sizes
##    # given by my rail_fence_string_char_counts arr
##    # What do I want my output to be? an array of char strings
##    ciphertext_chars = ciphertext.chars
##    rail_fence_string_char_counts.each_with_index do |rail_fence_string_char_count, rail_idx|
##      #require 'pry'; binding.pry
##      #all_rails[rail_idx] << ciphertext_chars.shift(rail_fence_string_char_count)
##      all_rails << ciphertext_chars.shift(rail_fence_string_char_count)
##    end
##
##    # Now I need to read from all_rails in the oscillation order, pushing to
##    # result
##    # iterate through the oscillation_order_arr, that tells me which all_rails
##    # subarray I'm currently reading from
##    oscillation_order.each do |rail_idx|
##      decoded_msg << all_rails[rail_idx].shift
##    end
##
##    decoded_msg
##  end
##
##  def self.generate_oscillation_order_arr(plaintext, rail_count)
##    plaintext_size = plaintext.size
##    chunk = (0...rail_count).to_a + (rail_count - 2).downto(1).to_a
##    chunk_size = chunk.size
##
##    chunk_count, remainder = plaintext_size.divmod(chunk_size)
##    chunk * chunk_count + chunk[0, remainder]
##  end
##end
