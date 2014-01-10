class Vendor < ActiveRecord::Base
	belongs_to :user, foreign_key: "admin_id"#, -> { where "role = 'admin'" }#
	has_many :purchases

	validates :name, presence: true
	scope :active, ->{where(is_active: true)}

	def make_inactive
		update_attribute("is_active",false)
		self.save!
	end	
end
