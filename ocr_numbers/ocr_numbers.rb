## I want to convert this binary font to a '0' or '1'.
## an array of multi-line strings
##
## correct size but not in DIGITS, return '?'
##    3 newlines total, always one at the end
## ArgumentError if the input is the wrong size
#
## Ok, I've got individual digits and input validation handled.
## Now I need to work on having a number with multiple digits.
## I need a good regex that can scan for the individual digits in the input
## string
## scan
## map { DIGITS index.... }
## join
##
## I need to map each digit to '0'(etc), or ? or an ArgumentError
#
# # My main data structure is wrong
##[6] pry(#<OCR>)> # Each digit needs to be an array of strings, 3 chars per string, no newlines yet
##[7] pry(#<OCR>)> # just join the strings with \n to get one digit
##[8] pry(#<OCR>)> # Crux of the entire problem is representing 2 digits side by side
##[9] pry(#<OCR>)> # an array with 2 subarrays of strings
##[10] pry(#<OCR>)> # where each subarray is a ndw digit
##[11] pry(#<OCR>)> # the top part of each digit is at idx 0 in each subarray
##[12] pry(#<OCR>)> # parts of the digits correspond to the idx
##[13] pry(#<OCR>)>
#
##class OCR
##  DIGITS = [
##    " _\n| |\n|_|\n",
##    "\n  |\n  |\n",
##    " _\n _|\n|_\n",
##    " _\n _|\n _|\n",
##    "\n|_|\n  |\n",
##    " _\n|_\n _|\n",
##    " _\n|_\n|_|\n",
##    " _\n  |\n  |\n",
##    " _\n|_|\n|_|\n",
##    " _\n|_|\n _|\n"
##  ]
##
##  BINARY_DIGIT_SIZE_REGEX = /.*\n.+\n.+\n/
##
##  def initialize(input)
##    @input = input
##  end
##
##  def convert
##    arr = @input.scan(BINARY_DIGIT_SIZE_REGEX) 
##    return ArgumentError if arr.empty?
##
##    arr.map do |binary_digit|
##      require 'pry'; binding.pry
##      if DIGITS.include?(binary_digit)
##	DIGITS.index(binary_digit).to_s
##      else
##	'?'
##      end
##    end.join
##  end
##end
#
## This problem is entirely about the data structure
## A hash where the arr of digit pieces strs is the key, decimal digit str is
## value
## split the input on \n, then lookup the digit str
## let's do this for 0
##
## If the input is the correct size, but not recognizable, your program should return '?'. If the input is the incorrect size, your program should return an error.
##
##class OCR
##  DIGITS = {
##    [' _ ', '| |', '|_|'] => '0',
##    ['   ', '  |', '  |'] => '1',
##    [' _ ', ' _|', '|_ '] => '2',
##    [' _ ', ' _|', ' _|'] => '3',
##    ['   ', '|_|', '  |'] => '4',
##    [' _ ', '|_ ', ' _|'] => '5',
##    [' _ ', '|_ ', '|_|'] => '6',
##    [' _ ', '  |', '  |'] => '7',
##    [' _ ', '|_|', '|_|'] => '8',
##    [' _ ', '|_|', ' _|'] => '9'
##  }
##
##  BINARY_DIGIT_SIZE_REGEX = /.*\n.+\n.+\n/
##
##  def initialize(input)
##    @input = input
##  end
##
##  # Right now #convert deals with a single digit
##  # What happens when we get multiple digits in the input?
##  # I think what I have now is the lowest abstraction.
##  # There's one more map on top of it
##  # So I need to put what I have now in a utility method
##  #
##  # The higher abstraction is splitting up digits
##  # split up digits
##  # send them to convert_one_digit
##  # join
##
##  # How should I split the input string?
##  # 3 newlines, where the last is at the end
##
##  def convert
##    result = []
##    arr = 
##    convert_one_digit
##    result
##  end
##
##  private
##
##  def convert_one_digit
##    arr = @input.split("\n").map do |str|
##      case str
##      when '' then '   '
##      when /\A..\z/ then str << ' '
##      else str
##      end
##    end
##
##    return ArgumentError unless arr.size == 3 && arr.all?(String)
##
##    DIGITS[arr] || '?'
##  end
##end
#
#
#class OCR
#  #DIGITS = {
#  #  [' _ ', '| |', '|_|'] => '0',
#  #  ['   ', '  |', '  |'] => '1',
#  #  [' _ ', ' _|', '|_ '] => '2',
#  #  [' _ ', ' _|', ' _|'] => '3',
#  #  ['   ', '|_|', '  |'] => '4',
#  #  [' _ ', '|_ ', ' _|'] => '5',
#  #  [' _ ', '|_ ', '|_|'] => '6',
#  #  [' _ ', '  |', '  |'] => '7',
#  #  [' _ ', '|_|', '|_|'] => '8',
#  #  [' _ ', '|_|', ' _|'] => '9'
#  #}
#
#  DIGITS = {
#    [' _', '| |', '|_|'] => '0',
#    ['', '  |', '  |']   => '1',
#    [' _', ' _|', '|_']  => '2',
#    [' _', ' _|', ' _|'] => '3',
#    ['', '|_|', '  |']   => '4',
#    [' _', '|_', ' _|']  => '5',
#    [' _', '|_', '|_|']  => '6',
#    [' _', '  |', '  |'] => '7',
#    [' _', '|_|', '|_|'] => '8',
#    [' _', '|_|', ' _|'] => '9'
#  }.freeze
#
#  #DIGIT_PIECES_REGEX = /.*\n.+\n.+\n/
#
#  def initialize(input)
#    @input = input
#  end
#
#  # Right now #convert deals with a single digit
#  # What happens when we get multiple digits in the input?
#  # I think what I have now is the lowest abstraction.
#  # There's one more map on top of it
#  # So I need to put what I have now in a utility method
#  #
#  # The higher abstraction is splitting up digits
#  # split up digits
#  # send them to convert_one_digit
#  # join
#
#  # How should I split the input string?
#  # 3 newlines, where the last is at the end
#
#  # So I'm back to the point where I was before, but now I have a good data
#  # structure
#  #
#  # Now I need to get my program working with 2 digits
## the regex gives me PIECES of digits
##[4] pry(#<OCR>)> # so I'm not mapping over the right thing
##[5] pry(#<OCR>)> 
#
## With top, I have the top portions of ALL digits
## I have one string that represents the top portions of ALL digits
## So how do I split that up into substrings that are the top parts of separate
## digits?
## 
## Iterate through DIGITS.keys[0]
## Hmmm, I might be solving the wrong problem.
## Let's just try pry:
#  # Maybe I don't need the lower abstraction method now.
#  #
#  # There will always be just 3 newlines
#  # gsub ' _' with ' _ '
#
#  def convert
#    result = ''
#
#    tops, middles, bottoms = @input.split("\n")
#    #[tops, middles, bottoms].each do |piece| 
#    #  #piece << ' ' if piece.size == 2
#    # # piece.gsub!(' _', ' _ ')
#    #  piece.gsub!(/ _(?!\|)/, ' _ ')
#    #end
#    tops = tops.scan(/.../)
#    middles = middles.scan(/.../)
#    bottoms = bottoms.scan(/.../)
#
#    digit_count = tops.size
#
#    digit_count.times do |idx|
#      digit_candidate = [tops[idx], middles[idx], bottoms[idx]]
#      #require 'pry'; binding.pry
#      result << (DIGITS[digit_candidate] || '?')
#    end
#
#    #require 'pry'; binding.pry
#    #arr.map do |candidate|
#    #  convert_one_digit(candidate)
#    #end.join
#    result
#  end
#
#  private
#
#  #def convert_one_digit(candidate)
#  #  arr = candidate.split("\n").map do |str|
#  #    case str
#  #    when '' then '   '
#  #    when /\A..\z/ then str << ' '
#  #    else str
#  #    end
#  #  end
#
#  #  return ArgumentError unless arr.size == 3 #&& arr.all?(String)
#
#  #  DIGITS[arr] || '?'
#  #end
#end

