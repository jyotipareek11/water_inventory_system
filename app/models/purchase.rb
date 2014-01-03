class Purchase < ActiveRecord::Base
	belongs_to :vendor, foreign_key: "vendor_id"
	# belongs_to :product, foreign_key: "product_id"
	belongs_to :user
	has_one :invoice, :as=> :invoiceable, :dependent => :destroy
	#validates :invoice, presence: true	
	accepts_nested_attributes_for :invoice, :reject_if => :all_blank, :allow_destroy => true
	
	# validates :invoice, presence: true
	scope :purchase_ordered, -> { where(state: 'ordered') }
	scope :purchase_received, -> { where(state: 'received')}
	# scope :distributors_order, ->{where('vendor_id IS NULL')}

	states = %w[ordered received] 



	#validate :must_have_children

  	def must_have_children
    	if invoice or invoice.all? {|i| i.marked_for_destruction? }
      		errors.add(:base, 'Must have at least one child')
    	end
    	for p in invoice.invoice_products do
    		errors.add(:base, 'Must have at least one child') if p.no_of_unit<= 0
    	end
    	 
  	end

	def update_associations(current_user,vendor)
		self.vendor = vendor
    	self.added_by = current_user.id
    	self.invoice.user = self.user = current_user
    end 

	def is_ordered?
		state == "ordered"
	end

	def self.distributors_order
		where('vendor_id IS NULL')
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
