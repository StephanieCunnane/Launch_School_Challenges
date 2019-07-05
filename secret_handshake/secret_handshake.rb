# input - one decimal integer OR one binary string
# output - one array of strings, representing the sequence of events in a
# #secret handshake
#
# rules
#     explicit requirements
#        given a decimal, convert it to binary to decode the events
#        strings that aren't a valid binary number -> 0, which -> []
#
#   9 as a decimal is 1001
#
# mental model
# guard clause
# @decimal.to_s(2).chars
# result arr
# ifs
# return result

#class SecretHandshake
#  def initialize(decimal)
#    @decimal = decimal
#  end
#
#  def commands
#    if @decimal.instance_of?(Integer)
#      events = @decimal.to_s(2).chars
#    elsif @decimal.chars.all?(/[01]/)
#      events = @decimal.chars
#    else
#      return []
#    end
#
#    result = []
#    events.unshift(nil) until events.size == 5
#
#    result.unshift('jump') if events[1] == '1'
#    result.unshift('close your eyes')if events[2] == '1'
#    result.unshift('double blink') if events[3] == '1'
#    result.unshift('wink') if events[4] == '1'
#
#    events[0] == '1' ? result.reverse : result
#  end
#end

# different mental model:
# select.with_index and iterate through an EVENTS constant array

#class SecretHandshake
#  EVENTS = ['wink', 'double blink', 'close your eyes', 'jump'].freeze
#
#  def initialize(decimal)
#    @decimal = decimal
#  end
#
#  def commands
#    if @decimal.instance_of?(Integer)
#      secret_handshake = @decimal.to_s(2).chars.reverse
#    elsif @decimal.chars.all?(/[01]/)
#      secret_handshake = @decimal.chars.reverse
#    else
#      return []
#    end
#
#    reverse_the_handshake = secret_handshake.size == 5 && secret_handshake[-1] == '1'
#
#    result = secret_handshake.map.with_index do |digit, idx|
#      EVENTS[idx] if digit == '1'
#    end.compact
#
#    reverse_the_handshake ? result.reverse : result
#  end
#end

class SecretHandshake
  EVENTS = ['wink', 'double blink', 'close your eyes', 'jump'].freeze

  def initialize(number)
    @secret_handshake_bits = format(number)
  end

  def commands
    secret_handshake = @secret_handshake_bits.map.with_index do |digit, idx|
      EVENTS[idx] if digit == '1'
    end.compact

    reverse_the_handshake? ? secret_handshake.reverse : secret_handshake
  end

  private

  def format(number)
    if number.instance_of?(Integer)
      number.to_s(2).chars.reverse
    elsif number.chars.all?(/[01]/)
      number.chars.reverse
    else
      [0]
    end
  end

  def reverse_the_handshake?
    @secret_handshake_bits.size == 5 && @secret_handshake_bits[-1] == '1'
  end
end
