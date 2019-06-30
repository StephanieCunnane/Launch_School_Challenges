class Anagram
  def initialize(word)
    @word = word.downcase
  end
   
  def match(candidates)
    candidates.select do |candidate|
      next if candidate.casecmp?(@word)
      frequency_hash(candidate.downcase) == frequency_hash(@word)
    end
  end

  private

  def frequency_hash(word)
    hsh = Hash.new(0)
    word.each_char { |char| hsh[char] += 1 }
    hsh
  end
end
#
# Initial solution (#sort)
# class Anagram
#   def initialize(word)
#     @word = word.downcase
#   end

#   def match(words)
#     letters = @word.chars.sort
#     words.select do |candidate|
#	candidate.downcase != @word && candidate.downcase.chars.sort == letters
#     end
#   end
# end
#
# With Array#permutation
# class Anagram
#   def initialize(word)
#     @word = word.downcase
#   end
# 
#   def match(candidates)
#     word_permutations = @word.chars.permutation.map(&:join)
#     candidates.select do |candidate|
#       candidate = candidate.downcase
#       next if candidate == @word
#       word_permutations.include?(candidate)
#     end
#   end
# end
#
# words have the same count for all their letters
# class Anagram
#   def initialize(word)
#     @word = word.downcase
#   end
# 
#   def match(candidates)
#     candidates.select do |candidate|
#       candidate = candidate.downcase
#       next unless @word.size == candidate.size && !candidate.casecmp?(@word)
#       @word.chars.uniq.all? do |char|
#         @word.count(char) == candidate.count(char)
#       end
#     end
#   end
# end
