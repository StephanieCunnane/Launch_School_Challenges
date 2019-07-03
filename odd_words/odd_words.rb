# Consider a character set consisting of letters, a space, and a point. Words
# consist of one or more, but at most 20 characters. An input text consists of
# one or more words separated from each other by one or more spaces and
# terminated by 0 or more spaces followed by a point. Input should be read from,
# and including, the first letter of the first word, up to and including the
# terminating point. The output text is to be produced such that successive
# words are separated by a single space with the last word being terminated by a
# single point. Odd words are copied in reverse order while even words are
# merely echoed. 
#
# Ex:
# "whats the matter with kansas." -> "whats eht matter htiw kansas."
#
# BONUS: the characters must be read and printed one at a time
#
# input - one string
# output - one string of the same length
# rules
#     explicit requirements
#         return the given string with the odd words reversed
#         0-based indexing
#     implicit requirements
#         return a new string object?
#         input validation?
#         don't move the point to the front of the word
#
# mental model:
# split, then map with index
#
#def odd_words(phrase)
#  phrase.split.map.with_index do |word, idx|
#    has_dot = word[-1] == '.'
#    no_dot = has_dot ? word[0..-2] : word
#    if idx.odd?
#      has_dot ? no_dot.reverse + '.' : word.reverse
#    else
#      word
#    end
#  end.join(' ')
#end
#
def odd_words(phrase)
  phrase[0..-2].split.map.with_index do |word, idx|
    idx.odd? ? word.reverse : word
  end.join(' ') + '.'  
end

p odd_words("whats the matter with kansas.") == "whats eht matter htiw kansas."
p odd_words('hello.') == 'hello.'
p odd_words('hello      .') == 'hello.'
p odd_words('hello world.') == 'hello dlrow.'
p odd_words('hello       world          .') == 'hello dlrow.'

# Bonus exercise
#
# ideas:
#   print char
#   a flag variable to know if it's odd or not

# Steps
# 1) word = ''
# 2) odd_word = false
# 3) each_char
# 4) previous_char = nil
# 5) case statement for char
#     /[a-z]/i -> push to word
#     /' '/ && previous_char == ' '
#     /' '/
#     /\./
#
# Maybe I just accept that this will be an ugly solution?
def odd_words(phrase)
  word = ''
  odd_word = false
  previous_char = nil

  phrase.each_char.with_index do |char, idx|
    case char
    when /[a-z]/i
      word << char
      previous_char = char
    when ' '
      unless previous_char == ' '
        if phrase[idx + 1] == '.'
          print "#{odd_word ? word.reverse : word}"
        else
          print "#{odd_word ? word.reverse : word} "
        end
        word = ''
        previous_char = char
        odd_word = !odd_word
      end
    when '.'
      print "#{odd_word ? word.reverse : word}."
    end
  end
end

odd_words("whats the matter with kansas.") 
puts
odd_words('hello.') == 'hello.'
puts
odd_words('hello      .') == 'hello.'
puts
odd_words('hello world.') == 'hello dlrow.'
puts
odd_words('hello       world          .') == 'hello dlrow.'
