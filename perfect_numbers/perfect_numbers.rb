#class PerfectNumber
#  def self.classify(int)
#    unless int.instance_of?(Integer) && int.positive?
#      raise RuntimeError, "Input must be a positive integer" 
#    end
#
#    factors = []
#    (1...int).each do |divisor|
#      factors << divisor if int % divisor == 0
#    end
#
#    case factors.sum
#    when int then 'perfect'
#    when 0...int then 'deficient'
#    else 'abundant'
#    end
#  end
#end

#class PerfectNumber
#  def self.classify(int)
#    unless int.instance_of?(Integer) && int.positive?
#      raise RuntimeError, "Input must be a positive integer" 
#    end
#
#    sum_of_factors = factors_for(int).sum
#
#    case sum_of_factors
#    when int then 'perfect'
#    when 0...int then 'deficient'
#    else 'abundant'
#    end
#  end
#
#  def self.factors_for(int)
#    factors = []
#    (1...int).each do |divisor|
#      factors << divisor if int % divisor == 0
#    end
#    factors
#  end
#end


#class PerfectNumber
#  def self.classify(int)
#    unless int.instance_of?(Integer) && int.positive?
#      raise RuntimeError, "Input must be a positive integer" 
#    end
#
#    sum_of_factors = factors_for(int).sum
#
#    case sum_of_factors
#    when int then 'perfect'
#    when 0...int then 'deficient'
#    else 'abundant'
#    end
#  end
#
#  def self.factors_for(int)
#    (1...int).reduce([]) do |factors, divisor|
#      factors << divisor if int % divisor == 0
#      factors
#    end
#  end
#end

#class PerfectNumber
#  def self.classify(int)
#    unless int.instance_of?(Integer) && int.positive?
#      raise RuntimeError, "Input must be a positive integer" 
#    end
#
#    sum_of_factors = factors_for(int)
#
#    case sum_of_factors
#    when int then 'perfect'
#    when 0...int then 'deficient'
#    else 'abundant'
#    end
#  end
#
#  def self.factors_for(int)
#    (1..int / 2).reduce do |sum, divisor|
#      int % divisor == 0 ? sum + divisor : sum
#    end
#  end
#end

#class PerfectNumber
#  def self.classify(int)
#    unless int.instance_of?(Integer) && int.positive?
#      raise RuntimeError, "Input must be a positive integer" 
#    end
#
#    sum_of_factors = factors_for(int).sum
#
#    case int <=> sum_of_factors
#    when 0 then 'perfect'
#    when 1 then 'deficient'
#    else 'abundant'
#    end
#  end
#
#  def self.factors_for(int)
#    (1..int / 2).select { |divisor| int % divisor == 0 }
#  end
#end
#
class PerfectNumber
  def self.classify(int)
    unless int.instance_of?(Integer) && int.positive?
      raise RuntimeError, "Input must be a positive integer" 
    end

    sum_of_factors = factors_for(int).sum

    case sum_of_factors
    when int then 'perfect'
    when 0...int then 'deficient'
    else 'abundant'
    end
  end

  def self.factors_for(int)
    (1..int / 2).select { |divisor| int % divisor == 0 }
  end
end
