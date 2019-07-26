class Garden PLANT_KEY = {
    'G' => :grass,
    'C' => :clover,
    'R' => :radishes,
    'V' => :violets    
  }.freeze

  STUDENTS = %w(Alice Bob Charlie David Eve Fred Ginny 
                Harriet Ileana Joseph Kincaid Larry).freeze

  def initialize(input, students=STUDENTS)
    @outer_row, @inner_row = input.split
    @students = students.sort
    generate_student_methods
  end

  private

  def generate_student_methods
    @students.each do |student|
      define_singleton_method(student.downcase.to_sym) do
	plant_position = @students.index(student) * 2
	plant_str = @outer_row[plant_position, 2] + @inner_row[plant_position, 2]
        plant_str.chars.map { |char| PLANT_KEY[char] }
      end
    end
  end
end
