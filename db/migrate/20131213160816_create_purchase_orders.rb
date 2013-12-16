class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.integer :vendor_id
      t.integer :no_of_unit
      t.float :unit_price
      t.float :total_price
      t.float :discount
      t.float :price_after_discount
      t.integer :added_by
      t.integer :modified_by

      t.timestamps
    end
  end
end
