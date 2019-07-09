# Is it a 12-hr or 24-hr clock?
# 24-hr clock
#
# I should work on the ::at method first
# Looks like we DON'T need to do input validation
#
# input - one or two positive integers representing hours and minutes
# output - one Clock object
# rules
#   

#class Clock
#  def self.at(hours=0, minutes=0)
#    extra_hours, minutes = minutes.divmod(60)
#    hours = (extra_hours + hours) % 24
#    new(hours, minutes)
#  end
#
#  def initialize(hours=0, minutes=0)
#    @hours = hours
#    @minutes = minutes
#  end
#
#  def +(mins_to_add)
#    self.class.at(@hours, @minutes + mins_to_add)
#  end
#
#  def -(mins_to_subtract)
#    self.class.at(@hours, @minutes - mins_to_subtract)
#  end
#
#  def ==(other_clock)
#    hours == other_clock.hours && minutes == other_clock.minutes
#  end
#
#  def to_s
#    format("%02d:%02d", @hours, @minutes)
#  end
#
#  protected
#
#  attr_reader :hours, :minutes
#end

#class Clock
#  MINUTES_PER_HOUR = 60
#  HOURS_PER_DAY = 24
#
#  def self.at(hours=0, minutes=0)
#    extra_hours, minutes = minutes.divmod(MINUTES_PER_HOUR)
#    hours = (extra_hours + hours) % HOURS_PER_DAY
#    new(hours, minutes)
#  end
#
#  def initialize(hours=0, minutes=0)
#    @hours = hours
#    @minutes = minutes
#  end
#
#  def +(mins_to_add)
#    self.class.at(@hours, @minutes + mins_to_add)
#  end
#
#  def -(mins_to_subtract)
#    self.class.at(@hours, @minutes - mins_to_subtract)
#  end
#
#  def ==(other_clock)
#    to_s == other_clock.to_s
#  end
#
#  def to_s
#    format("%02d:%02d", @hours, @minutes)
#  end
#end
#
class Clock
  MINUTES_PER_HOUR = 60
  HOURS_PER_DAY = 24

  def self.at(hours=0, minutes=0)
    new(hours, minutes)
  end

  def initialize(hours=0, minutes=0)
    @hours, @minutes = normalize_time(hours, minutes)
  end

  def +(mins_to_add)
    self.class.new(@hours, @minutes + mins_to_add)
  end

  def -(mins_to_subtract)
    self.class.new(@hours, @minutes - mins_to_subtract)
  end

  def ==(other_clock)
    to_s == other_clock.to_s
  end

  def to_s
    format("%02d:%02d", @hours, @minutes)
  end
  
  private
  
  def normalize_time(hours, minutes)
    extra_hours, minutes = minutes.divmod(MINUTES_PER_HOUR)
    hours = (extra_hours + hours) % HOURS_PER_DAY
    [hours, minutes]
  end
end
