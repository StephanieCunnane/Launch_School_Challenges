#class Robot
#  @@all_robot_names = []
#
#  attr_accessor :name
#
#  def initialize
#    @name = generate_random_name
#  end
#  
#  # does reset mean @name should be nil? nope, problem description says reset
#  # gives a new name
#  def reset
#    @name = generate_random_name
#  end
#
#  private
#
#  def generate_random_name
#    upper = ('A'..'Z').to_a
#    digits = ('0'..'9').to_a
#    new_name = ''
#
#    loop do
#      2.times { new_name << upper.sample }
#      3.times { new_name << digits.sample }
#      break unless @@all_robot_names.include?(new_name)
#      new_name = ''
#    end
#    
#    @@all_robot_names << new_name
#
#    new_name
#  end
#end
#
# With class instance variables
#class Robot
#  @all_robot_names = []
#
#  attr_accessor :name
#
#  def self.all_robot_names
#    @all_robot_names
#  end
#
#  def initialize
#    @name = generate_random_name
#  end
#  
#  def reset
#    @name = generate_random_name
#  end
#
#  private
#
#  def generate_random_name
#    upper = ('A'..'Z').to_a
#    digits = ('0'..'9').to_a
#    new_name = ''
#
#    loop do
#      2.times { new_name << upper.sample }
#      3.times { new_name << digits.sample }
#      break unless self.class.all_robot_names.include?(new_name)
#      new_name = ''
#    end
#    
#    self.class.all_robot_names << new_name
#
#    new_name
#  end
#end
#
class Robot
  @@all_robot_names = []

  attr_accessor :name

  def initialize
    @name = generate_random_name
  end
  
  def reset
    initialize
  end

  private

  def generate_random_name
    new_name = ''

    loop do
      2.times { new_name << ('A'..'Z').to_a.sample }
      3.times { new_name << ('0'..'9').to_a.sample }
      break unless @@all_robot_names.include?(new_name)
      new_name = ''
    end
    
    @@all_robot_names << new_name

    new_name
  end
end
