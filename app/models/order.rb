class Order < ActiveRecord::Base
	# has_many :order_products
	# has_many :products, :through => :order_products, :dependent => :destroy
	# belongs_to :sale

	# accepts_nested_attributes_for :order_products, :reject_if => lambda { |a| a[:no_of_unit].blank? }, :allow_destroy => true
end
