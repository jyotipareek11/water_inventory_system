class InvoiceProduct < ActiveRecord::Base
	belongs_to :invoice
	belongs_to :product
	belongs_to :user
	before_create :set_user
	before_validation :set_price
	after_create :update_associations
	# after_create :update_inventory

	
	states = %w[blocked delivered ordered instock] 
	after_initialize :init

	
	validates :product_id, presence: {message: "^Please Select product" }
	validates :no_of_unit, presence: {message: "^Must have at least 1 no of unit" }, numericality: {greater_than: 0, only_integer: true, message: "^No of Unit Must be greater then 0" }
	validates :unit_price, presence: {message: "^Must have unit price" }, numericality: {greater_than: 0, message: "^Unit Price Must be greater then 0" }
	validates :total_price, presence: {message: "^Must have total price" }, numericality: {greater_than: 0, message: "^Total Price Must be greater then 0" }
	validate :quantity_of_product

	attr_accessor :from

    def init
      self.no_of_unit  ||= 0
      self.total_price  ||= 0   
      self.discount  ||= 0   
      self.price_after_discount  ||= 0 
      self.unit_price ||=0  
    end

    def quantity_of_product
    	if self.from == 'sale'
			quantity_in_inventory = self.product_id ? Product.find_by_id(self.product_id).available_products(self.user_id) : 0
    		errors.add(:base, "^Inventory does not has this much quantity .. we only have "+quantity_in_inventory.to_s+" units in stock") if self.no_of_unit > quantity_in_inventory
    	end 	
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


	def set_price
		self.total_price = self.no_of_unit * self.unit_price
		self.price_after_discount = self.total_price - self.discount
	end	

	def set_user
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
