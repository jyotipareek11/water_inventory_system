class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.integer :distributor_id
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :pin
      t.string :email_id
      t.string :land_line_number
      t.string :mobile_no
      t.integer :added_by
      t.integer :modified_by

      t.timestamps
    end
  end
end
