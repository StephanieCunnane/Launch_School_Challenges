#class House
#  def self.recite
#    entire_poem = ""
#    verse = []
#    idx = 0
#
#    pieces.reverse_each do |piece_arr|
#      if idx.zero?
#	verse.unshift(piece_arr.join(" "))
#      else
#	verse.unshift("\n", piece_arr.join(" "))
#      end
#
#      entire_poem << "This is " << verse.join(" ") << "\n\n"
#      idx += 1
#    end
#
#    entire_poem
#  end
#
#  private
#
#  def self.pieces
#    [
#      ['the horse and the hound and the horn', 'that belonged to'],
#      ['the farmer sowing his corn', 'that kept'],
#      ['the rooster that crowed in the morn', 'that woke'],
#      ['the priest all shaven and shorn', 'that married'],
#      ['the man all tattered and torn', 'that kissed'],
#      ['the maiden all forlorn', 'that milked'],
#      ['the cow with the crumpled horn', 'that tossed'],
#      ['the dog', 'that worried'],
#      ['the cat', 'that killed'],
#      ['the rat', 'that ate'],
#      ['the malt', 'that lay in'],
#      ['the house that Jack built.']
#    ]
#  end
#end

#class House
#  def self.recite
#    new.recite
#  end
#
#  def initialize
#    @entire_poem = ''
#  end
#
#  # the newline goes between array elements, not at the end of a piece arr
#  # join("\n"), then push to @entire_poem
#  #
#  # each VERSE starts with This is....
#  # we get a new verse for each #reverse_each iteration, for each piece
#  # add 'This is ' at the end
#  #
#  # the whole rest of the verse is gone
#  #
#  # nested looping structure
#  #
#  def recite
#    verse = ''
#
#    pieces.reverse_each do |piece|
#      if piece.size == 1
#	verse = piece[0] + verse
#      else
#	#@verse.unshift(piece[0])
#	#@entire_poem << @verse.join(" ")
#        verse << piece.join("\n")
#      end
#      @entire_poem << ("This is " + verse) << "\n\n"
#    end
#
#    @entire_poem.chomp
#  end
#
#  def pieces
#    [
#      ['the horse and the hound and the horn', 'that belonged to'],
#      ['the farmer sowing his corn', 'that kept'],
#      ['the rooster that crowed in the morn', 'that woke'],
#      ['the priest all shaven and shorn', 'that married'],
#      ['the man all tattered and torn', 'that kissed'],
#      ['the maiden all forlorn', 'that milked'],
#      ['the cow with the crumpled horn', 'that tossed'],
#      ['the dog', 'that worried'],
#      ['the cat', 'that killed'],
#      ['the rat', 'that ate'],
#      ['the malt', 'that lay in'],
#      ['the house that Jack built.']
#    ]
#  end
#end


#class House
#  def self.recite
#    new.recite
#  end
#
#  def recite
#    verses = []
#
#    -1.downto(-pieces.size) do |idx|
#      verses << get_current_verse(idx)
#    end
#
#    verses.join("\n")
#  end
#
#  private
#
#  def get_current_verse(idx)
#    verse = []
#    verse.unshift(pieces[idx, -idx].map { |sub_arr| sub_arr.join("\n") })
#    verse.join(" ").prepend("This is ").strip << "\n"
#  end
#
#  def pieces
#    [
#      ['the horse and the hound and the horn', 'that belonged to'],
#      ['the farmer sowing his corn', 'that kept'],
#      ['the rooster that crowed in the morn', 'that woke'],
#      ['the priest all shaven and shorn', 'that married'],
#      ['the man all tattered and torn', 'that kissed'],
#      ['the maiden all forlorn', 'that milked'],
#      ['the cow with the crumpled horn', 'that tossed'],
#      ['the dog', 'that worried'],
#      ['the cat', 'that killed'],
#      ['the rat', 'that ate'],
#      ['the malt', 'that lay in'],
#      ['the house that Jack built.']
#    ]
#  end
#end

class House
  def self.recite
    new.recite
  end

  def recite
    verses = []

    -1.downto(-pieces.size) do |idx|
      verses << get_current_verse(idx)
    end

    verses.join("\n")
  end

  private

  def get_current_verse(idx)
    "This is " + process_pieces(idx)
  end

  def process_pieces(idx)
    pieces[idx, -idx].map do |sub_arr|
      if sub_arr.size == 1
	sub_arr[0] << "\n"
      else
	sub_arr.map.with_index do |elem, idx|
	  elem << (idx.even? ? "\n" : " ")
	end	
      end
    end.join
  end

  def pieces
    [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built.']
    ]
  end
end
