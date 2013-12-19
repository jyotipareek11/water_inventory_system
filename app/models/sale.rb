class Sale < ActiveRecord::Base
	belongs_to :location, :foreign_key => "location_id"
	belongs_to :distributor, -> { where "role = 'distributor'" }, :class_name => "User", :foreign_key => "distributor_id", dependent: :destroy
	belongs_to :user
	
	has_one :invoice, :as=> :invoiceable, :dependent => :destroy
	
	accepts_nested_attributes_for :invoice
	# has_many :sale_products
	# has_many :products, :through => :sale_products, :dependent => :destroy

	# accepts_nested_attributes_for :sale_products, :reject_if => lambda { |a| a[:no_of_unit].blank? }, :allow_destroy => true
end
