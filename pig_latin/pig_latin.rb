# Non-regex solution
#class PigLatin
#  CONSONANT_SOUNDS = %w(b ch c d f g h j k l m n p qu q r sch squ sq s thr th t v w x y z)
#  VOWEL_SOUNDS = %w(a e i o u xr yt) 
#
#  def self.translate(phrase)
#    starts_with_vowel = false
#    
#    phrase.split.map do |word|
#      VOWEL_SOUNDS.each do |sound|
#        starts_with_vowel = true if word.start_with?(sound)
#      end
#      
#      starts_with_vowel ? word + 'ay' : process_consonant(word)
#    end.join(' ')
#  end
#  
#  def self.process_consonant(word)
#    starting_sound = nil
#    CONSONANT_SOUNDS.each do |sound|
#      starting_sound = sound if word.start_with?(sound)
#      break if starting_sound
#    end
#    word.delete_prefix(starting_sound) + starting_sound + 'ay'
#  end
#end

# Regex solution
class PigLatin
  def self.translate(phrase)
    phrase.split.map { |word| translate_word(word) }.join(' ')
  end

  def self.translate_word(word)
    if begins_with_vowel_sound?(word)
      word + 'ay'
    else
      consonant_sound, the_rest_of_word = parse_for_consonant(word)
      the_rest_of_word + consonant_sound + 'ay'
    end
  end

  def self.begins_with_vowel_sound?(word)
    word.match(/\A[aeiou]|[xy][^aeiou]/)
  end

  def self.parse_for_consonant(word)
    consonant_split = /\A([^aeiou]*qu|[^aeiou]+)([aeiou].*)\z/.match(word)
    [consonant_split[1], consonant_split[2]]
  end

end
