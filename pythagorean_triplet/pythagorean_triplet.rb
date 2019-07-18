class Triplet
  def self.where(min_factor: 1, max_factor: 10, sum: nil)
    all_combos = [*min_factor..max_factor].combination(3).map { |combo| new(*combo) }

    all_combos.select do |combo|
      if sum
        (combo.sum == sum) && combo.pythagorean?
      else
	combo.pythagorean?
      end	
    end
  end

  def initialize(a, b, c)
    @triplet_candidate = [a, b, c]
  end

  def sum
    @triplet_candidate.sum
  end

  def product
    @triplet_candidate.reduce(:*)
  end

  def pythagorean?
    powers = @triplet_candidate.map { |n| n**2 }
    powers[0] + powers[1] == powers[2]
  end
end
