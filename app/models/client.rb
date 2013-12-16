class Client < ActiveRecord::Base
	belongs_to :user, -> { where "role = 'distributor'" }, foreign_key: "distributor_id"#, dependent: :destroy#, -> { where "role = 'distributer'" }
end
