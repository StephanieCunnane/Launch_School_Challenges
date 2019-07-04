# With conditionals
#class BeerSong
#  def verse(verse)
#    case verse
#    when 3..99
#      "#{verse} bottles of beer on the wall, #{verse} bottles of beer.\n" \
#      "Take one down and pass it around, #{verse - 1} bottles of beer on the wall.\n"
#    when 2
#      "#{verse} bottles of beer on the wall, #{verse} bottles of beer.\n" \
#      "Take one down and pass it around, #{verse - 1} bottle of beer on the wall.\n"
#    when 1
#      "1 bottle of beer on the wall, 1 bottle of beer.\n" \
#      "Take it down and pass it around, no more bottles of beer on the wall.\n"
#    when 0
#      "No more bottles of beer on the wall, no more bottles of beer.\n" \
#      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
#    end
#  end
#
#  def verses(starting_verse, stopping_verse)
#    starting_verse.downto(stopping_verse).map { |current| verse(current) }.join("\n")
#  end
#
#  def lyrics
#    verses(99, 0)
#  end
#end

# Replacing conditionals with polymorphism
class BeerSong
  class ZeroVerses
    def verse(_count)
      "No more bottles of beer on the wall, no more bottles of beer.\n" \
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    end
  end

  class OneVerse
    def verse(_count)
      "1 bottle of beer on the wall, 1 bottle of beer.\n" \
      "Take it down and pass it around, no more bottles of beer on the wall.\n"
    end
  end

  class TwoVerses
    def verse(_count)
      "2 bottles of beer on the wall, 2 bottles of beer.\n" \
      "Take one down and pass it around, 1 bottle of beer on the wall.\n"
    end
  end

  class RegularVerses
    def verse(count)
      "#{count} bottles of beer on the wall, #{count} bottles of beer.\n" \
      "Take one down and pass it around, #{count - 1} bottles of beer on the wall.\n"
    end
  end

  VERSE_CLASSES = Hash.new(RegularVerses).merge({
    0 => ZeroVerses,
    1 => OneVerse,
    2 => TwoVerses
  })
  
  def verse(count)
    VERSE_CLASSES[count].new.verse(count)
  end
  
  def verses(starting_verse, stopping_verse)
    starting_verse.downto(stopping_verse).map { |current| verse(current) }.join("\n")
  end

  def lyrics
    verses(99, 0)
  end
end
