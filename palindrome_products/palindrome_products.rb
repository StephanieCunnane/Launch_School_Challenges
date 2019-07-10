#class Palindromes
#  Palindrome = Struct.new(:value, :factors)
#
#  def initialize(max_factor: 999, min_factor: 1)
#    @max_factor = max_factor
#    @min_factor = min_factor
#    @all_palindromic_numbers = generate
#    @arr_of_palindrome_structs = make_arr_of_palindrome_structs
#  end
#
#  def generate
#    all_products = []
#    (@min_factor..@max_factor).each do |first_factor|
#      (first_factor..@max_factor).each { |second_factor| all_products << (first_factor * second_factor) }
#    end
#    all_products.uniq!
#
#    @all_palindromic_numbers = all_products.select { |num| palindrome?(num) }.sort
#  end
#
#  # has to return a new Palindrome struct
#  def smallest
#    @arr_of_palindrome_structs.first
#  end
#
#  # has to return a new Palindrome struct
#  def largest
#    @arr_of_palindrome_structs.last
#  end
#
#  private
#
#  def palindrome?(num)
#    num.to_s == num.to_s.reverse
#  end
#
#  def make_arr_of_palindrome_structs
#    @all_palindromic_numbers.map do |palindromic_num|
#      Palindrome.new(palindromic_num, build_up_factors(palindromic_num))
#    end
#  end
#
#  # get all the factors first - DONE
#  # get the pairs that multiply to the given palindromic number
#  # each int in all_factors can be multiplied by another int in all_factors
#  # (including itself as a possibility) to get the palindromic number
#  # there's a method to do this for me: #combination(2)
#  def build_up_factors(num)
#    all_factors = []
#    @min_factor.upto(@max_factor) do |possible_factor|
#      all_factors << possible_factor if num % possible_factor == 0
#    end
#    all_factors
#
#    result = all_factors.combination(2).select { |pair| pair.first * pair.last == num }
#    square_root = Math.sqrt(num)
#    result << [square_root, square_root] if all_factors.include?(square_root)
#    result
#  end
#end
# Am I recomputing anywhere?

class Palindromes
  Palindrome = Struct.new(:value, :factors)

  def initialize(max_factor: 999, min_factor: 1)
    @max_factor = max_factor
    @min_factor = min_factor
    @max_and_min_palindromic_numbers = generate
    @arr_of_palindrome_structs = make_arr_of_palindrome_structs
  end

  def generate
    all_products = []
    (@min_factor..@max_factor).each do |first_factor|
      (first_factor..@max_factor).each { |second_factor| all_products << (first_factor * second_factor) }
    end
    all_products.uniq!

    @max_and_min_palindromic_numbers = all_products.select { |num| palindrome?(num) }.sort.values_at(0, -1)
  end

  def smallest
    @arr_of_palindrome_structs.first
  end

  def largest
    @arr_of_palindrome_structs.last
  end

  private

  def palindrome?(num)
    num.to_s == num.to_s.reverse
  end

  def make_arr_of_palindrome_structs
    @max_and_min_palindromic_numbers.map do |palindromic_num|
      Palindrome.new(palindromic_num, build_up_factors(palindromic_num))
    end
  end

  def build_up_factors(num)
    all_factors = []
    @min_factor.upto(@max_factor) do |possible_factor|
      all_factors << possible_factor if num % possible_factor == 0
    end
    all_factors

    result = all_factors.combination(2).select { |pair| pair.first * pair.last == num }
    square_root = Math.sqrt(num)
    result << [square_root, square_root] if all_factors.include?(square_root)
    result
  end
end
