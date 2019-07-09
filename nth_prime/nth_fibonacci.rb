#def nth_fibonacci(n)
#  first = 1
#  second = 1
#  current = nil
#
#  (n - 2).times do
#    current = first + second
#    first = second
#    second = current
#  end
#
#  current
#end

# Solve Fibonacci with an Enumerator
class Fibonacci
  def self.get_nth_fib(n)
    fib_enum = Enumerator.new do |yielder|
      first = 1
      second = 1
      loop do
	yielder << first
	first, second = second, first + second
      end
    end
    fib_enum.take(n).last
  end
end

p Fibonacci.get_nth_fib(5) == 5
p Fibonacci.get_nth_fib(6) == 8
p Fibonacci.get_nth_fib(7) == 13
p Fibonacci.get_nth_fib(70000) 


