class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :location_id
      t.integer :distributor_id
      t.integer :added_by
      t.integer :modified_by
      t.belongs_to :user
      # t.integer :total_quantity
      # t.float :total_amout
      # t.float :discount
      # t.float :total_after_discount

      t.timestamps
    end
  end
end
