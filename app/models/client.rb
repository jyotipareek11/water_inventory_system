class Client < ActiveRecord::Base
	belongs_to :user, -> { where "role = 'distributor'" }, foreign_key: "distributor_id"#, dependent: :destroy#, -> { where "role = 'distributer'" }
	validates :name,:email_id,:mobile_no, presence: true
	validates :mobile_no,:land_line_number,:pin, numericality: { only_integer: true }
	after_initialize :init
	scope :active, ->{where(is_active: true)}


	def init
      self.name  ||= ""
    end

    def make_inactive
		update_attribute("is_active",false)
		self.save!
	end	
	
end
