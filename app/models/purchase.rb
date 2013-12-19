class Purchase < ActiveRecord::Base
	belongs_to :vendor, foreign_key: "vendor_id"
	# belongs_to :product, foreign_key: "product_id"
	belongs_to :user
	has_one :invoice, :as=> :invoiceable, :dependent => :destroy
	
	accepts_nested_attributes_for :invoice #, :reject_if => lambda { |a| a[:no_of_unit].blank? }, :allow_destroy => true

	#after_save :update_inventory


	private

	def update_inventory
		inventory = Inventory.find_by_product_id(self.product_id) || Inventory.new(:product_id => self.product_id)
		inventory.quantity = inventory.quantity == nil ? self.no_of_unit : inventory.quantity + self.no_of_unit
		 # self.product.update_attribute("qty", (product.qty - self.qty))
		inventory.save!
	end		

end
