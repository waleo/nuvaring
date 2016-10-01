About
------
This gem calculates future insertion and removal dates for Nuvaring Birth Control. All possible usage patterns are supported.

Usage
-----
    require 'nuvaring_calendar'
    nuva = NuvaringCalendar.new("2015/06/20", swap_times: 2)
    nuva.timeline

Options
-------
NuvaringCalendar class takes the following options:

    :insertion_days Number of days to insert the nuva ring. Default 21.
    :wait_days Number of days to wait after removing the nuva ring. Default 7.
    :swap_times Number of times to keep replacing nuvaring with a new one before :wait_days. 1 swap time period == 1 x :insertion_days. Default 0.
    :limit  For how many days into the future beyond default_insertion_date should we compute? Default 365.

Examples ( 3 weeks in , 1 week off)
------------------------------------------

Give insertion date
    
    nuva = NuvaringCalendar.new("2015/12/12")

Returns and tags all future removal and insertion dates, limit 1.year from today.

    remove 1.1.2015
    insert 1.7.2015
    remove 1.21.2015
    insert 1.27.2015

