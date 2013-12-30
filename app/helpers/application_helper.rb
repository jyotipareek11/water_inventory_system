module ApplicationHelper

	def long_date_format datetime
		return datetime.strftime('%a %b %d, at %I:%M %p ')
	end		

	def local_time_zone datetime
		return datetime.in_time_zone("Mumbai")
	end		
end
