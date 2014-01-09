class Sale < ActiveRecord::Base
	belongs_to :location, :foreign_key => "location_id"
	# has_one :distributor, -> { where "role = 'distributor'" }, :class_name => "User", :foreign_key => "distributor_id"#, dependent: :destroy
	belongs_to :distributor, -> { where "role = 'distributor'" }, :class_name => "User", :foreign_key => "distributor_id"#, dependent: :destroy
	belongs_to :user
	has_one :invoice, :as=> :invoiceable, :dependent => :destroy
    belongs_to :client	
	after_create :create_purchase_for_distributor
	accepts_nested_attributes_for :invoice,:reject_if => :all_blank, :allow_destroy => true

    attr_accessor :user_role
    validate :sale_attributes

    scope :delivered, -> { where(state: 'delivered') } 
    scope :order_initiated, -> { where(state: 'order_initiated') }

	states = %w[order_initiated delivered]  

    def sale_attributes
       if self.user_role == 'admin'
            errors.add(:base,"Please select Distributor") unless self.distributor_id.present?
            errors.add(:base,"Please select Location") unless self.location_id.present?
        elsif self.user_role == 'distributor' && self.user.role == 'distributor'
            errors.add(:base,"Please select Client") unless self.client_id.present?
        end            
    end        

	def is_order_initiated?
		state == "order_initiated"
	end

	def update_associations(current_user)
		self.added_by = current_user.id
    	self.invoice.user = self.user = current_user
    end

    def is_ordered?
        state == "order_initiated"
    end

    def update_state_to_delivered
    	update_attribute("state", "delivered")
		self.save!
		for product in invoice.invoice_products do
			# update invoice_products's item state
			product.update_state_to_delivered 
			# update inventory
			inventory = Inventory.where(:user_id =>invoice.user.id, :product_id => product.product_id).first_or_create
			inventory.quantity = inventory.quantity == nil ? product.no_of_unit : inventory.quantity - product.no_of_unit
			inventory.save!	
		end	
	end 

    def update_state_and_inventory
        update_state_to_delivered
    end   	

    private

    def create_purchase_for_distributor
    	if (self.user.is_admin?)
    		distributor = self.distributor
    		distributor_purchase = distributor.purchases.create!(:added_by=>27,:state=>'ordered',:user_id=>distributor.id,:parent_sale_id=>self.id)
    		#create invoice for Purchase
    		distributor_invoice = distributor_purchase.build_invoice
    		distributor_invoice.user = distributor
    		distributor_invoice.save!
    		# create invoice_products for respective invoice with state ordered
    		invoice_products = self.invoice.invoice_products
    		for invoice_product in invoice_products do
    			d_invoice_product = distributor_invoice.invoice_products.new(:no_of_unit=>invoice_product.no_of_unit,
    				:product_id => invoice_product.product_id,
    				:unit_price => invoice_product.unit_price,
    				:total_price => invoice_product.total_price,
    				:discount => invoice_product.discount,
    				:price_after_discount => invoice_product.price_after_discount,
    				:state => 'ordered',
    				:user_id => distributor.id
    				)
    			d_invoice_product.save!
    		end
    	end
	end

	
end