# Ok, I'm looking at diminishing returns at this point. 
# I'm going to watch the video now.

# delete all newlines in the input
# split the input into groups of 9 
# do the appropriate lookups
#
#class OCR
#  # a hash with a default value of ?
#  #DIGITS = {
#  #  ' _ | ||_|' => '0',
#  #  '     |  |' => '1',
#  #  ' _  _||_ ' => '2',
#  #  ' _  _| _|' => '3',
#  #  '   |_|  |' => '4',
#  #  ' _ |_  _|' => '5',
#  #  ' _ |_ |_|' => '6',
#  #  ' _   |  |' => '7',
#  #  ' _ |_||_|' => '8',
#  #  ' _ |_| _|' => '9'
#  #}
#
#  DIGITS = {
#    " _\n| |\n|_|\n" => '0',
#    "\n  |\n  |\n"   => '1',
#    " _\n _|\n|_\n"  => '2',
#    " _\n _|\n _|\n" => '3',
#    "\n|_|\n  |\n"   => '4',
#    " _\n|_\n _|\n"  => '5',
#    " _\n|_\n|_|\n"  => '6',
#    " _\n  |\n  |\n" => '7',
#    " _\n|_|\n|_|\n" => '8',
#    " _\n|_|\n _|\n" => '9'
#  }
#
#  def initialize(input)
#    # this is where I'll modify the input to match the DIGITS keys
#    # if the first 3 characters are " _\n", replace it with " _ " - regex
#   # @input = input.gsub(/^ _\n/m, ' _ ').delete("\n")
#    #@input = input.gsub(/^ _\n/m, ' _ ').delete("\n")
#    #require 'pry'; binding.pry
#    @input = input
#  end
#
#  def convert
#    @input.scan(/.*\n.+\n.+\n/).map do |letter_candidate|
#    require 'pry'; binding.pry
#      DIGITS[letter_candidate] || '?'
#    end.join
#  end
#end
#
################################################
#
# Use a hash for this problem
# In some of the digit parts, the last space has been stripped out, so
#    I need to add it back in
# Look at Victor's solution
# Pete's data structure
# A canvas of rows of digits
#
# Possible approach:
# Read in the text by rows
# trinary data - boil a 3 x 4 grid down to one number
#
# Ok, read through Will's code to get an understanding of the general approach
# Map over the entire canvas to get rows of digits, then join those rows
# together
#
# What is numbers doing?
# After figuring out what it's doing, what's a better name for numbers?

class OCR
  DIGITS = {
    ' _ | ||_|' => '0',
    '     |  |' => '1',
    ' _  _||_ ' => '2',
    ' _  _| _|' => '3',
    '   |_|  |' => '4',
    ' _ |_  _|' => '5',
    ' _ |_ |_|' => '6',
    ' _   |  |' => '7',
    ' _ |_||_|' => '8',
    ' _ |_| _|' => '9'
  }

  DIGITS.default = '?'

  def initialize(input)
    @input = input
  end

  def convert
    canvas.map { |row| parse_row_into_digits(row) }.join(',')
  end

  private

  def parse_row_into_digits(row)
    # all_segments is my tops, middles, bottoms
    all_segments = rows(row).map { |row| segments(row) }
    all_strings = all_segments.transpose.map { |substr| substr.join }
    all_strings.map { |str| DIGITS[str] }.join
    #require 'pry'; binding.pry
  end

  def canvas
    @input.split("\n\n")
  end

  def rows(line)
    line.split("\n")
  end

  def segments(row)
    row.empty? ? ['   '] : row.scan(/.{1,3}/).map { |segment| segment.ljust(3) }
  end
end
