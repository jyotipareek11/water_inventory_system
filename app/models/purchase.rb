class Purchase < ActiveRecord::Base
	belongs_to :vendor, foreign_key: "vendor_id"
	# belongs_to :product, foreign_key: "product_id"
	belongs_to :user
	has_one :invoice, :as=> :invoiceable, :dependent => :destroy
	
	accepts_nested_attributes_for :invoice, :reject_if => :all_blank, :allow_destroy => true

	
	scope :purchase_ordered, -> { where(state: 'ordered') }
	scope :purchase_received, -> { where(state: 'received')}

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
		purchase_user = self.user
		if (purchase_user.is_distributor?)		
			# update respective sale state to dispatched and invoice_products state to delivered
			parent_sale = Sale.find(self.parent_sale_id)
			parent_sale.update_state_to_delivered
		end
		return true				
	end	

end
