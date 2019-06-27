class Series
  def initialize(digits)
    @digits = digits
  end
  
  def slices(n)
    raise ArgumentError, 'Slice size cannot exceed string size' if n > @digits.size

    slices = []

    slice_count = @digits.size - n + 1
    slice_count.times { |idx| slices << @digits[idx, n] }
    slices.map { |substr| substr.chars.map(&:to_i) }
  end
end
