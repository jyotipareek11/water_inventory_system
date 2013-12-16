class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.integer :user_id
      t.integer :modified_by
      t.datetime :modified_date
      t.timestamps
    end
  end
end
