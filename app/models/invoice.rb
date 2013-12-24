class Invoice < ActiveRecord::Base
	belongs_to :user
	belongs_to :invoiceable, :polymorphic => true
	
	has_many :invoice_products
	has_many :products, :through => :invoice_products, :dependent => :destroy

	accepts_nested_attributes_for :invoice_products, :reject_if => :all_blank, :allow_destroy => true


   	after_initialize :init

    def init
      self.no_of_unit  ||= 0
      self.total_price  ||= 0   
      self.discount  ||= 0   
      self.price_after_discount  ||= 0   
      self.received ||= false
    end



	def update_values(p_no_of_unit,p_total_price,p_discount,p_price_after_discount)	
		update_attributes(no_of_unit: (self.no_of_unit + p_no_of_unit),
						 total_price: (self.total_price + p_total_price), 
						 discount: (self.discount + p_discount), 
						 price_after_discount: (self.price_after_discount.to_f + p_price_after_discount.to_f)
						 )
	end	
end
