class PurchaseOrder < ActiveRecord::Base
	belongs_to :vendor, foreign_key: "vendor_id"
end
