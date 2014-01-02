class AddColumnParentSaleIdToPurchase < ActiveRecord::Migration
  def change
  	add_column :purchases, :parent_sale_id, :integer
  end
end
