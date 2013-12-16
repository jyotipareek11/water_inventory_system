class Vendor < ActiveRecord::Base
	belongs_to :user, -> { where "role = 'admin'" }, foreign_key: "admin_id"
	has_many :purchase_orders, dependent: :destroy
	has_many :purchases, dependent: :destroy
end
