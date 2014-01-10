class Inventory < ActiveRecord::Base
	belongs_to :product, foreign_key: "product_id"
	belongs_to :user

	after_initialize :init

    def init
      self.quantity  ||= 0
    end

    def self.to_csv(options = {})
    	CSV.generate(options) do |csv|
      		csv << column_names
      		all.each do |product|
        		csv << product.attributes.values_at(*column_names)
      		end
    	end
  	end
end
