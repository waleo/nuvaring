class NuvaringCalendar
	class Calculator

		# Returns an [Array] containing all future insertion dates
		attr_reader :insertion_dates
		# Returns an [Array] containing all future removal dates
		attr_reader :removal_dates
		
		# @param default_insertion_date [Date || String] First date nuva ring was inserted 
		# @option options [Fixnum] :insertion_days Number of days to insert the nuva ring
		# @option options [Fixnum] :wait_days Number of days to wait after removing the nuva ring
		# @option options [Fixnum] :limit	For how many days into the future beyond default_insertion_date should we compute?
		def initialize(default_insertion_date, options={})
			@default_insertion_date = parse_date default_insertion_date
			@insertion_dates = []
			@removal_dates = []
			@insertion_days = options[:insertion_days] || 21
			@wait_days = options[:wait_days] || 7
			@limit = options[:limit] || 365
			compute
		end


		private

		# calculates all future dates
		def compute
			current_date = @default_insertion_date
			max = current_date + @limit - @insertion_days
			begin
				current_date += @insertion_days
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