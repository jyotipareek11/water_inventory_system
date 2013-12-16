class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :quantity
      t.belongs_to :product

      t.timestamps
    end
  end
end
