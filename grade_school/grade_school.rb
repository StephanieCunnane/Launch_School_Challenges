#class School
#  def initialize
#    @roster = Hash.new([])
#  end
#
#  def to_h
#    @roster.each { |_grade, students| students.sort! }.sort.to_h
#  end
#
#  def add(student, grade)
#    if @roster.key?(grade)
#      @roster[grade] << student
#    else
#      @roster[grade] = [student]
#    end
#  end
#
#  def grade(_grade)
#    @roster[_grade]
#  end
#end

class School
  def initialize
    @roster = Hash.new([])
  end

  def to_h
    @roster.each { |_grade, students| students.sort! }.sort.to_h
  end

  def add(student, grade)
    @roster[grade] += [student]
  end

  def grade(_grade)
    @roster[_grade]
  end
end
