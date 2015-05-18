require 'date'
class NuvaringCalendar
	class Calculator

		# Returns an [Array] containing all future insertion dates
		attr_reader :insertion_dates
		# Returns an [Array] containing all future removal dates
		attr_reader :removal_dates
		# Returns an [Array] containing all future swap dates
		attr_reader :swap_dates
		
		# @param default_insertion_date [Date || String] First date nuva ring was inserted 
		# @option options [Fixnum] :insertion_days Number of days to insert the nuva ring. Default 21.
		# @option options [Fixnum] :wait_days Number of days to wait after removing the nuva ring. Default 7.
		# @option options [Fixnum] :swap_times Number of times to keep replacing nuvaring with a new one before :wait_days. 1 swap time period == 1 x :insertion_days. Default 0.
		# @option options [Fixnum] :limit	For how many days into the future beyond default_insertion_date should we compute? Default 365.
		def initialize(default_insertion_date, options={})
			@default_insertion_date = parse_date default_insertion_date
			@insertion_dates = []
			@removal_dates = []
			@swap_dates = []
			@insertion_days = options[:insertion_days] || 21
			@wait_days = options[:wait_days] || 7
			@limit = options[:limit] || 365
			@swap_times = options[:swap_times] || 0
			compute
		end

		def timeline
			insertion_hash = Hash.new { |hash, key| hash[key] = :insert }
			removal_hash = Hash.new { |hash, key| hash[key] = :remove }
			swap_hash = Hash.new { |hash, key| hash[key] = :swap }

			@insertion_dates.each do |d|
				insertion_hash[d]
			end
			@removal_dates.each do |d|
				removal_hash[d]
			end
			@swap_dates.each do |d|
				swap_hash[d]
			end
			array = (((insertion_hash.merge(removal_hash).merge(swap_hash)).sort).map { |element| element.map { |inner_element| inner_element.to_s}})
			Hash[array]
		end

		private

		# calculates all future dates
		def compute
			current_date = @default_insertion_date
			max = current_date + @limit - @insertion_days
			begin
				current_date += @insertion_days
				@swap_times.times do
					@swap_dates << current_date
					current_date += @insertion_days
				end
				@removal_dates << current_date
				current_date += @wait_days
				@insertion_dates << current_date
			end while current_date  <= max
		end

		def parse_date(date)
			if date.is_a? Date
				date
			elsif date.is_a? String
				Date.parse date
			else
				raise "Invalid insertion date, expecting Date or String"
			end
		end

	end
end