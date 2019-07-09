class PhoneNumber
  def initialize(phone_num_str)
    @phone_num_str = phone_num_str
  end

  def number
    no_delimiters = @phone_num_str.gsub(/[()\-.\s]/, '')
    return '0000000000' unless no_delimiters.match(/\A1?\d{10}\z/)
    no_delimiters.slice!(0) if no_delimiters.size == 11
    no_delimiters
  end

  def area_code
    number[0..2]
  end

  def to_s
    "(#{number[0..2]}) #{number[3..5]}-#{number[6..9]}"
  end
end
