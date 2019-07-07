class CircularBuffer
  class BufferEmptyException < IOError; end
  class BufferFullException < IOError; end

  def initialize(size)
    @size = size
    @buffer = Array.new(size)
    @read_idx = 0
    @write_idx = 0
  end

  def read
    raise BufferEmptyException if buffer_empty?
    value = @buffer[@read_idx]
    @buffer[@read_idx] = nil
    @read_idx = increment(@read_idx)
    value
  end

  def write(input)
    raise BufferFullException if buffer_full?
    write!(input)
  end

  def write!(input)
    return if input.nil?
    @read_idx = increment(@read_idx) if buffer_full?
    @buffer[@write_idx] = input
    @write_idx = increment(@write_idx)
  end

  def clear
    @buffer.fill(nil)
    @read_idx = 0
    @write_idx = 0
  end

  private

  def buffer_empty?
    @buffer.all?(&:nil?)
  end

  def buffer_full?
    @buffer.none?(&:nil?)
  end

  def increment(idx)
    (idx + 1) % @size
  end
end
