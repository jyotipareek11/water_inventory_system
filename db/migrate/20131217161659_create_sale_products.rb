class CreateSaleProducts < ActiveRecord::Migration
  def change
    create_table :sale_products do |t|
      t.belongs_to :sale
      t.belongs_to :product
      t.integer :no_of_unit
      t.float :unit_price
      t.float :total_price
      t.float :discount
      t.float :price_after_discount

      t.timestamps
    end
  end
end
