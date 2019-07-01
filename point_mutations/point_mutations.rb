class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(other_strand)
    effective_length = [@strand.size, other_strand.size].min
    effective_length.times.count do |idx|
      @strand[idx] != other_strand[idx]
    end
  end
end

# def hamming_distance(other_strand)
#   pairs = @strand.chars.zip(other_strand.chars).delete_if { |pair| pair.include?(nil) }
#   pairs.count { |pair| pair.uniq.size == 2 }
# end 
  
# def hamming_distance(other_strand)
#   shorter_strand, longer_strand = [@strand, other_strand].sort_by(&:size)
#   count = 0
#   shorter_strand.chars.each_with_index do |elem, idx|
#     count += 1 if elem != longer_strand[idx]
#   end
#   count
# end

# def hamming_distance(other_strand)
#   shorter_strand, longer_strand = [@strand, other_strand].sort_by(&:size)
#   idx = 0
#   shorter_strand.chars.reduce(0) do |count, elem|
#     count += 1 unless longer_strand[idx] == elem
#     idx += 1
#     count
#   end
# end
