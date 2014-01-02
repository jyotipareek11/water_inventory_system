class Inventory < ActiveRecord::Base
	belongs_to :product, foreign_key: "product_id"
	belongs_to :user

	after_initialize :init

    def init
      self.quantity  ||= 0
    end
end
