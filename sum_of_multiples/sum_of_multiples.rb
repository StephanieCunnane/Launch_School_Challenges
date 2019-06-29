class SumOfMultiples
  def self.to(limit)
    new(3, 5).to(limit)
  end
  
  def initialize(*factors)
    @factors = factors
  end

  def to(limit)
    (1...limit).select do |int|
      @factors.any? { |factor| int % factor == 0 }
    end.sum
  end
end
  
# Initial solution
# def to(limit)
#   multiples = []
#   (1...limit).each do |int|
#     @factors.each do |factor|
#       multiples << int if int % factor == 0 
#     end
#   end
#   multiples.uniq.sum
# end
