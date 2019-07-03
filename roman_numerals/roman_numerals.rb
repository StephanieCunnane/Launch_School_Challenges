class Integer
  ROMAN_NUMERAL_RULES = {
    1000 => 'M',
    900  => 'CM',
    500  => 'D',
    400  => 'CD',
    100  => 'C',
    90   => 'XC',
    50   => 'L',
    40   => 'XL',
    10   => 'X',
    9    => 'IX',
    5    => 'V',
    4    => 'IV',
    1    => 'I'
  }
  
  def to_roman
    roman_numeral = ''
    remainder = self
    multipliers = []

    ROMAN_NUMERAL_RULES.each_key do |divisor|
      num, remainder = remainder.divmod(divisor)
      multipliers << num
    end
    
    multipliers.each_with_index do |multiplier, idx|
      roman_numeral << (ROMAN_NUMERAL_RULES.values[idx] * multiplier)
    end

    roman_numeral
  end
end

