class Purchase < ActiveRecord::Base
	belongs_to :vendor, foreign_key: "vendor_id"
	# belongs_to :product, foreign_key: "product_id"
	belongs_to :user
	has_one :invoice, :as=> :invoiceable, :dependent => :destroy
	
	accepts_nested_attributes_for :invoice, :reject_if => :all_blank, :allow_destroy => true

	#after_save :update_inventory
	states = %w[ordered received] 

	def update_associations(current_user,vendor)
		self.vendor = vendor
    	self.added_by = current_user.id
    	self.invoice.user = self.user = current_user
    end 

	def is_ordered?
		state == "ordered"
	end

	def update_state_and_inventory
		# update Purchase state
		update_attribute("state", "received")

		for product in invoice.invoice_products do
			# update invoice_products's item state
			product.update_state_to_received
			# update inventory
			inventory = Inventory.where(:user_id =>invoice.user.id, :product_id => product.product_id).first_or_create
			inventory.quantity = inventory.quantity == nil ? product.no_of_unit : inventory.quantity + product.no_of_unit
			inventory.save!	
		end			
	end	

	# private

	# def update_inventory
	# 	inventory = Inventory.find_by_product_id(self.product_id) || Inventory.new(:product_id => self.product_id)
	# 	inventory.quantity = inventory.quantity == nil ? self.no_of_unit : inventory.quantity + self.no_of_unit
	# 	 # self.product.update_attribute("qty", (product.qty - self.qty))
	# 	inventory.save!
	# end		

end
