class Invoice < ActiveRecord::Base
	belongs_to :user
	belongs_to :invoiceable, :polymorphic => true
	
	has_many :invoice_products
	has_many :products, :through => :invoice_products, :dependent => :destroy
	#validates :invoice_products, presence: true
	accepts_nested_attributes_for :invoice_products, :reject_if => :all_blank, :allow_destroy => true
	validate :check_for_product_repetition

   	after_initialize :init

   #	validate :must_have_children

  	def must_have_children
    	if invoice_products.empty? or invoice_products.all? {|invoice_product| invoice_product.marked_for_destruction? }
      		errors.add(:base, 'Must have at least one invoice_products child')
    	end
  	end


    def init
      self.no_of_unit  ||= 0
      self.total_price  ||= 0   
      self.discount  ||= 0   
      self.price_after_discount  ||= 0   
      self.received ||= false
    end

    def check_for_product_repetition
    	product_ids =[]
    	self.invoice_products.map do |invoice_product|
    		product_ids << invoice_product.product_id
    	end
    	unless product_ids.uniq.length == product_ids.length
    		errors.add(:base, '^Product already selected in previous option. Please select different product for different option')
    	end	
    end	


	def update_values(p_no_of_unit,p_total_price,p_discount,p_price_after_discount)	
		update_attributes(no_of_unit: (self.no_of_unit + p_no_of_unit),
						 total_price: (self.total_price + p_total_price), 
						 discount: (self.discount + p_discount), 
						 price_after_discount: (self.price_after_discount.to_f + p_price_after_discount.to_f)
						 )
	end	
	
end
