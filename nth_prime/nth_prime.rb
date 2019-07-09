# Needs to handle large input -> need a good algorithm
# get it working for small input

# Works for small input
#class Prime
#  def self.nth(int)
#    raise ArgumentError unless int.instance_of?(Integer) && int >= 1
#    primes = []
#    candidate = 2
#    
#    while primes.size < int
#      primes << candidate if (2..candidate - 1).none? { |n| candidate % n == 0 } 
#      candidate += 1
#    end
#
#    primes.last
#  end
#end

class Prime
  def self.nth(int)
    raise ArgumentError unless int.instance_of?(Integer) && int >= 1
    primes = [2]
    candidate = 3
    
    while primes.size < int
      primes << candidate if (2..Math.sqrt(candidate)).none? { |n| candidate % n == 0 } 
      candidate += 2
    end

    primes.last
  end
end
