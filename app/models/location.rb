class Location < ActiveRecord::Base
	
	# has_many :distributors, :class_name => "User", :foreign_key => "location_id", :conditions => "role = 'distributer'" 
	has_many :distributors, -> 	{ where "role = 'distributor'" }, :class_name => "User", :foreign_key => "location_id", dependent: :destroy
	has_many :sales, :dependent => :destroy
	before_save :add_modifier_detail
	
	validates :name, presence: true

	private
	def add_modifier_detail
		# if !self.new_record?
		# 	self.modified_date = Time.now
		# end
	end	
end
