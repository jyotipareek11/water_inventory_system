class Purchase < ActiveRecord::Base
	belongs_to :vendor, foreign_key: "vendor_id"
	belongs_to :product, foreign_key: "product_id"


	after_save :update_inventory


	private

	def update_inventory
		inventory = Inventory.find_by_product_id(self.product_id) || Inventory.new(:product_id => self.product_id)
		inventory.quantity = inventory.quantity == nil ? self.no_of_unit : inventory.quantity + self.no_of_unit
		inventory.save!
	end		

end
