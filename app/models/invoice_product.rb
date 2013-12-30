class InvoiceProduct < ActiveRecord::Base
	belongs_to :invoice
	belongs_to :product
	belongs_to :user
	before_create :add_user
	after_create :update_associations
	# after_create :update_inventory
	states = %w[blocked delivered ordered instock] 

	def update_state_to_received
		update_attribute("state", "instock")
		self.save!
	end

	def update_state_to_delivered
		update_attribute("state", "delivered")
		self.save!
	end		

	private

	def add_user
		self.user = self.invoice.user
	end		

	def update_associations
		# set_state
		update_invoice
		#update_inventory		
		#update_distributor_or_client
	end

	

	def update_invoice
		self.invoice.update_values(no_of_unit,total_price,discount,price_after_discount)		
	end	


	def update_inventory
		type = invoice.invoiceable_type
		inventory = Inventory.where(:user_id =>invoice.user.id, :product_id => self.product.id).first_or_create
		if(type == 'Purchase')
			inventory.quantity = inventory.quantity == nil ? self.no_of_unit : inventory.quantity + self.no_of_unit
		elsif(type == 'Sale')
			inventory.quantity = inventory.quantity == nil ? 0 : inventory.quantity - self.no_of_unit
		end
		inventory.save!	
	end

	def update_distributor_or_client
		

	end	

end
