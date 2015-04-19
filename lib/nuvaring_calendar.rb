class NuvaringCalendar
	def initialize(default_insertion_date,options={})
		@default_insertion_date = default_insertion_date
		@calculator = NuvaringCalendar::Calculator.new @default_insertion_date, options
	end

	def insertion_dates
		@calculator.insertion_dates.map(&:to_s)
	end

	def removal_dates
		@calculator.removal_dates.map(&:to_s)
	end

	def swap_dates
		@calculator.swap_dates.map(&:to_s)
	end

	def timeline
		@calculator.timeline
	end
end

require 'nuvaring_calendar/calculator'