class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      # t.integer :no_of_unit
      # t.float :unit_price
      # t.float :total_price
      # t.float :discount
      # t.float :price_after_discount
      t.integer :added_by
      t.integer :modified_by
      t.belongs_to :user
      # t.belongs_to :product
      t.belongs_to :vendor

      t.timestamps
    end
  end
end
