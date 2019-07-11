# Focus on generating the next row, not deriving the previous one.
# First and last are always 1
# Row 1 has 1 element, row 2 has 2 elements, etc
# each_cons(2), so 1, each_cons, each_cons, 1

class Triangle
  def initialize(row_count)
    @row_count = row_count
    @pascals_triangle = []
  end

  def rows
    1.upto(@row_count) do |current_row|
      @pascals_triangle << case current_row
			   when 1 then [1]
                           when 2 then [1, 1]
                           else
			     middle = @pascals_triangle.last.each_cons(2).map(&:sum)
	                     [1] + middle + [1]
                           end
    end
    @pascals_triangle
  end
end
