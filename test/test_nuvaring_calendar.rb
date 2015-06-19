require 'minitest/autorun'
require 'nuvaring_calendar'
require 'date'

describe NuvaringCalendar do

	describe "Basic scenario" do
		before do
			@basic_default_insertion_date = Date.parse("2014-12-06")
			@basic_expected_removal_dates = %w[2014-12-27 2015-01-24 2015-02-21 2015-03-21 2015-04-18 2015-05-16 2015-06-13 2015-07-11 2015-08-08 2015-09-05 2015-10-03 2015-10-31 2015-11-28]
			@basic_expected_insertion_dates = %w[2014-12-06 2015-01-03 2015-01-31 2015-02-28 2015-03-28 2015-04-25 2015-05-23 2015-06-20 2015-07-18 2015-08-15 2015-09-12 2015-10-10 2015-11-07 2015-12-05]
			@basic_expected_timeline = {"2014-12-06" => "insert", "2014-12-27" => "remove", "2015-01-03" => "insert", "2015-01-24" => "remove", "2015-01-31" => "insert", "2015-02-21" => "remove", "2015-02-28" => "insert",
																	"2015-03-21" => "remove", "2015-03-28" => "insert", "2015-04-18" => "remove", "2015-04-25" => "insert", "2015-05-16" => "remove", "2015-05-23" => "insert",
																	"2015-06-13" => "remove", "2015-06-20" => "insert", "2015-07-11" => "remove", "2015-07-18" => "insert", "2015-08-08" => "remove", "2015-08-15" => "insert",
																	"2015-09-05" => "remove", "2015-09-12" => "insert", "2015-10-03" => "remove", "2015-10-10" => "insert", "2015-10-31" => "remove", "2015-11-07" => "insert",
																	"2015-11-28" => "remove", "2015-12-05" => "insert" }

			@cal = NuvaringCalendar.new @basic_default_insertion_date
		end

		it "when asked for removal dates" do
			@cal.removal_dates.must_equal @basic_expected_removal_dates
		end

		it "when asked for inserion dates" do
			@cal.insertion_dates.must_equal @basic_expected_insertion_dates
		end

		it "when asked for time line" do
			@cal.timeline.must_equal @basic_expected_timeline
		end
	end

	describe "28 days in, 1 week out, 3 months limit" do
		before do
			@start_date = Date.parse("2014-12-02")
			@expected_insertion_dates = %w[2014-12-02 2015-01-06 2015-02-10]
			@expected_removal_dates = %w[2014-12-30 2015-02-03]
			@expected_timline = {"2014-12-02" => "insert", "2014-12-30" => "remove", "2015-01-06" => "insert", "2015-02-03" => "remove", "2015-02-10" => "insert" }

			@cal = NuvaringCalendar.new @start_date, insertion_days: 28, limit: 90
		end

		it "insertion dates" do
			@cal.insertion_dates.must_equal @expected_insertion_dates
		end

		it "removal dates" do
			@cal.removal_dates.must_equal @expected_removal_dates
		end

		it "string passed as start date" do
			@cal.removal_dates.must_equal @expected_removal_dates
		end

		it "Float passed as start date" do
			lambda { NuvaringCalendar.new 101.1 , insertion_days: 28, limit: 90 }.must_raise RuntimeError
		end

		it "timeline" do
			@cal.timeline.must_equal @expected_timline
		end
	end

	describe "1 week in, 2 weeks out, 4 months limit" do
		before do
			@start_date = "2015/05/11"
			# really 2015-09-14 should not be included but there is difficulty getting the exact max date
			@expected_insertion_dates = %w[2015-05-11 2015-06-01 2015-06-22 2015-07-13 2015-08-03 2015-08-24 2015-09-14]
			@expected_removal_dates = %w[2015-05-18 2015-06-08 2015-06-29 2015-07-20 2015-08-10 2015-08-31]
			@expected_timline = {"2015-05-11" => "insert", "2015-05-18" => "remove", "2015-06-01" => "insert", "2015-06-08" => "remove", "2015-06-22" => "insert",
													 "2015-06-29" => "remove", "2015-07-13" => "insert", "2015-07-20" => "remove", "2015-08-03" => "insert",
													 "2015-08-10" => "remove", "2015-08-24" => "insert", "2015-08-31" => "remove", "2015-09-14" => "insert"}

			@cal = NuvaringCalendar.new @start_date, insertion_days: 7, wait_days: 14, limit: 120
		end
		it "insertion_dates" do
			@cal.insertion_dates.must_equal @expected_insertion_dates
		end

		it "removal dates" do
			@cal.removal_dates.must_equal @expected_removal_dates
		end

		it "timeline" do
			@cal.timeline.must_equal @expected_timline
		end
	end

	describe "3 weeks in, swap 3 times, 1 week out" do
		before do
			@start_date = "2014-12-01"
			@expected_insertion_dates = %w[2014-12-01 2015-03-02 2015-06-01]
			@expected_removal_dates = %w[2015-02-23 2015-05-25]
			@expected_swap_dates = %w[2014-12-22 2015-01-12 2015-02-02 2015-03-23 2015-04-13 2015-05-04]
			@expected_timeline = {"2014-12-01" => "insert", "2014-12-22" => "swap", "2015-01-12" => "swap", "2015-02-02" => "swap", "2015-02-23" => "remove", "2015-03-02" => "insert",
			 						 					"2015-03-23" => "swap", "2015-04-13" => "swap", "2015-05-04" => "swap", "2015-05-25" => "remove", "2015-06-01" => "insert"}
			
			@cal = NuvaringCalendar.new @start_date, swap_times: 3, limit: 180
		end

		it "insertion dates" do
			@cal.insertion_dates.must_equal @expected_insertion_dates
		end

		it "removal dates" do
			@cal.removal_dates.must_equal @expected_removal_dates
		end

		it "swap dates" do
			@cal.swap_dates.must_equal @expected_swap_dates
		end

		it "timeline" do
			@cal.timeline.must_equal @expected_timeline
		end
	end

end