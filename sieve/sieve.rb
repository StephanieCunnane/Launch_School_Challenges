class Sieve
  def initialize(limit)
    raise ArgumentError unless limit.instance_of?(Integer) && limit >= 2
    @limit = limit
  end

  def primes
    nums = (2..@limit).to_a
    nums.each do |num|
      nums.delete_if { |n| n != num && n % num == 0 }
    end
  end
end

# Initial solution
# def primes
#   nums = {}
#   (2..@limit).each { |key| nums[key] = true }
#   nums.each_key do |key| 
#     next unless nums[key]
#     ((key + 1)..@limit).each do |k|
#       nums[k] = false if k % key == 0
#     end
#   end
#   nums.select { |_k, v| v }.keys
# end

