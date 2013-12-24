class Sale < ActiveRecord::Base
	belongs_to :location, :foreign_key => "location_id"
	belongs_to :distributor, -> { where "role = 'distributor'" }, :class_name => "User", :foreign_key => "distributor_id", dependent: :destroy
	belongs_to :user
	
	has_one :invoice, :as=> :invoiceable, :dependent => :destroy
	
	accepts_nested_attributes_for :invoice,:reject_if => :all_blank, :allow_destroy => true

	states = %w[order_initiate delivered]  

	
end
