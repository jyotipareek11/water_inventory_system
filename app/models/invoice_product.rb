class InvoiceProduct < ActiveRecord::Base
	belongs_to :invoice
	belongs_to :product
	belongs_to :user
	before_create :add_user
	after_create :update_associations
	# after_create :update_inventory
	states = %w[blocked delivered ordered instock] 
	after_initialize :init


	validates :product_id, presence: {message: "Please Select product" }
	validates :no_of_unit, :unit_price,:total_price, presence: true
	validates :no_of_unit, :unit_price,:total_price, numericality: {greater_than: 0, only_integer: true}

    def init
      self.no_of_unit  ||= 0
      self.total_price  ||= 0   
      self.discount  ||= 0   
      self.price_after_discount  ||= 0   
    end

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
