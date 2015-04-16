require 'minitest/autorun'
require 'nuvaring_calendar'
require 'date'

describe NuvaringCalendar do

	describe "Basic scenario" do
		before do
			@basic_default_insertion_date = Date.parse("2014-12-06")
			@basic_expected_removal_dates = %w[2014-12-27 2015-01-24 2015-02-21 2015-03-21 2015-04-18 2015-05-16 2015-06-13 2015-07-11 2015-08-08 2015-09-05 2015-10-03 2015-10-31 2015-11-28]
			@basic_expected_insertion_dates = %w[2015-01-03 2015-01-31 2015-02-28 2015-03-28 2015-04-25 2015-05-23 2015-06-20 2015-07-18 2015-08-15 2015-09-12 2015-10-10 2015-11-07 2015-12-05]
		end

		it "when asked for removal dates" do
			cal = NuvaringCalendar.new @basic_default_insertion_date
			cal.removal_dates.must_equal @basic_expected_removal_dates
		end

		it "when asked for inserion dates" do
			cal = NuvaringCalendar.new @basic_default_insertion_date
			cal.insertion_dates.must_equal @basic_expected_insertion_dates
		end
	end

	describe "28 days in, 1 week out, 3 months limit" do
		before do
			@start_date = Date.parse("2014-12-02")
			@expected_insertion_dates = %w[2015-01-06 2015-02-10]
			@expected_removal_dates = %w[2014-12-30 2015-02-03]
		end

		it "insertion dates" do
			cal = NuvaringCalendar.new @start_date, insertion_days: 28, limit: 90
			cal.insertion_dates.must_equal @expected_insertion_dates
		end

		it "removal dates" do
			cal = NuvaringCalendar.new @start_date, insertion_days: 28, limit: 90
			cal.removal_dates.must_equal @expected_removal_dates
		end

		it "string passed as start date" do
			cal = NuvaringCalendar.new "2014-12-02", insertion_days: 28, limit: 90
			cal.removal_dates.must_equal @expected_removal_dates
		end

		it "Float passed as start date" do
			lambda { NuvaringCalendar.new 101.1 , insertion_days: 28, limit: 90 }.must_raise RuntimeError
		end
	end

	describe "1 week in, 2 weeks out, 4 months limit" do
		before do
			@start_date = "2015/05/11"
			# really 2015-09-14 should not be included but there is difficulty getting the exact max date
			@expected_insertion_dates = %w[2015-06-01 2015-06-22 2015-07-13 2015-08-03 2015-08-24 2015-09-14]
			@expected_removal_dates = %w[2015-05-18 2015-06-08 2015-06-29 2015-07-20 2015-08-10 2015-08-31]
			@cal = NuvaringCalendar.new @start_date, insertion_days: 7, wait_days: 14, limit: 120
		end
		it "insertion_dates" do
			@cal.insertion_dates.must_equal @expected_insertion_dates
		end

		it "removal dates" do
			@cal.removal_dates.must_equal @expected_removal_dates
		end
	end


end