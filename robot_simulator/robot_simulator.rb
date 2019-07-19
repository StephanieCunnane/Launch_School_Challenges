#class Robot
#  attr_writer :orientation
#
#  ORIENTATIONS = [:north, :east, :south, :west].freeze
#
#  def orient(direction)
#    raise ArgumentError unless ORIENTATIONS.include?(direction)
#    @orientation = direction
#  end
#
#  def bearing
#    @orientation
#  end
#
#  def turn_right
#    idx = ORIENTATIONS.index(@orientation)
#    @orientation = ORIENTATIONS[(idx + 1) % 4]
#  end
#
#  def turn_left
#    idx = ORIENTATIONS.index(@orientation)
#    @orientation = ORIENTATIONS[(idx - 1) % 4]
#  end
#
#  def at(x, y)
#    @x, @y = x, y
#  end
#
#  def coordinates
#    [@x, @y]
#  end
#
#  def advance
#    case @orientation
#    when :north then @y += 1
#    when :east then @x += 1
#    when :south then @y -= 1
#    when :west then @x -= 1
#    end
#  end
#end
#
#class Simulator
#  def instructions(command_str)
#    command_str.chars.map do |char|
#      case char
#      when 'L' then :turn_left
#      when 'R' then :turn_right
#      when 'A' then :advance
#      end
#    end
#  end
#
#  def place(robot, x: 0, y: 0, direction: :north)
#    robot.at(x, y)
#    robot.orientation = direction
#  end
#
#  def evaluate(robot, command_str)
#    instructions(command_str).each do |command|
#      robot.send(command)
#    end
#  end
#end

class Robot
  attr_accessor :bearing

  ORIENTATIONS = [:north, :east, :south, :west].freeze

  def orient(direction)
    raise ArgumentError unless ORIENTATIONS.include?(direction)
    @bearing = direction
  end

  def turn_right
    idx = ORIENTATIONS.index(@bearing)
    @bearing = ORIENTATIONS[(idx + 1) % 4]
  end

  def turn_left
    idx = ORIENTATIONS.index(@bearing)
    @bearing = ORIENTATIONS[(idx - 1) % 4]
  end

  def at(x, y)
    @x, @y = x, y
  end

  def coordinates
    [@x, @y]
  end

  def advance
    case @bearing
    when :north then @y += 1
    when :east then @x += 1
    when :south then @y -= 1
    when :west then @x -= 1
    end
  end
end

class Simulator
  def instructions(command_str)
    command_str.chars.map do |char|
      case char
      when 'L' then :turn_left
      when 'R' then :turn_right
      when 'A' then :advance
      end
    end
  end

  def place(robot, x: 0, y: 0, direction: :north)
    robot.at(x, y)
    robot.bearing = direction
  end

  def evaluate(robot, command_str)
    instructions(command_str).each do |command|
      robot.send(command)
    end
  end
end

