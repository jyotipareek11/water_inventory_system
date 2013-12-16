class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :added_by
      t.integer :modified_by

      t.timestamps
    end
  end
end
