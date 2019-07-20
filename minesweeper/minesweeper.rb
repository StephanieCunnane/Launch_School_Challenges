# +-----+
# |1*3*1|
# |13*3 |
# | 2*2 |
# |     |
# +-----+

class ValueError < ArgumentError; end

class Board
  def self.transform(input)
    new(input).transform
  end

  def initialize(input)
    fail ValueError unless valid?(input)
    @input = input
  end

  def transform
    @input.map.with_index do |row, x|
      row.chars.map.with_index do |cell, y|
	cell == ' ' ? count_mines(x, y) : cell
      end.join
    end
  end

  private

  def count_mines(x, y)
    mine_count = [@input[x][y - 1],
		  @input[x][y + 1],
       
                  @input[x - 1][y],
                  @input[x + 1][y],

                  @input[x - 1][y - 1],
                  @input[x + 1][y + 1],

                  @input[x - 1][y + 1],
                  @input[x + 1][y - 1]].count('*')
    
    mine_count.zero? ? ' ' : mine_count
  end

  def valid?(input)
    sizes_equal = input.uniq { |str| str.size }.size == 1
    borders_correct = [input.first, input.last].all?(/\A\+-*\+\z/)
    middle_pieces_correct = input[1..-2].all?(/\A\|[ *]+\|\z/)

    sizes_equal && borders_correct && middle_pieces_correct
  end
end
