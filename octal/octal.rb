class Octal
  def initialize(octal_str)
    @octal_str = octal_str
  end

  def to_decimal
    return 0 if @octal_str.match(/[^0-7]/)
    @octal_str.to_i.digits.map.with_index do |digit, idx|
      digit * 8**idx
    end.sum
  end
end

# Initial solution
# def to_decimal
#   return 0 if @octal_str.match(/[^01234567]/) || @octal_str == '0'
#   decimal_value = 0
#   @octal_str.chars.reverse.each_with_index do |digit, idx|
#     decimal_value += (digit.to_i * 8**idx)
#   end
#   decimal_value
# end
#
# Second solution
# def to_decimal
#   return 0 if @octal_str.match(/[^0-7]/) || @octal_str == '0'
#   @octal_str.chars.reverse.map.with_index do |digit, idx|
#     digit.to_i * 8**idx
#   end.sum
# end

