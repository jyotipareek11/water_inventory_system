class Product < ActiveRecord::Base
	# has_many :order_products
	# has_many :orders, :through => :order_products
	# has_many :sale_products
	# has_many :sales, :through => :sale_products
	has_one :inventory, :dependent => :destroy
	has_many :invoice_products
	has_many :invoices, :through => :invoice_products#, :dependent => :destroy
	
	validates :name, presence: true, uniqueness: true

	def available_products(user_id)
		product_inventory = Inventory.find_by_user_id_and_product_id(user_id,self.id)
		return product_inventory.quantity - blocked_products(user_id)
	end

	def self.available_products(user_id)
		available_products = []
		for product in Product.all do
			product_inventory = Inventory.find_or_create_by_user_id_and_product_id(user_id,product.id)
			available_quantity =  product_inventory.quantity - product.blocked_products(user_id)
			if(available_quantity > 0)
				available_products << product
			end	
			
		end 
		return available_products
	end

	def blocked_products(user_id)
		blocked_no_of_unit = 0
		blocked = self.invoice_products.where("state=? and user_id=?",'blocked',user_id ).to_a
		if blocked
			for product in blocked do
				blocked_no_of_unit = blocked_no_of_unit +product.no_of_unit
			end
		end
		return blocked_no_of_unit
	end		
end
