# Let's create a singly linked list to contain the range 1..10 and provide
# methods to reverse a linked list and convert to and from arrays
#
# So each Element object will have 2 instance variables:
#   @value
#   @next_node

#class Element
#  attr_reader :datum, :next
#
#  def initialize(datum, next_node=nil)
#    @datum = datum
#    @next = next_node
#  end
#
#  def tail?
#    @next.nil?
#  end
#end
#
## custom collection class
#class SimpleLinkedList
#  attr_reader :head
#
#  # takes an array and needs to return a new SimpleLinkedList object
#  def self.from_a(arr)
#    arr = [] if arr.nil?
#    arr = arr.dup
#
#    list = SimpleLinkedList.new
#    # pop from the arr and push to the linked list
#    list.push(arr.pop) until arr.empty?
#    list
#  end
#
#  def empty?
#    head.nil?
#  end
#
#  def size
#    list_size = 0
#    current_node = @head
#    while current_node
#      list_size += 1
#      current_node = current_node.next
#    end
#    list_size
#  end
#
#  # create a new Element object with the datum arg
#  # @head always points to the most recently added element
#  def push(datum)
#    @head = Element.new(datum, @head)
#  end
#
#  def pop
#    old_head = @head.datum
#    @head = @head.next
#    old_head
#  end
#
#  # look at the head's data unless head is nil
#  # @head.datum if @head
#  def peek
#    @head&.datum
#  end
#
#  # self.class.from_a(to_a.reverse)
#  # pop from the original linked list and push to a new linked list
#  def reverse
#    list = SimpleLinkedList.new
#    list.push(pop) until empty?
#    list
#  end
#
#  def to_a
#    arr = []
#    current_node = head
#    while current_node
#      arr << current_node.datum
#      current_node = current_node.next
#    end
#    arr
#  end
#end

class Element
  attr_reader :datum, :next

  def initialize(datum, next_node=nil)
    @datum = datum
    @next = next_node
  end

  def tail?
    @next.nil?
  end

  def <=>(other_node)
    datum <=> other_node.datum
  end
end

class SimpleLinkedList
  include Enumerable

  attr_reader :head

  def self.from_a(arr)
    arr = [] if arr.nil?
    arr = arr.dup

    list = new
    list.push(arr.pop) until arr.empty?
    list
  end

  def empty?
    head.nil?
  end

  def each
    return to_enum unless block_given?

    current_node = head
    while current_node
      yield(current_node)
      current_node = current_node.next
    end

    self
  end

  def size
    list_size = 0
    each { list_size += 1 }
    list_size
  end

  def push(datum)
    @head = Element.new(datum, @head)
  end

  def pop
    old_head = @head.datum
    @head = @head.next
    old_head
  end

  def peek
    @head&.datum
  end

  def reverse
    list = SimpleLinkedList.new
    each { |node| list.push(node.datum) }
    list
  end

  def to_a
    arr = []
    each { |current_node| arr << current_node.datum }
    arr
  end
end
