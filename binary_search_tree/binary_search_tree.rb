#class Bst
#  attr_reader :data, :left, :right
#
#  def initialize(data)
#    @data = data
#  end
#
#  def insert(new_value)
#    case new_value <=> data
#    when -1, 0 
#      @left.nil? ? @left = self.class.new(new_value) : @left.insert(new_value)
#    else 
#      @right.nil? ? @right = self.class.new(new_value) : @right.insert(new_value)
#    end
#  end
#
#  # visit each value and yield that value
#  # recursive method
#  def each
#    return to_enum unless block_given?
#    @left&.each { |item| yield(item) }
#    yield(@data)
#    @right&.each { |item| yield(item) }
#  end
#end

#class Bst
#  attr_reader :data, :left, :right
#
#  def initialize(root)
#    @data = root
#  end
#
#  def insert(new_value)
#    case new_value <=> data
#    when -1, 0 
#      left.nil? ? @left = self.class.new(new_value) : left.insert(new_value)
#    else 
#      right.nil? ? @right = self.class.new(new_value) : right.insert(new_value)
#    end
#  end
#
#  def each
#    return to_enum unless block_given?
#
#    left.each { |node| yield(node) } if left
#    yield(data)
#    right.each { |node| yield(node) } if right
#  end
#end

class Bst
  attr_reader :data, :left, :right

  def initialize(root)
    @data = root
  end

  def insert(new_value)
    case new_value <=> data
    when -1, 0 
      left&.insert(new_value) || @left = self.class.new(new_value)
    else 
      right&.insert(new_value) || @right = self.class.new(new_value)
    end
  end

  def each
    return to_enum unless block_given?

    left.each { |node| yield(node) } if left
    yield(data)
    right.each { |node| yield(node) } if right
  end
end
