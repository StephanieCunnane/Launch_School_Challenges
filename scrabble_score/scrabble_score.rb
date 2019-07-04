#class Scrabble
#  SCRABBLE_VALUES = {
#    'a' => 1,
#    'b' => 3,
#    'c' => 3,
#    'd' => 2,
#    'e' => 1,
#    'f' => 4,
#    'g' => 2,
#    'h' => 4,
#    'i' => 1,
#    'j' => 8,
#    'k' => 5,
#    'l' => 1,
#    'm' => 3,
#    'n' => 1,
#    'o' => 1,
#    'p' => 3,
#    'q' => 10,
#    'r' => 1,
#    's' => 1,
#    't' => 1,
#    'u' => 1,
#    'v' => 4,
#    'w' => 4,
#    'x' => 8,
#    'y' => 4,
#    'z' => 10
#  }.freeze
#
#  def initialize(word)
#    @word = word
#  end
#
#  def self.score(word)
#    new(word).score
#  end
#
#  def score
#    return 0 if ['', nil].include?(@word) || @word.match?(/\s+/)
#
#    @word.downcase.chars.map do |char|
#      SCRABBLE_VALUES[char]
#    end.sum
#  end
#end
#
#class Scrabble
#  SCRABBLE_VALUES = {
#    'a' => 1,
#    'b' => 3,
#    'c' => 3,
#    'd' => 2,
#    'e' => 1,
#    'f' => 4,
#    'g' => 2,
#    'h' => 4,
#    'i' => 1,
#    'j' => 8,
#    'k' => 5,
#    'l' => 1,
#    'm' => 3,
#    'n' => 1,
#    'o' => 1,
#    'p' => 3,
#    'q' => 10,
#    'r' => 1,
#    's' => 1,
#    't' => 1,
#    'u' => 1,
#    'v' => 4,
#    'w' => 4,
#    'x' => 8,
#    'y' => 4,
#    'z' => 10
#  }
#
#  def initialize(word)
#    @word = word
#  end
#
#  def self.score(word)
#    new(word).score
#  end
#
#  def score
#    SCRABBLE_VALUES.default = 0
#    if @word
#      @word.downcase.chars.map do |char|
#	SCRABBLE_VALUES[char]
#      end.sum 
#    else
#      0
#    end
#  end
#end
#
#class Scrabble
#  SCRABBLE_VALUES = {
#    'a' => 1,
#    'b' => 3,
#    'c' => 3,
#    'd' => 2,
#    'e' => 1,
#    'f' => 4,
#    'g' => 2,
#    'h' => 4,
#    'i' => 1,
#    'j' => 8,
#    'k' => 5,
#    'l' => 1,
#    'm' => 3,
#    'n' => 1,
#    'o' => 1,
#    'p' => 3,
#    'q' => 10,
#    'r' => 1,
#    's' => 1,
#    't' => 1,
#    'u' => 1,
#    'v' => 4,
#    'w' => 4,
#    'x' => 8,
#    'y' => 4,
#    'z' => 10
#  }
#
#  def initialize(word)
#    @word = word
#  end
#
#  def self.score(word)
#    new(word).score
#  end
#
#  def score
#    SCRABBLE_VALUES.default = 0
#    if @word
#      @word.chars.reduce(0) do |score, char|
#	score + SCRABBLE_VALUES[char.downcase]
#      end
#    else
#      0
#    end
#  end
#end
#
#########################################################
class Scrabble
  SCRABBLE_VALUES = {
    'a' => 1, 'b' => 3, 'c' => 3, 'd' => 2, 'e' => 1, 'f' => 4, 'g' => 2,
    'h' => 4, 'i' => 1, 'j' => 8, 'k' => 5, 'l' => 1, 'm' => 3, 'n' => 1,
    'o' => 1, 'p' => 3, 'q' => 10, 'r' => 1, 's' => 1, 't' => 1, 'u' => 1,
    'v' => 4, 'w' => 4, 'x' => 8, 'y' => 4, 'z' => 10 }.freeze

  def self.score(word)
    new(word).score
  end

  def initialize(word)
    @word = word
  end

  def score
    return 0 if invalid_input?
    @word.downcase.chars.sum { |char| SCRABBLE_VALUES[char] }
  end

  private

  def invalid_input?
    @word.nil? || @word.match?(/\A\s*\z/)
  end
end

