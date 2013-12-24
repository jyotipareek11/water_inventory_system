class Product < ActiveRecord::Base
	# has_many :order_products
	# has_many :orders, :through => :order_products
	# has_many :sale_products
	# has_many :sales, :through => :sale_products
	has_one :inventory, :dependent => :destroy
	has_many :invoice_products
	has_many :invoices, :through => :invoice_products#, :dependent => :destroy
	
end
