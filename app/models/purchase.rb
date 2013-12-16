class Purchase < ActiveRecord::Base
	belongs_to :vendor, foreign_key: "vendor_id"
	belongs_to :product, foreign_key: "product_id"
end
