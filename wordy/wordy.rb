# pieces:
# parse string into an array
# ArgumentError
# running_total
# sending operator
#
#class WordProblem
#  def initialize(word_problem)
#    @word_problem = parse(word_problem)
#  end
#
#  def answer
#    while @word_problem.size > 1
#      @word_problem[0..2] = evaluate(@word_problem[0..2])
#    end
#    @word_problem[0]
#  end
#
#  private
#
#  def parse(word_problem)
#    raise ArgumentError unless word_problem.scan(/-?\d+/).size >= 2
#    arr = word_problem[8..-2].split.map do |elem|
#      elem.match(/-?\d+/) ? elem.to_i : elem
#    end
#    arr.delete('by')
#    arr
#  end
#
#  def evaluate(expression)
#    operator = case expression[1]
#	       when 'plus' then :+
#	       when 'minus' then :-
#	       when 'multiplied' then :*
#               else :/
#	       end
#    expression[0].send(operator, expression[-1])
#  end
#end

class WordProblem
  def initialize(word_problem)
    @expression = parse(word_problem)
  end

  def answer
    while @expression.size > 1
      @expression[0..2] = evaluate(@expression[0..2])
    end
    @expression[0]
  end

  private

  def parse(word_problem)
    raise ArgumentError unless word_problem.scan(/-?\d+/).size >= 2

    arr = word_problem[8..-2].split.map do |elem|
      case elem
      when /-?\d+/ then elem.to_i
      when 'by' then nil
      when 'plus' then :+
      when 'minus' then :-
      when 'multiplied' then :*
      when 'divided' then :/
      end
    end.compact
  end

  def evaluate(expression)
    expression[0].send(expression[1], expression[-1])
  end
end
