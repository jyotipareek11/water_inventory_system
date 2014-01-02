class AddColumnUserIdInInvouceProducts < ActiveRecord::Migration
  def change
  	add_column :invoice_products, :user_id, :integer
  end
end
