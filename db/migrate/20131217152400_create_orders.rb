class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :sales_id
      t.integer :added_by

      t.timestamps
    end
  end
end
