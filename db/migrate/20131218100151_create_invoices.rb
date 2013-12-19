class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :no_of_unit
      # t.float :unit_price
      t.float :total_price
      t.float :discount
      t.string :price_after_discount
      t.boolean :received
      t.belongs_to :user
      t.references :invoiceable, polymorphic: true
      t.timestamps
    end
  end
end
