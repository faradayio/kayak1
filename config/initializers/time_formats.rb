# date_with_day_name:      Monday, February 27
Date::DATE_FORMATS[:date_with_day_name] = '%A, %B %d, %Y'
Date::DATE_FORMATS[:slashes] = '%m/%d/%Y'

# simple_time: 11:00am
DateTime::DATE_FORMATS[:simple_time] = "%I:%M%p"
Time::DATE_FORMATS[:simple_time] = "%I:%M%p"
Date::DATE_FORMATS[:simple_time] = "%I:%M%p"
