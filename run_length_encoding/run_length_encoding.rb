# Sliding window algorithm for #encode
# Just makes one pass through the string
#input = "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"  #->  "12WB12W3B24WB"
#
#def encode(input)
#  compressed = ''
#  starting_idx = 0
#  ending_idx = 0
#  char_at_start_of_run = input[starting_idx]
#  
#  while ending_idx < input.size
#    while input[ending_idx] == char_at_start_of_run
#      ending_idx += 1
#    end
#    
#    run_size = ending_idx - starting_idx
#    
#    if run_size == 1
#      compressed << char_at_start_of_run
#    else
#      compressed << run_size.to_s << char_at_start_of_run
#    end
#    
#    starting_idx = ending_idx
#    char_at_start_of_run = input[starting_idx]
#  end
#  
#  compressed
#end
#
#p encode(input) == '12WB12W3B24WB'
#
#def decode(input)
#  digits = ('0'..'9').to_a
#  current_digit = ''
#  uncompressed = ''
#
#  input.each_char do |char|
#    if digits.include?(char)
#      current_digit << char
#    else
#      if current_digit.empty?
#        uncompressed << char
#      else
#        current_digit.to_i.times { uncompressed << char }
#        current_digit = ''
#      end
#    end
#  end
#
#  uncompressed
#end
#
#input = "12WB12W3B24WB"
#p decode("12WB12W3B24WB") == "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"

#module RunLengthEncoding
#  def self.encode(input)
#    input.chars.chunk_while { |char1, char2| char1 == char2 }.map do |sub_arr|
#      size = sub_arr.size == 1 ? '' : sub_arr.size
#      [size, sub_arr.first].join
#    end.join
#  end
#
#  def self.decode(input)
#    count_value_alternation = input.chars.chunk_while do |char1, char2|
#      char1.match(/\d/) && char2.match(/\d/)
#    end.map(&:join)
#
#    uncompressed = ''
#
#    until count_value_alternation.empty?
#      pair = count_value_alternation.shift(2)
#
#      if pair.first.match(/\d/) && pair.last.match(/\D/)
#        pair.first.to_i.times { uncompressed << pair.last }
#      elsif pair.first.match(/\D/) && pair.last.match(/\d/)
#	uncompressed << pair.first
#	count_value_alternation.unshift(pair.last)
#      elsif pair.all?(/\D/) && pair.size == 2
#	uncompressed << pair.first << pair.last
#      else
#	uncompressed << pair.first
#      end
#    end
#
#    uncompressed
#  end
#end

module RunLengthEncoding
  def self.encode(input)
    compressed = ''
    starting_idx = 0
    ending_idx = 0
    char_at_start_of_run = input[starting_idx]
    
    while ending_idx < input.size
      while input[ending_idx] == char_at_start_of_run
        ending_idx += 1
      end
      
      run_size = ending_idx - starting_idx
      
      if run_size == 1
        compressed << char_at_start_of_run
      else
        compressed << run_size.to_s << char_at_start_of_run
      end
      
      starting_idx = ending_idx
      char_at_start_of_run = input[starting_idx]
    end
    
    compressed
  end

  def self.decode(input)
    digits = ('0'..'9').to_a
    current_digit = ''
    uncompressed = ''

    input.each_char do |char|
      if digits.include?(char)
	current_digit << char
      else
	if current_digit.empty?
	  uncompressed << char
	else
	  current_digit.to_i.times { uncompressed << char }
	  current_digit = ''
	end
      end
    end

    uncompressed
  end
end

module RunLengthEncoding
  def self.encode(input)
    input.gsub(/(.)(\1)*/).map do |run_of_chars|
      size = run_of_chars.size == 1 ? '' : run_of_chars.size
      [size, run_of_chars[0]].join
    end.join
  end

  def self.decode(input)
    count_value_alternation = input.chars.chunk_while do |char1, char2|
				char1.match(/\d/) && char2.match(/\d/)
			      end.map(&:join)

    uncompressed = ''

    until count_value_alternation.empty?
      pair = count_value_alternation.shift(2)

      if pair.first.match(/\d/) && pair.last.match(/\D/)
        pair.first.to_i.times { uncompressed << pair.last }
      elsif pair.first.match(/\D/) && pair.last.match(/\d/)
	uncompressed << pair.first
	count_value_alternation.unshift(pair.last)
      elsif pair.all?(/\D/) && pair.size == 2
	uncompressed << pair.first << pair.last
      else
	uncompressed << pair.first
      end
    end

    uncompressed
  end
end

