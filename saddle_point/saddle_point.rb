# A matrix saddle point:
#    cell >= all other elements in the row
#    cell <= all other elements in the column

# the saddle point will be represented by an array of 2 ints (the coordinates)

class Matrix
  attr_reader :rows

  def initialize(input)
    @rows = build_matrix(input)
    @row_maxes = calculate_row_maxes
    @column_mins = calculate_column_mins
  end

  def columns
    rows.transpose
  end

  def saddle_points
    result = []
    rows.each_with_index do |row, x|
      row.each_with_index do |element, y|
	result << [x, y] if element == @row_maxes[x] && element == @column_mins[y]
      end
    end
    result
  end

  private

  def build_matrix(input)
    input.split("\n").map { |row| row.split.map(&:to_i) }
  end

  def calculate_row_maxes
    rows.map(&:max)
  end

  def calculate_column_mins
    columns.map(&:min)
  end
end
