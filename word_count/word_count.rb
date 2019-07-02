class Phrase
  def initialize(phrase)
    @phrase = phrase.downcase.scan(/[a-z0-9']+/)
  end

  def word_count
    process_quotes.each_with_object(Hash.new(0)) { |word, counts| counts[word] += 1 }
  end

  private

  def process_quotes
    @phrase.map do |word| 
      word[0] == "'" && word[-1] == "'" ? word[1...-1] : word
    end
  end
end
#
#class Phrase
#  WORD_BOUNDARY_REGEX = /[^a-z0-9_']+/
#  
#  def initialize(phrase)
#    @phrase = phrase.downcase.gsub(/\A[^a-z0-9]+|[^a-z0-9]+\z/, '')
#                             .gsub(/\B'\b/, '')
#                             .gsub(/\b'\B/, '')
#  end
#  
#  def word_count
#    hsh = Hash.new(0)
#    @phrase.split(WORD_BOUNDARY_REGEX).each do |word|
#      hsh[word] += 1
#    end
#    hsh
#  end
#end

#class Phrase
#  def initialize(phrase)
#    @phrase = phrase.downcase.gsub(/\A[^a-z0-9]+|[^a-z0-9]+\z/, '')
#                             .gsub(/\B'\b/, '')
#                             .gsub(/\b'\B/, '')
#  end
#  
#  def word_count
#    hsh = Hash.new(0)
#    @phrase.split(/[^a-z0-9_']+/).each do |word|
#      hsh[word] += 1
#    end
#    hsh
#  end
#end

# Can I refactor this to make ONE pass through the data structure?
# Yes, use String#scan with a block. (However, this still misses the 
# edge case of a possessive noun.)
#
#class Phrase
#  def initialize(phrase)
#    @phrase = phrase.downcase
#  end
#
#  def word_count
#    counts = Hash.new(0)
#    @phrase.scan(/\b[\w']+\b/) do |word|
#      counts[word] += 1
#    end
#    counts
#  end
#end
