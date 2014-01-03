class Vendor < ActiveRecord::Base
	belongs_to :user, foreign_key: "admin_id"#, -> { where "role = 'admin'" }#
	#has_many :purchase_orders#, dependent: :destroy
	has_many :purchases#, dependent: :destroy

	validates :name, presence: true
end
