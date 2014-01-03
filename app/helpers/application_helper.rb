module ApplicationHelper

	def long_date_format datetime
		return datetime.strftime('%a %b %d, at %I:%M %p ')
	end		

	def local_time_zone datetime
		return datetime.in_time_zone("Mumbai")
	end		

	def display_error_block object
		str =""
		if object.errors.full_messages.any? 
    		str = 	"<div id='error_explanation'>"
      		str +=	"<h2>"+ pluralize(object.errors.count.to_s,'error')+" prohibited this post from being saved:</h2>"
      		str += 	"<ul>"
        	object.errors.full_messages.each do |error_msg|
        		str += 	"<li>"+ error_msg +"</li>"
        	end
      		str += 	"</ul> "
    		str += 	"</div>"
		end
		return str.html_safe
	end	


	def display_error_block_for_purchase_and_sale object
		str =""
		if object.errors.full_messages.any? 
    		str = 	"<div id='error_explanation'>"
      		str +=	"<h2>"+ pluralize(object.errors.count.to_s,'error')+" prohibited this post from being saved:</h2>"
      		str += 	"<ul>"
        	object.errors.full_messages.each do |error_msg|
        		str += 	"<li>"+ error_msg +"</li>"
        	end
      		str += 	"</ul> "
    		str += 	"</div>"
		end
		return str.html_safe
	end


end
