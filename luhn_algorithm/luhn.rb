class Luhn
  def self.create(num)
    (0..9).each do |check_digit|
      candidate = (num.to_s + check_digit.to_s).to_i
      return candidate if new(candidate).valid?
    end
  end

  def initialize(num_to_verify)
    raise ArgumentError unless num_to_verify.instance_of?(Integer) && num_to_verify.positive?
    @num_to_verify = num_to_verify
  end

  def addends
    @num_to_verify.digits.map.with_index do |digit, idx|
      next digit if idx.even?

      doubled = digit * 2
      doubled < 10 ? doubled : doubled - 9
    end.reverse
  end

  def checksum
    addends.sum
  end

  def valid?
    checksum % 10 == 0
  end
end
