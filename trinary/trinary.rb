class Trinary
  def initialize(trinary_str)
    @trinary_str = trinary_str
  end
  
  def to_decimal
    return 0 if @trinary_str.match(/[^012]/)
    @trinary_str.to_i.digits.map.with_index do |digit, idx|
      digit * 3**idx
    end.sum
  end
end

# Hexadecimal challenge
# class Hexadecimal
#   DIGITS = {
#     '0' => 0,
#     '1' => 1,
#     '2' => 2,
#     '3' => 3,
#     '4' => 4,
#     '5' => 5,
#     '6' => 6,
#     '7' => 7,
#     '8' => 8,
#     '9' => 9,
#     'a' => 10,
#     'b' => 11,
#     'c' => 12,
#     'd' => 13,
#     'e' => 14,
#     'f' => 15
#   }.freeze
#     
#   def initialize(hex_str)
#     @hex_str = hex_str.downcase
#   end
#   
#   def to_decimal
#     return 0 if @hex_str.match(/[^0-9a-z]/)
#     digits = @hex_str.chars.map { |char| DIGITS[char] }
#     digits.reverse.map.with_index do |digit, idx|
#       digit * 16**idx
#     end.sum
#   end
# end
# 
# p Hexadecimal.new('af445').to_decimal == 717893
