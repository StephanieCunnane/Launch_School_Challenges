# Given the month/year and the meetup schedule, I need to produce a Date object
# for when the meetup will be held
#
# input - to the constructor: 2 integers, representing a month and year
#         to #day: 2 symbols, the first represents a day of the week, the second
#         represesnts the schedule (one of :teenth, :first, :second, :third,
#         :fourth, :last)
#
# output - one Date object, representing the date of the meetup for the given
# month/year
#
# mental model:
# #day is missing one number (the day) - 
#
# this is a problem where I manipulate Date objects
# get all the Date objects for the month, then iterate through them with select
#
# 1) Get all Date objects for the month
#    all_days = []
#    date = Date.new(@year, @month, 1)
#    1.upto(31) { |da }

# 2) get an array of all the days that are the required weekday
#    # send is the answer, but that's too risky
#
# 3) 

#require 'date'
#
#class Meetup
#  def initialize(month, year)
#    @month = month
#    @year = year
#  end
#
#  def day(weekday, schedule)
#    target_weekday = get_all_target_weekdays(weekday)
#    get_meetup_date(target_weekday, schedule)
#  end
#
#  private
#
#  def get_all_days
#    all_days = []
#    date = Date.new(@year, @month, 1)
#    1.upto(31) do |day|
#      all_days << date
#      date += 1
#    end
#    all_days.select { |date| date.month == @month }
#  end
#
#  def get_all_target_weekdays(weekday)
#    get_all_days.select { |date| date.send(weekday.to_s + '?') }
#  end
#
#  def get_meetup_date(weekdays, schedule)
#    case schedule
#    when :first then weekdays[0]
#    when :second then weekdays[1]
#    when :third then weekdays[2]
#    when :fourth then weekdays[3]
#    when :last then weekdays.last
#    when :teenth
#      teens = (13..19).to_a
#      weekdays.select { |date| teens.include?(date.day) }.first
#    end
#  end
#end
#################################################################
#  def get_all_target_weekdays(weekday)
#    #get_all_days.select do |date|
#    #  case weekday
#    #  when :monday then date.monday?
#    #  when :tuesday then date.tuesday?
#    #  when :wednesday then date.wednesday?
#    #  when :thursday then date.thursday?
#    #  when :friday then date.friday?
#    #  when :saturday then date.saturday?
#    #  when :sunday then date.sunday?
#    #  end
#    #end
#
#    get_all_days.select { |date| date.send(weekday.to_s + '?') }
#  end
# 
# Treat last as a special case
#require 'date'
#
#class Meetup
#  DAY_CLASSIFICATIONS = {
#    first: 1..7,
#    second: 8..14,
#    teenth: 13..19,
#    third: 15..21,
#    fourth: 22..28,
#  }
#
#  def initialize(month, year)
#    @month = month
#    @year = year
#  end
#
#  def day(weekday, schedule)
#    days = DAY_CLASSIFICATIONS[schedule] || get_range_of_last_week
#
#    days.each do |day|
#      date = Date.new(@year, @month, day)
#      return date if date.public_send(weekday.to_s + '?')
#    end
#  end
#
#  private
#
#  def get_range_of_last_week
#    days_in_month = 1
#    date = Date.new(@year, @month, 1)
#    while date.month == @month
#      date += 1
#      days_in_month += 1
#    end
#    (days_in_month - 7)..days_in_month
#  end
#end
#
# Treat last as a special case
#require 'date'
#
#class Meetup
#  DAY_CLASSIFICATIONS = {
#    first: 1..7,
#    second: 8..14,
#    teenth: 13..19,
#    third: 15..21,
#    fourth: 22..28
#  }
#
#  def initialize(month, year)
#    @month = month
#    @year = year
#  end
#
#  def day(weekday, schedule)
#    days = DAY_CLASSIFICATIONS[schedule] || get_range_of_last_week
#
#    days.each do |day|
#      date = Date.new(@year, @month, day)
#      return date if date.public_send(weekday.to_s + '?')
#    end
#  end
#
#  private
#
#  def get_range_of_last_week
#    days_in_month = 1
#    date = Date.new(@year, @month, 1)
#    while date.month == @month
#      date += 1
#      days_in_month += 1
#    end
#    (days_in_month - 7)..days_in_month
#  end
#end

#require 'date'
#
#class Meetup
#  DAY_CLASSIFICATIONS = {
#    first: 1..7,
#    second: 8..14,
#    teenth: 13..19,
#    third: 15..21,
#    fourth: 22..28
#  }
#
#  def initialize(month, year)
#    @month = month
#    @year = year
#  end
#
#  def day(weekday, schedule)
#    days = DAY_CLASSIFICATIONS[schedule] || get_range_of_last_week
#
#    days.each do |day|
#      date = Date.new(@year, @month, day)
#      return date if date.public_send(weekday.to_s + '?')
#    end
#  end
#
#  private
#
#  def get_range_of_last_week
#    days_in_month = Date.new(@year, @month, -1).day
#    (days_in_month - 6)..days_in_month
#  end
#end
#

#require 'date'
#
#class Meetup
#  DAY_CLASSIFICATIONS = {
#    first: 1,
#    second: 8,
#    teenth: 13,
#    third: 15,
#    fourth: 22
#  }
#
#  def initialize(month, year)
#    @month = month
#    @year = year
#  end
#
#  def day(weekday, schedule)
#    starting_day = DAY_CLASSIFICATIONS[schedule] || get_start_of_last_week
#
#    starting_day.upto(starting_day + 6) do |day|
#      date = Date.new(@year, @month, day)
#      return date if date.public_send(weekday.to_s + '?')
#    end
#  end
#
#  private
#
#  def get_start_of_last_week
#    days_in_month = Date.new(@year, @month, -1).day
#    days_in_month - 6
#  end
#end

# WEEK_START_DAYS
require 'date'

class Meetup
  WEEK_START_DAYS = {
    first: 1,
    second: 8,
    teenth: 13,
    third: 15,
    fourth: 22,
    last: -7
  }.freeze

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, schedule)
    starting_day = WEEK_START_DAYS[schedule] 

    starting_day.upto(starting_day + 6) do |day|
      date = Date.new(@year, @month, day)
      return date if date.public_send(weekday.to_s + '?')
    end
  end
end
