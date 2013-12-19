class InvoiceProduct < ActiveRecord::Base
	belongs_to :invoice
	belongs_to :product
	after_create :update_invoice

	
	def update_invoice
		invoice.update_vaalues(no_of_unit,total_price,discount,price_after_discount)		
	end	

end
