#class Queens
#  attr_reader :white, :black
#
#  def initialize(white: [0, 3], black: [7, 3])
#    raise ArgumentError if black == white
#    @white = white
#    @black = black
#    @board = generate_board
#  end
#
#  def attack?
#    same_row = @white.first == @black.first
#    same_column = @white.last == @black.last
#    same_diagonal = (@white.first - @black.first).abs == (@white.last - @black.last).abs
#
#    same_row || same_column || same_diagonal
#  end
#
#  # string representation of the blank board
#  def to_s
#    @board.map { |row| row.join(' ') }.join("\n")
#  end
#
#  private
#
#  # start by making an 8x8 grid where each cell is _
#  def generate_board
#    board = Array.new(8) { Array.new(8)  { '_' } }
#    board[@white.first][@white.last] = 'W'
#    board[@black.first][@black.last] = 'B'
#    board
#  end
#end

#class Queens
#  attr_reader :white, :black
#
#  def initialize(white: [0, 3], black: [7, 3])
#    raise ArgumentError if black == white
#    @white = white
#    @black = black
#    @board = generate_board
#  end
#
#  def attack?
#    same_row? || same_column? || same_diagonal?
#  end
#
#  def to_s
#    @board.map { |row| row.join(' ') }.join("\n")
#  end
#
#  private
#
#  def generate_board
#    board = Array.new(8) { Array.new(8)  { '_' } }
#    board[@white.first][@white.last] = 'W'
#    board[@black.first][@black.last] = 'B'
#    board
#  end
#
#  def same_row?
#    @white.first == @black.first
#  end
#
#  def same_column?
#    @white.last == @black.last
#  end
#
#  def same_diagonal?
#    (@white.first - @black.first).abs == (@white.last - @black.last).abs
#  end
#end

# make the white and black coordinates into Structs
class Queens
  class Coordinates < Struct.new(:x, :y); end

  def initialize(white: [0, 3], black: [7, 3])
    raise ArgumentError if black == white
    @white_queen_coordinates = Coordinates.new(*white)
    @black_queen_coordinates = Coordinates.new(*black)
    @board = initialize_board
  end

  def white
    @white_queen_coordinates.to_a
  end

  def black
    @black_queen_coordinates.to_a
  end

  def attack?
    same_row? || same_column? || same_diagonal?
  end

  def to_s
    @board.map { |row| row.join(' ') }.join("\n")
  end

  private

  def initialize_board
    board = Array.new(8) { Array.new(8)  { '_' } }
    board[@white_queen_coordinates.x][@white_queen_coordinates.y] = 'W'
    board[@black_queen_coordinates.x][@black_queen_coordinates.y] = 'B'
    board
  end

  def same_row?
    @white_queen_coordinates.x == @black_queen_coordinates.x
  end

  def same_column?
    @white_queen_coordinates.y == @black_queen_coordinates.y
  end

  def same_diagonal?
    (@white_queen_coordinates.x - @black_queen_coordinates.x).abs \
      == (@white_queen_coordinates.y - @black_queen_coordinates.y).abs
  end
end

